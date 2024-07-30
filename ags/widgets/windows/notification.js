import Options from '../../options.js';
import Popup from '../popup.js';

const { notifications, theme } = Options;
const WINDOW_NAME = notifications.name;

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

const ControlCentre = () =>
    Popup({
        name: WINDOW_NAME,
        transition: theme.PopupTransition,
        transition_duration: theme.PopupTransitionDuration,
        layout: notifications.position,
        exclusivity: 'exclusive',
        child:
    });

export default function () {
    App.addWindow(ControlCentre());
}
