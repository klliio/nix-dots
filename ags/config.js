import GLib from 'gi://GLib';
import Bar from './widgets/windows/bar.js';
import ControlCentre from './widgets/windows/control-centre.js';
import Options from './options.js';
const hyprland = await Service.import('hyprland');

print(`[LOG] Config Dir: ${App.configDir}`);

async function applyStyle() {
    const COMPILED_STYLE_DIR = `${GLib.get_user_cache_dir()}/ags/user/generated`;
    print(`[LOG] Style Dir: ${COMPILED_STYLE_DIR}`);
    if (Options.recompileSass) {
        Utils.exec(`mkdir -p ${COMPILED_STYLE_DIR}`);
        Utils.exec(
            `sassc ${App.configDir}/scss/main.scss ${COMPILED_STYLE_DIR}/style.css`
        );
    }
    App.resetCss();
    App.applyCss(`${COMPILED_STYLE_DIR}/style.css`);
    print('[LOG] Styles loaded');
    print(`[CRITICAL] Reload Sass option is set to: ${Options.recompileSass}`);
}
applyStyle().catch(print);

const createWindows = () =>
    [...hyprland.monitors.map(() => Bar()), ControlCentre()].map((w) =>
        w.on('destroy', (self) => {
            App.removeWindow(self);
            print('test');
        })
    );

const recreateWindows = () => {
    if (App.windows) {
        for (const win of App.windows) {
            App.removeWindow(win);
        }
    }
    App.config({ windows: createWindows() });
};

App.config({
    windows: createWindows(),
    onConfigParsed: () => {
        hyprland.connect('monitor-added', recreateWindows);

        Utils.monitorFile(
            // directory that contains the scss files
            `${App.configDir}/scss`,
            function() {
                applyStyle();
            }
        );
    },
});
