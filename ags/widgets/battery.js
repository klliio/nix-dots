import Options from '../options.js';
const battery = await Service.import('battery');

const Circle = () =>
    Widget.CircularProgress({
        class_name: 'circle',
        startAt: 0.75,
        value: battery.bind('percent').as((p) => p / 100),
        child: Widget.Icon({
            icon: `face-${Options.battery.face}-symbolic`,
        }),
    });

const bar_reveal = Variable(false);
const Bar = () =>
    Widget.Box({
        class_name: 'bar',
        spacing: 0,
        children: [
            Widget.EventBox({
                child: Widget.Icon({
                    icon: battery.bind('icon_name'),
                }),
                on_hover: () => (bar_reveal.value = true),
                setup: (self) => self.on('leave-notify-event', () => (bar_reveal.value = false)),
            }),
            Widget.Revealer({
                reveal_child: bar_reveal.bind(),
                transition: 'slide_right',
                transition_duration: Options.theme.transitionDuration,
                child: Widget.LevelBar({
                    widthRequest: 10,
                    bar_mode: 'discrete',
                    max_value: 10,
                    value: battery.bind('percent').as((p) => p / 10),
                }),
            }),
        ],
    });

const indicator_type = Variable(Options.battery.type || 'circle');
export const BatteryIndicator = () =>
    Widget.Stack({
        class_names: ['battery', 'bar'],
        children: {
            circle: Circle(),
            bar: Bar(),
        },
        shown: indicator_type.bind(),
    });

export const BatteryLabel = () =>
    Widget.Box({
        spacing: 5,
        class_names: ['battery', 'control-centre'],
        children: [
            Widget.Icon({
                icon: battery.bind('icon_name'),
            }),
            Widget.Label({
                label: battery.bind('percent').as((p) => p.toString() + '%'),
            }),
        ],
    });

export const BatteryTime = () =>
    Widget.Box({
        spacing: 5,
        class_names: ['battery', 'control-centre'],
        children: [
            Widget.Icon({
                icon: `timer-symbolic`,
            }),
            Widget.Label({
                label: battery.bind('time_remaining').as((t) => t.toString()),
            }),
        ],
    });
