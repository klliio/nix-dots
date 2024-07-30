const network_service = await Service.import('network');
import Options from '../options.js';
import { dependencies } from '../utils.js';
import { Menu, ArrowToggleButton } from './toggleButton.js';

const { network, theme, icons } = Options;
const { wifi, wired } = network_service;

const speed = Variable('Be Patient', {
    listen: App.configDir + `/scripts/network-info.sh -s --icons -p ${network.poll_speed}`,
});
const ip = Variable('Be Patient', {
    listen: App.configDir + `/scripts/network-info.sh -i -p ${network.poll_speed}`,
});

const Icon = () =>
    Widget.Icon().hook(network_service, (self) => {
        const icon = network_service[network_service.primary || 'wifi']?.icon_name;
        self.icon = icon || '';
        self.visible = !!icon;
    });

export const NetworkIndicator = (reveal = Variable(false)) =>
    Widget.EventBox({
        class_names: ['network', 'bar'],
        setup: (self) => self.on('leave-notify-event', () => (reveal.value = false)),
        child: Widget.Box({
            vertical: false,
            spacing: 0,
            children: [
                Widget.EventBox({
                    on_primary_click: () => (reveal.value = !reveal.value),
                    child: Icon(),
                }),
                Widget.Revealer({
                    reveal_child: reveal.bind(),
                    transition: 'slide_right',
                    transition_duration: theme.transitionDuration,
                    child: Widget.Label({
                        label: speed.bind(),
                    }),
                }),
            ],
        }),
    });

export const NetworkIp = () =>
    Widget.Box({
        spacing: 3,
        class_names: ['network', 'control-centre'],
        children: [Icon(), Widget.Label({ label: ip.bind() })],
    });

export const NetworkWifiSelection = () =>
    Menu({
        name: 'network',
        title: 'Wifi Selection',
        content: [
            Widget.Scrollable({
                hscroll: 'never',
                vscroll: 'automatic',
                vexpand: true,
                child: Widget.Box({
                    vertical: true,
                    setup: (self) =>
                        self.hook(
                            wifi,
                            () =>
                            (self.children = wifi.access_points.map((ap) =>
                                Widget.Button({
                                    on_clicked: () => {
                                        if (dependencies('nmcli'))
                                            Utils.execAsync(
                                                `nmcli device wifi connect ${ap.bssid}`
                                            );
                                    },
                                    child: Widget.Box({
                                        children: [
                                            Widget.Icon({
                                                icon: ap.iconName,
                                                class_name: 'signal',
                                            }),
                                            Widget.Label({
                                                label: ap.ssid || '',
                                                class_name: 'ap-name',
                                                truncate: 'end',
                                                max_width_chars: 13,
                                            }),
                                            Widget.Box({
                                                hexpand: true,
                                            }),
                                            Widget.Icon({
                                                icon: icons.menu.selected,
                                                class_name: 'selected',
                                                hexpand: true,
                                                hpack: 'end',
                                                setup: (self) =>
                                                    Utils.idle(() => {
                                                        if (!self.is_destroyed)
                                                            self.visible = ap.active;
                                                    }),
                                            }),
                                        ],
                                    }),
                                })
                            ))
                        ),
                }),
            }),
        ],
    });

export const NetworkWifiToggle = () =>
    ArrowToggleButton({
        name: 'network',
        icon: wifi.bind('icon_name'),
        label: wifi.bind('ssid').as((ssid) => ssid || 'Not Connected'),
        connection: [wifi, () => wifi.enabled],
        deactivate: () => (wifi.enabled = false),
        activate: () => {
            wifi.enabled = true;
            Utils.timeout(500, () => wifi.scan());
        },
    });
