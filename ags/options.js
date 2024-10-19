export const IconSubstitutes = {
    'transmission-gtk': 'transmission',
    'blueberry.py': 'blueberry',
    Caprine: 'facebook-messenger',
    'com.raggesilver.BlackBox-symbolic': 'terminal-symbolic',
    'org.wezfurlong.wezterm-symbolic': 'terminal-symbolic',
    'audio-headset-bluetooth': 'audio-headphones-symbolic',
    'audio-card-analog-usb': 'audio-speakers-symbolic',
    'audio-card-analog-pci': 'audio-card-symbolic',
    'preferences-system': 'emblem-system-symbolic',
    'com.github.Aylur.ags-symbolic': 'controls-symbolic',
    'com.github.Aylur.ags': 'controls-symbolic',
};

export default {
    icons: {
        fallback: {
            audio: 'audio-x-generic-symbolic',
            missing: 'computer-fail-symbolic',
        },
        menu: {
            right: 'media-playback-start-symbolic',
            left: 'media-playback-start-rtl-symbolic',
            selected: 'emblem-ok-symbolic',
        },
        media: {
            shuffle: {
                enabled: 'media-playlist-shuffle-symbolic',
                disabled: 'media-playlist-consecutive-symbolic',
            },
            loop: {
                none: 'media-playlist-repeat-symbolic',
                track: 'media-playlist-repeat-song-symbolic',
                playlist: 'media-playlist-repeat-symbolic',
            },
            playing: 'media-playback-start-symbolic',
            paused: 'media-playback-pause-symbolic',
            stopped: 'media-playback-stop-symbolic',
            prev: 'media-skip-backward-symbolic',
            next: 'media-skip-forward-symbolic',
            symbol: 'multimedia-video-player-symbolic',
        },
    },
    placeholders: {
        0: '(^°○°^)',
        1: '(>°○°)>',
        2: '<(°○°<)',
        3: '\\(♥‿♥)/',
    },
    recompileSass: true,
    theme: {
        PopupTransition: 'slide_down',
        PopupTransitionDuration: 400,
        PopupCloseDuration: 300,
        transitionDuration: 200,
        slowTransitionDuration: 500,
        colours: {
            rosewater: '#f5e0dc',
            flamingo: '#f2cdcd',
            pink: '#f5c2e7',
            mauve: '#cba6f7',
            red: '#f38ba8',
            maroon: '#eba0ac',
            peach: '#fab387',
            yellow: '#f9e2af',
            green: '#a6e3a1',
            teal: '#94e2d5',
            sky: '#89dceb',
            sapphire: '#74c7ec',
            blue: '#89b4fa',
            lavender: '#b4befe',
            text: '#cdd6f4',
            subtext1: '#bac2de',
            subtext0: '#a6adc8',
            overlay2: '#9399b2',
            overlay1: '#7f849c',
            overlay0: '#6c7086',
            surface2: '#585b70',
            surface1: '#45475a',
            surface0: '#313244',
            base: '#1e1e2e',
            mantle: '#181825',
            crust: '#11111b',
        },
    },
    date: {
        format: {
            time: '%H:%M',
            full_time: '%H:%M:%S',
            date: '%a, %d %B %Y',
        },
    },
    media: {
        widget: {
            width: 40,
            cover_size: 60,
            monochrome: true,
        },
        bar: {
            width: 30,
            rotate_freq: 25_000,
        },
        preferred: 'spotify',
    },
    battery: {
        type: 'circle', // bar or circle
        /*======================================*\
            emotes/face-hat-symbolic.svg
            emotes/face-embarrassed-symbolic.svg
            emotes/face-sad-symbolic.svg
            emotes/face-tired-symbolic.svg
            emotes/face-wink-symbolic.svg
            emotes/face-laugh-symbolic.svg
            emotes/face-sick-symbolic.svg
            emotes/face-devilish-symbolic.svg
            emotes/face-crying-symbolic.svg
            emotes/face-raspberry-symbolic.svg
            emotes/face-glasses-symbolic.svg
            emotes/face-yawn-symbolic.svg
            emotes/face-smirk-symbolic.svg
            emotes/face-cool-symbolic.svg
            emotes/face-plain-symbolic.svg
            emotes/face-surprise-symbolic.svg
            emotes/face-uncertain-symbolic.svg
            emotes/face-angel-symbolic.svg
            emotes/face-worried-symbolic.svg
            emotes/face-confused-symbolic.svg
            emotes/face-monkey-symbolic.svg
            emotes/face-angry-symbolic.svg
            emotes/face-smile-big-symbolic.svg
            emotes/face-smile-symbolic.svg
            emotes/face-kiss-symbolic.svg
            emotes/face-shutmouth-symbolic.svg
        \*======================================*/
        face: 'sad',
    },
    network: {
        poll_speed: 5, // seconds
    },
    control_centre: {
        name: 'control-centre',
        position: 'centre',
        width: 50,
        avatar: {
            path: '/home/klliio/Images/Avatar.png',
            size: 60,
        },
    },
    notifications: {
        name: 'notifications',
        position: 'right',
    },
    bar: {
        name: 'bar',
        workspaces: 9,
    },
};
