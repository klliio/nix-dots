import Backlight from '../service/backlight.js';
import { RevealingSlider, LongSlider } from './sliders.js';

export const BacklightIndicator = () =>
    RevealingSlider({
        icon: Backlight.bind('icon_name'),
        pass_value: Backlight.bind('brightness').as((b) => b * 100),
        on_click: function() { },
        on_change: (value) => (Backlight.brightness = value / 100),
        class_name: 'backlight',
    });

export const BacklightLongSlider = () =>
    LongSlider({
        vertical: true,
        spacing: 5,
        icon: Backlight.bind('icon_name'),
        pass_value: Backlight.bind('brightness').as((b) => b * 100),
        on_change: (value) => (Backlight.brightness = value / 100),
        on_click: () => function() { },
        class_name: 'backlight',
    });
