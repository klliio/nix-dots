const bluetooth = await Service.import('bluetooth');
import { ArrowToggleButton, Menu } from './toggleButton.js';
import Options from '../options.js';

const { icons } = Options;

const icon = Variable(
    bluetooth
        .bind('connected_devices')
        .as((connected) => `bluetooth-${connected[0] ? 'active' : 'disabled'}-symbolic`)
);

export const BluetoothIndicator = (reveal = Variable(false)) =>
    Widget.EventBox({
        class_names: ['bluetooth', 'bar'],
        setup: (self) => self.on('leave-notify-event', () => (reveal.value = false)),
        child: Widget.Box({
            vertical: false,
            spacing: 0,
            children: [
                Widget.EventBox({
                    on_primary_click: () => (reveal.value = !reveal.value),
                    child: Widget.Icon({
                        icon: bluetooth
                            .bind('connected_devices')
                            .as(
                                (connected) =>
                                    `bluetooth-${connected[0] ? 'active' : 'disabled'}-symbolic`
                            ),
                    }),
                }),
                Widget.Revealer({
                    reveal_child: reveal.bind(),
                    transition: 'slide_right',
                    transition_duration: Options.theme.transitionDuration,
                    child: Widget.Label({
                        label: bluetooth
                            .bind('connected_devices')
                            .as((connected) => (connected[0] ? connected[0].name : 'Disconnected')),
                    }),
                }),
            ],
        }),
    });

const Device = (device) =>
    Widget.Button({
        on_clicked: () => device.setConnection(!device.connected),
        child: Widget.Box({
            children: [
                Widget.Icon({ class_name: 'type', icon: device.icon_name }),
                Widget.Label({
                    class_name: 'name',
                    label: device.name,
                    truncate: 'end',
                    max_width_chars: 13,
                }),
                Widget.Box({ hexpand: true }),
                Widget.Label({ class_name: 'battery', label: device.battery_percentage + '%' }),
                Widget.Spinner({
                    active: device.bind('connecting'),
                    visible: device.bind('connecting'),
                }),
                Widget.Icon({
                    class_name: 'selected',
                    icon: icons.menu.selected,
                    visible: device.bind('connected'),
                }),
            ],
        }),
    });

export const BluetoothDeviceSelection = () =>
    Menu({
        name: 'bluetooth',
        title: 'Bluetooth Devices',
        content: [
            Widget.Scrollable({
                hscroll: 'never',
                vscroll: 'automatic',
                vexpand: true,
                child: Widget.Box({
                    vertical: true,
                    class_name: 'devices',
                    children: bluetooth
                        .bind('devices')
                        .as((devices) => devices.filter((d) => d.name).map(Device)),
                }),
            }),
        ],
    });

export const BluetoothToggle = () =>
    ArrowToggleButton({
        name: 'bluetooth',
        icon: icon.value,
        label: bluetooth
            .bind('connected_devices')
            .as((connected) => (connected[0] ? connected[0].name : 'Not Connected')),
        connection: [bluetooth, () => bluetooth.enabled],
        deactivate: () => (bluetooth.enabled = false),
        activate: () => (bluetooth.enabled = true),
    });
