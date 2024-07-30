const audio = await Service.import('audio');
import { Menu, ArrowToggleButton } from './toggleButton.js';
import { RevealingSlider, LongSlider } from './sliders.js';
import Options from '../options.js';

const SpeakerIcon = Variable('audio-volume-medium-symbolic');
const SpeakerVolumnIcon = Variable('');
const MicrophoneIcon = Variable('audio-volume-medium-symbolic');
const { speaker, microphone } = audio;
const { icons, control_centre } = Options;

const GetVolumeIcon = (device) => {
    if (device.is_muted) {
        return 'muted';
    }

    const vol = device.volume * 100;
    const icon = [
        [67, 'high'],
        [34, 'medium'],
        [0, 'low'],
    ].find(([threshold]) => threshold <= vol)?.[1];

    return icon;
};

audio.connect('speaker-changed', () => {
    SpeakerIcon.value = `audio-volume-${GetVolumeIcon(speaker)}-symbolic`;
});

audio.connect('microphone-changed', () => {
    MicrophoneIcon.value = `audio-input-microphone-${GetVolumeIcon(microphone)}-symbolic`;
});

export const AudioIndicator = () =>
    RevealingSlider({
        icon: SpeakerIcon.bind(),
        pass_value: speaker.bind('volume').as((v) => v * 100),
        on_click: () => (speaker.is_muted = !speaker.is_muted),
        on_change: (value) => (speaker.volume = value / 100),
        class_name: 'audio',
    });

const Speaker = (device) =>
    Widget.Button({
        on_clicked: () => (device.is_muted = !device.is_muted),
        child: Widget.Box({
            children: [
                Widget.Icon({
                    class_name: 'volume',
                    setup: (self) =>
                        self.hook(device, () => {
                            self.icon = `audio-volume-${GetVolumeIcon(device)}-symbolic`;
                        }),
                }),
                Widget.Label({
                    class_name: 'device',
                    label: device.description,
                    truncate: 'end',
                    max_width_chars: 13,
                }),
                Widget.Box({ hexpand: true }),
                Widget.Icon({
                    class_name: 'selected',
                    icon: icons.menu.selected,
                    visible: device.bind('is_muted').as((status) => !status),
                }),
            ],
        }),
    });

const Microphone = (device) =>
    Widget.Button({
        on_clicked: () => (device.is_muted = !device.is_muted),
        child: Widget.Box({
            children: [
                Widget.Icon({
                    class_name: 'volume',
                    setup: (self) =>
                        self.hook(device, () => {
                            self.icon = `audio-input-microphone-${GetVolumeIcon(device)}-symbolic`;
                        }),
                }),
                Widget.Label({
                    class_name: 'device',
                    label: device.description,
                    truncate: 'end',
                    max_width_chars: 13,
                }),
                Widget.Box({ hexpand: true }),
                Widget.Icon({
                    class_name: 'selected',
                    icon: icons.menu.selected,
                    visible: device.bind('is_muted').as((status) => !status),
                }),
            ],
        }),
    });

export const AudioSpeakerMenu = () =>
    Menu({
        name: 'speaker',
        title: 'Speakers',
        content: [
            Widget.Scrollable({
                hscroll: 'never',
                vscroll: 'automatic',
                vexpand: true,
                child: Widget.Box({
                    vertical: true,
                    class_name: 'devices',
                    children: audio
                        .bind('speakers')
                        .as((devices) => devices.filter((d) => d.description).map(Speaker)),
                }),
            }),
        ],
    });

export const AudioMicrophoneMenu = () =>
    Menu({
        name: 'microphone',
        title: 'Microphones',
        content: [
            Widget.Scrollable({
                hscroll: 'never',
                vscroll: 'automatic',
                vexpand: true,
                child: Widget.Box({
                    vertical: true,
                    class_name: 'devices',
                    children: audio
                        .bind('microphones')
                        .as((devices) => devices.filter((d) => d.description).map(Microphone)),
                }),
            }),
        ],
    });

export const AudioSpeakerToggle = () =>
    ArrowToggleButton({
        name: 'speaker',
        icon: SpeakerIcon.bind(),
        label: speaker.bind('description'),
        connection: [speaker, () => !speaker.is_muted],
        deactivate: () => (speaker.is_muted = true),
        activate: () => (speaker.is_muted = false),
    });

export const AudioMicrophoneToggle = () =>
    ArrowToggleButton({
        name: 'microphone',
        icon: MicrophoneIcon.bind(),
        label: microphone.bind('description'),
        connection: [microphone, () => !microphone.is_muted],
        deactivate: () => (microphone.is_muted = true),
        activate: () => (microphone.is_muted = false),
    });

export const AudioSpeakerLongSlider = () =>
    LongSlider({
        vertical: true,
        spacing: 5,
        icon: SpeakerIcon.bind(),
        pass_value: speaker.bind('volume').as((v) => v * 100),
        on_change: (value) => (speaker.volume = value / 100),
        on_click: () => (speaker.is_muted = !speaker.is_muted),
        class_name: 'audio',
    });

export const AudioMicrophoneLongSlider = () =>
    LongSlider({
        vertical: true,
        spacing: 5,
        icon: MicrophoneIcon.bind(),
        pass_value: microphone.bind('volume').as((v) => v * 100),
        on_change: (value) => (microphone.volume = value / 100),
        on_click: () => (microphone.is_muted = !microphone.is_muted),
        class_name: 'audio',
    });
