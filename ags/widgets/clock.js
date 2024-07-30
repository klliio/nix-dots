import GLib from 'gi://GLib';
import Options from '../options.js';

const { date, control_centre } = Options;

const clock = Variable(GLib.DateTime.new_now_local(), {
    poll: [1000, () => GLib.DateTime.new_now_local()],
});

const uptime = Variable(0, {
    poll: [60_000, 'cat /proc/uptime', (line) => Number.parseInt(line.split('.')[0]) / 60],
});

function up(up) {
    const h = Math.floor(up / 60);
    const m = Math.floor(up % 60);
    return `uptime: ${h}:${m < 10 ? '0' + m : m}`;
}

export const ClockIndicator = (format = date.format.time) =>
    Widget.Button({
        class_name: 'clock',
        on_primary_click: () => App.toggleWindow(control_centre.name),
        child: Widget.Label({
            label: clock.bind().as((t) => t.format(format) || ''),
        }),
    });

const FullTime = (format) =>
    Widget.Label({
        class_name: 'full-time',
        label: clock.bind().as((t) => t.format(format) || ''),
    });

const Date = (format) =>
    Widget.Label({
        class_name: 'date',
        label: clock.bind().as((t) => t.format(format) || ''),
    });

const Uptime = () =>
    Widget.Label({
        class_name: 'uptime',
        label: uptime.bind().as(up),
    });

const Calendar = () =>
    Widget.Calendar({
        showDayNames: false,
        showDetails: true,
        showHeading: true,
        showWeekNumbers: false,
    });

const TimeBox = (time_format = date.format.full_time, date_format = date.format.date) =>
    Widget.Box({
        vertical: true,
        children: [FullTime(time_format), Date(date_format), Uptime()],
    });

export const CalendarBox = () =>
    Widget.Box({
        class_name: 'calendar',
        vertical: true,
        children: [TimeBox(), Calendar()],
    });
