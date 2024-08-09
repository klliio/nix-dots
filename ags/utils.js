import Options from './options.js';
import { IconSubstitutes } from './options.js';
import GLib from 'gi://GLib?version=2.0';

const icons = Options;

/** Checks for missing binaries
 * @returns bool
 */
export function dependencies(...bins) {
    const missing = bins.filter((bin) => {
        return !Utils.exec(`which ${bin}`);
    });

    if (missing.length > 0) {
        console.warn('missing dependencies:', missing.join(', '));
        Utils.notify(`missing dependencies: ${missing.join(', ')}`);
    }

    return missing.length === 0;
}

/** Checks if an icon exists
 * @returns bool
 */
export function icon(name, fallback = icons.fallback.missing) {
    if (!name) return fallback || '';

    if (GLib.file_test(name, GLib.FileTest.EXISTS)) return name;

    const icon = IconSubstitutes[name] || name;
    if (Utils.lookUpIcon(icon)) return icon;

    print(
        `[LOG] no icon substitute "${icon}" for "${name}", fallback: "${fallback}"`
    );
    return fallback;
}

export function sh(cmd) {
    return Utils.execAsync(cmd).catch((err) => {
        console.error(typeof cmd === 'string' ? cmd : cmd.join(' '), err);
        return '';
    });
}

export function range(length, start = 1) {
    return Array.from({ length }, (_, i) => i + start);
}
