import GLib from 'gi://GLib';
import { /*  windows, */ SetupWindows } from './windows.js';
import Options from './options.js';

print(`[LOG] Config Dir: ${App.configDir}`);

async function applyStyle() {
    const COMPILED_STYLE_DIR = `${GLib.get_user_cache_dir()}/ags/user/generated`;
    if (Options.recompileSass) {
        Utils.exec(`mkdir -p ${COMPILED_STYLE_DIR}`);
        Utils.exec(`sassc ${App.configDir}/scss/main.scss ${COMPILED_STYLE_DIR}/style.css`);
    }
    App.resetCss();
    App.applyCss(`${COMPILED_STYLE_DIR}/style.css`);
    print('[LOG] Styles loaded');
    print(`[CRITICAL] Reload Sass option is set to: ${Options.recompileSass}`);
}
applyStyle().catch(print);

App.config({
    // windows: windows,
    onConfigParsed: () => {
        SetupWindows();

        Utils.monitorFile(
            // directory that contains the scss files
            `${App.configDir}/scss`,
            function() {
                applyStyle();
            }
        );
    },
});
