const mpris = await Service.import('mpris');
import Options from '../options.js';
import { Row, Column, Padding, opened } from './misc.js';
import { icon } from '../utils.js';

const { icons, media, theme, placeholders } = Options;
const players = mpris.bind('players');
const label_reveal = Variable(false);

function lengthStr(length) {
    const min = Math.floor(length / 60);
    const sec = Math.floor(length % 60);
    const sec0 = sec < 10 ? '0' : '';

    if ([length, min, sec, sec0].includes(NaN)) {
        return '';
    }

    return `${min}:${sec0}${sec}`;
}

export const MediaLabel = () =>
    Widget.Button({
        on_primary_click: () => App.toggleWindow(media.name),
        child: Widget.Box({
            spacing: 8,
            children: [
                Widget.Revealer({
                    reveal_child: label_reveal.bind(),
                    transition: 'slide_right',
                    transition_duration: theme.transitionDuration,
                    child: Widget.Label({
                        truncate: 'end',
                        max_width_chars: media.bar.width,
                    }).hook(mpris, (self) => {
                        const player =
                            mpris.getPlayer(media.preferred) ||
                            mpris.getPlayer();
                        if (!player || media.play_back_status === 'Stopped') {
                            label_reveal.value = false;
                            return;
                        }
                        label_reveal.value = true;
                        self.label =
                            player?.track_title + ' - ' + player?.track_artists;
                    }),
                }),
                Widget.Revealer({
                    reveal_child: label_reveal.bind().as((b) => !b),
                    transition: 'slide_left',
                    transition_duration: theme.transitionDuration,
                    child: Widget.Label({
                        label: placeholders[0],
                    }),
                }),
            ],
        }),
    });

const Player = (player) => {
    const Cover = Widget.Box({
        class_name: 'cover',
        hpack: 'center',
        vpack: 'center',
        css: player.bind('cover_path').as(
            (path) => `
            min-width: ${media.widget.cover_size}px;
            min-height: ${media.widget.cover_size}px;
            background-size: cover;
            background-image: url('${path}');
            background-color: red;
            background-repeat:no-repeat;
            background-position: center center;
        `
        ),
    });

    const Title = Widget.Label({
        class_name: 'title',
        max_width_chars: media.widget.width,
        truncate: 'end',
        hpack: 'start',
        wrap: true,
        label: player.bind('track_title'),
    });

    const Artists = Widget.Label({
        class_name: 'artists',
        max_width_chars: media.widget.width,
        truncate: 'end',
        hpack: 'start',
        label: player.bind('track_artists').as((a) => a.join(', ')),
    });

    const PositionSlider = Widget.Slider({
        class_names: ['position', 'slider'],
        draw_value: false,
        on_change: ({ value }) => (player.position = value * player.length),
        setup: (self) => {
            const update = () => {
                const { length, position } = player;
                self.visible = length > 0;
                self.value = length > 0 ? position / length : 0;
            };
            self.hook(player, update);
            self.hook(player, update, 'position');
            self.poll(1000, update);
        },
    });

    const PositionLabel = Widget.Label({
        class_names: ['position', 'label'],
        hpack: 'start',
        setup: (self) => {
            const update = (_, time) => {
                self.label = lengthStr(time || player.position);
                self.visible = player.length > 0;
            };
            self.hook(player, update, 'position');
            self.poll(1000, update);
        },
    });

    const LengthLabel = Widget.Label({
        class_name: 'length',
        hpack: 'end',
        visible: player.bind('length').as((l) => l > 0),
        label: player.bind('length').as(lengthStr),
    });

    const PlayerIcon = Widget.Icon({
        class_name: 'icon',
        vpack: 'start',
        icon: player.bind('entry').as((e) => {
            const name = `${e}${media.widget.monochrome ? '-symbolic' : ''}`;
            return icon(name, icons.fallback.audio);
        }),
    });

    const PlayPause = Widget.Button({
        class_name: 'play-pause',
        on_clicked: () => player.playPause(),
        visible: player.bind('can_play'),
        child: Widget.Icon({
            icon: player.bind('play_back_status').as((s) => {
                switch (s) {
                    case 'Playing':
                        return icons.media.playing;
                    case 'Paused':
                        return icons.media.paused;
                    case 'Stopped':
                        return icons.media.paused;
                }
            }),
        }),
    });

    const Prev = Widget.Button({
        on_clicked: () => player.previous(),
        visible: player.bind('can_go_prev'),
        child: Widget.Icon(icons.media.prev),
    });

    const Next = Widget.Button({
        on_clicked: () => player.next(),
        visible: player.bind('can_go_next'),
        child: Widget.Icon(icons.media.next),
    });

    return Widget.Box({
        class_name: 'player',
        vexpand: false,
        children: [
            Row({
                children: [
                    Cover,
                    Column({
                        children: [
                            Row({
                                children: [Title, Padding(), PlayerIcon],
                            }),
                            Artists,
                            PositionSlider,
                            Widget.CenterBox({
                                spacing: 0,
                                start_widget: PositionLabel,
                                center_widget: Row({
                                    children: [Prev, PlayPause, Next],
                                    class_name: 'buttons',
                                    spacing: 8,
                                }),
                                end_widget: LengthLabel,
                            }),
                        ],
                    }),
                ],
                spacing: 15,
            }),
        ],
    });
};

export const MediaBox = ({ name, ...rest }) =>
    Widget.Revealer({
        reveal_child: opened.popout.bind().as((v) => v === name),
        child: Widget.Box({
            vertical: true,
            spacing: 0,
            class_name: 'media',
            children: players.as((p) => p.map(Player)),
            ...rest,
        }),
    });

export const MediaButton = ({ name }) => {
    let deg = 0;
    let iconOpened = false;
    const icon = Widget.Icon(icons.media.symbol).hook(opened.popout, () => {
        if (
            (opened.popout.value === name && !iconOpened) ||
            (opened.popout.value !== name && iconOpened)
        ) {
            const step = opened.popout.value === name ? 20 : -20;
            iconOpened = !iconOpened;
            for (let i = 0; i < 18; ++i) {
                Utils.timeout(15 * i, () => {
                    deg += step;
                    icon.setCss(`-gtk-icon-transform: rotate(${deg}deg);`);
                });
            }
        }
    });

    return Widget.Button({
        class_names: ['media', 'button'],
        child: icon,
        on_clicked: () =>
            (opened.popout.value = opened.popout.value === name ? '' : name),
    });
};
