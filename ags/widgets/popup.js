const Padding = (name, css = '', hexpand = true, vexpand = true) =>
    Widget.EventBox({
        hexpand,
        vexpand,
        can_focus: false,
        child: Widget.Box({ css }),
        setup: (w) => w.on('button-press-event', () => App.toggleWindow(name)),
    });

const PopupRevealer = ({ name, child, transition, transition_duration }) =>
    Widget.Box(
        { css: 'padding: 1px;', class_name: 'popup-borderbox' },
        Widget.Revealer({
            transition,
            child: Widget.Box({
                class_name: 'window-content',
                child,
            }),
            transitionDuration: transition_duration,
            setup: (self) =>
                self.hook(App, (_, wname, visible) => {
                    if (wname === name) self.reveal_child = visible;
                }),
        })
    );

const Layout = ({ name, child, transition, transition_duration }) => ({
    centre: () =>
        Widget.CenterBox(
            {},
            Padding(name),
            Widget.CenterBox(
                { vertical: true },
                Padding(name),
                PopupRevealer({ name, transition, transition_duration, child }),
                Padding(name)
            ),
            Padding(name)
        ),
    top: () =>
        Widget.CenterBox(
            {},
            Padding(name),
            Widget.Box(
                { vertical: true },
                PopupRevealer({ name, transition, transition_duration, child }),
                Padding(name)
            ),
            Padding(name)
        ),
    'top-right': () =>
        Widget.Box(
            {},
            Padding(name),
            Widget.Box(
                {
                    hexpand: false,
                    vertical: true,
                },
                PopupRevealer({ name, transition, transition_duration, child }),
                Padding(name)
            )
        ),
    'top-center': () =>
        Widget.Box(
            {},
            Padding(name),
            Widget.Box(
                {
                    hexpand: false,
                    vertical: true,
                },
                PopupRevealer({ name, transition, transition_duration, child }),
                Padding(name)
            ),
            Padding(name)
        ),
    'top-left': () =>
        Widget.Box(
            {},
            Widget.Box(
                {
                    hexpand: false,
                    vertical: true,
                },
                PopupRevealer({ name, transition, transition_duration, child }),
                Padding(name)
            ),
            Padding(name)
        ),
    'bottom-left': () =>
        Widget.Box(
            {},
            Widget.Box(
                {
                    hexpand: false,
                    vertical: true,
                },
                Padding(name),
                PopupRevealer({ name, transition, transition_duration, child })
            ),
            Padding(name)
        ),
    'bottom-center': () =>
        Widget.Box(
            {},
            Padding(name),
            Widget.Box(
                {
                    hexpand: false,
                    vertical: true,
                },
                Padding(name),
                PopupRevealer({ name, transition, transition_duration, child })
            ),
            Padding(name)
        ),
    'bottom-right': () =>
        Widget.Box(
            {},
            Padding(name),
            Widget.Box(
                {
                    hexpand: false,
                    vertical: true,
                },
                Padding(name),
                PopupRevealer({ name, transition, transition_duration, child })
            )
        ),
    right: () =>
        Widget.Box(
            {},
            Padding(name),
            Widget.Box(
                {
                    hexpand: false,
                    vertical: true,
                },
                // Padding(name),
                PopupRevealer({ name, transition, transition_duration, child })
            )
        ),
});

export default ({
    name,
    child,
    layout = 'center',
    transition,
    transition_duration,
    exclusivity = 'ignore',
}) =>
    Widget.Window({
        name,
        class_names: [name, 'popup-window'],
        visible: false,
        keymode: 'exclusive', // doesn't capture events unless it is using exclusive
        exclusivity,
        layer: 'top',
        anchor: ['top', 'bottom', 'right', 'left'],
        child: Layout({ name, child, transition, transition_duration })[layout](),
        setup: (self) => self.keybind('Escape', () => App.closeWindow(name)),
    });
