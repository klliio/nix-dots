import Options from '../../options.js';
import Popup from '../popup.js';
import { CalendarBox } from '../clock.js';
import { BatteryLabel, BatteryTime } from '../battery.js';
import {
    NetworkIp,
    NetworkWifiToggle,
    NetworkWifiSelection,
} from '../network.js';
import {
    AudioSpeakerToggle,
    AudioMicrophoneToggle,
    AudioSpeakerMenu,
    AudioMicrophoneMenu,
    AudioSpeakerLongSlider,
    AudioMicrophoneLongSlider,
} from '../audio.js';
import { BacklightLongSlider } from '../backlight.js';
import { MediaButton, MediaBox } from '../media.js';
import { BluetoothToggle, BluetoothDeviceSelection } from '../bluetooth.js';
import { Row, Column, Padding, Filler, opened } from '../misc.js';

const { control_centre, theme } = Options;
const WINDOW_NAME = control_centre.name;

const Avatar = () =>
    Widget.Box({
        class_name: 'avatar',
        css: `
            min-width: ${control_centre.avatar.size}px;
            min-height: ${control_centre.avatar.size}px;
            background-image: url('${control_centre.avatar.path}');
            background-size: cover; `,
        hpack: 'center',
        vpack: 'center',
    });

export default () =>
    Popup({
        name: WINDOW_NAME,
        transition: theme.PopupTransition,
        transition_duration: theme.PopupTransitionDuration,
        layout: control_centre.position,
        exclusivity: 'exclusive',
        child: Column({
            children: [
                Row({
                    children: [
                        Row({
                            children: [
                                Column({
                                    children: [
                                        Row({
                                            children: [
                                                Avatar(),
                                                Column({
                                                    children: [
                                                        BatteryLabel(),
                                                        BatteryTime(),
                                                        NetworkIp(),
                                                    ],
                                                    vpack: 'center',
                                                    spacing: 2,
                                                }),
                                            ],
                                            spacing: 8,
                                            class_name: 'header',
                                        }),
                                        Column({
                                            children: [
                                                NetworkWifiToggle(),
                                                BluetoothToggle(),
                                                AudioSpeakerToggle(),
                                                AudioMicrophoneToggle(),
                                            ],
                                            spacing: 14,
                                            class_name: 'toggles',
                                        }),
                                    ],
                                    spacing: 15,
                                }),
                                Row({
                                    children: [
                                        NetworkWifiSelection(),
                                        BluetoothDeviceSelection(),
                                        AudioSpeakerMenu(),
                                        AudioMicrophoneMenu(),
                                    ],
                                    class_name: 'menus',
                                }),
                            ],

                            // change spacing to 0 when not showing to avoid extra space
                            // see more in .config/ags/examples/menu-spacing/
                            setup: (self) =>
                                self.hook(
                                    opened.menu,
                                    (self) =>
                                        (self.spacing =
                                            opened.menu.value != '' ? 15 : 0)
                                ),
                        }),
                        Row({
                            children: [
                                AudioMicrophoneLongSlider(),
                                AudioSpeakerLongSlider(),
                                BacklightLongSlider(),
                            ],
                            vpack: 'fill',
                            class_name: 'sliders',
                            spacing: 5,
                        }),
                        Column({
                            children: [
                                CalendarBox(),
                                Row({
                                    children: [
                                        MediaButton({ name: 'media' }),
                                        Filler(),
                                    ],
                                    spacing: 15,
                                }),
                            ],
                            spacing: 15,
                        }),
                    ],
                    spacing: 15,
                    class_name: 'main',
                }),
                Row({ children: [MediaBox({ name: 'media' })] }),
            ],
        }),
    });
