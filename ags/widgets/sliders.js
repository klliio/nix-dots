import Options from '../options.js';

export const RevealingSlider = ({
    icon,
    pass_value,
    on_click,
    on_change,
    class_name,
    reveal = Variable(false),
    spacing = 0,
    vertical = false,
    inverted = false,
}) =>
    Widget.EventBox({
        setup: (self) => self.on('leave-notify-event', () => (reveal.value = false)),
        class_names: [class_name, 'revealing-slider'],
        child: Widget.Box({
            vertical: vertical,
            spacing: spacing,
            children: [
                Widget.EventBox({
                    on_primary_click: () => (reveal.value = !reveal.value),
                    on_secondary_click: on_click,
                    child: Widget.Icon({
                        icon: icon,
                    }),
                }),
                Widget.Revealer({
                    reveal_child: reveal.bind(),
                    transition: 'slide_right',
                    transition_duration: Options.theme.transitionDuration,
                    child: Widget.Slider({
                        vertical: vertical,
                        inverted: inverted,
                        draw_value: false,
                        min: 0,
                        max: 100,
                        value: pass_value,
                        on_change: ({ value }) => on_change(value),
                    }),
                }),
            ],
        }),
    });

export const LongSlider = ({
    vertical = true,
    inverted = true,
    spacing = 0,
    icon,
    pass_value,
    on_change,
    on_click,
    class_name,
}) =>
    Widget.Box({
        vexpand: true,
        spacing: spacing,
        class_names: [class_name, 'long-slider'],
        vertical: vertical,
        children: [
            Widget.Slider({
                vexpand: true,
                vertical: vertical,
                inverted: inverted,
                draw_value: false,
                min: 0,
                max: 100,
                value: pass_value,
                on_change: ({ value }) => on_change(value),
            }),
            Widget.Button({
                on_clicked: () => on_click(),
                child: Widget.Icon({
                    icon: icon,
                }),
            }),
        ],
    });
