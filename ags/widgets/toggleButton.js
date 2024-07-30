import Options from '../options.js';
import { opened } from './misc.js';

const { icons, theme } = Options;

export const Arrow = (name, activate) => {
    let deg = 0;
    let iconOpened = false;
    const icon = Widget.Icon(icons.menu.left).hook(opened.menu, () => {
        if (
            (opened.menu.value === name && !iconOpened) ||
            (opened.menu.value !== name && iconOpened)
        ) {
            const step = opened.menu.value === name ? -20 : 20;
            iconOpened = !iconOpened;
            for (let i = 0; i < 9; ++i) {
                Utils.timeout(15 * i, () => {
                    deg += step;
                    icon.setCss(`-gtk-icon-transform: rotate(${deg}deg);`);
                });
            }
        }
    });
    return Widget.Button({
        child: icon,
        class_name: 'arrow',
        on_clicked: () => {
            opened.menu.value = opened.menu.value === name ? '' : name;
            if (typeof activate === 'function') activate();
        },
    });
};

export const ArrowToggleButton = ({
    name,
    icon,
    label,
    activate,
    deactivate,
    activateOnArrow = true,
    connection: [service, condition],
}) =>
    Widget.Box({
        class_name: 'toggle',
        setup: (self) => self.hook(service, () => self.toggleClassName('active', condition())),
        children: [
            Widget.Button({
                child: Widget.Box({
                    hexpand: true,
                    children: [
                        Widget.Icon({
                            class_name: 'icon',
                            icon,
                        }),
                        Widget.Label({
                            class_name: 'label',
                            max_width_chars: 11,
                            truncate: 'end',
                            label,
                        }),
                    ],
                }),
                on_clicked: () => {
                    if (condition()) {
                        deactivate();
                        if (opened.menu.value === name) opened.menu.value = '';
                    } else {
                        activate();
                    }
                },
            }),
            Arrow(name, activateOnArrow && activate),
        ],
    });

export const Menu = ({ name, title, content }) =>
    Widget.Revealer({
        transition: 'slide_right',
        transition_duration: theme.transitionDuration,
        reveal_child: opened.menu.bind().as((v) => v === name),
        child: Widget.Box({
            class_names: ['menu', name],
            vertical: true,
            vexpand: true,
            children: [
                Widget.Box({
                    class_name: 'title-box',
                    vertical: true,
                    children: [
                        Widget.Label({
                            class_name: 'title',
                            truncate: 'end',
                            label: title,
                        }),
                        Widget.Separator({
                            class_name: 'separator',
                            vertical: true,
                        }),
                    ],
                }),
                Widget.Box({
                    vertical: true,
                    class_name: 'content vertical',
                    children: content,
                }),
            ],
        }),
    });

export const Toggle = ({ icon, label, toggle, connection: [service, condition] }) =>
    Widget.Button({
        on_clicked: toggle,
        class_name: 'toggle',
        setup: (self) =>
            self.hook(service, () => {
                self.toggleClassName('active', condition());
            }),
        child: Widget.Box([
            Widget.Icon({ icon }),
            Widget.Label({
                max_width_chars: 11,
                truncate: 'end',
                label,
            }),
        ]),
    });
