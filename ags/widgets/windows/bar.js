import { NetworkIndicator } from '../network.js';
import { BluetoothIndicator } from '../bluetooth.js';
import { BacklightIndicator } from '../backlight.js';
import { ClockIndicator } from '../clock.js';
import { Seperator } from '../misc.js';
import Options from '../../options.js';
import { BatteryIndicator } from '../battery.js';
import { AudioIndicator } from '../audio.js';
import { MediaLabel } from '../media.js';

const { date, bar } = Options;
const WINDOW_NAME = bar.name;

// layout of the bar
function Left() {
    return Widget.Box({
        class_name: 'left',
        hpack: 'start',
        spacing: 6,
        children: [BatteryIndicator(), Seperator({ vertical: true }), MediaLabel()],
    });
}

function Center() {
    return Widget.Box({
        class_name: 'center',
        hpack: 'center',
        spacing: 6,
        children: [],
    });
}

function Right() {
    return Widget.Box({
        class_name: 'right',
        hpack: 'end',
        spacing: 6,
        children: [
            NetworkIndicator(),
            BluetoothIndicator(),
            BacklightIndicator(),
            AudioIndicator(),
            Seperator({ vertical: true }),
            ClockIndicator(date.format.time),
        ],
    });
}

function BarWindow() {
    return Widget.Window({
        name: WINDOW_NAME, // name has to be unique
        layer: 'bottom',
        margins: [0, 0, 0, 0], // [top, right, bottom, left]
        anchor: ['top', 'left', 'right'],
        exclusivity: 'exclusive',
        child: Widget.CenterBox({
            start_widget: Left(),
            // center_widget: Center(),
            end_widget: Right(),
        }),

        /*                                            *\
            makes things that rely on on_hover_lost
            behave when exiting the window

            this is to make it so that padding around 
            the window is not needed
        \*                                            */
        setup: (self) => self.on('leave-notify-event', () => { }),
    });
}

export default function() {
    App.addWindow(BarWindow());
    Utils.timeout(100, () => {
        App.openWindow(WINDOW_NAME);
    });
}
