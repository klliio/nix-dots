{ pkgs, inputs, config, lib, ... } :
{
    home.packages = with pkgs; [
        # utils
        brightnessctl
        playerctl
        mako
        wl-clipboard
        wl-mirror

        # user
        foot
        keepassxc
        obsidian
    ];

    wayland.windowManager.hyprland.settings.bind =
        let
            # audio
            wpctl = "${pkgs.wireplumber}/bin/wpctl";
            playerctl = "${pkgs.playerctl}/bin/playerctl";

            # user
            ddcutil = "${pkgs.ddcutil}/bin/ddcutil";
            applauncher = "${pkgs.fuzzel}/bin/fuzzel";
            term = "${pkgs.foot}/bin/foot";

            # utility
            hyprlock = "${pkgs.hyprlock}/bin/hyprlock";

            arr = [1 2 3 4 5 6 7 8 9 0];
            lua = lib.generators.mkLuaInline;
            exec = cmd: ''hl.dsp.exec_cmd("${cmd}")'';

            movews = ws: ''hl.dsp.focus({ workspace = "${ws}" })'';
            movewd = ws: ''hl.dsp.window.move({ workspace = "${ws}", follow = false })'';
            movewddr = dr: ''hl.dsp.window.move({ direction = "${dr}" })'';
            fs = mode: ''hl.dsp.window.fullscreen({ move = "${mode}" })'';
            focusdr = dr: ''hl.dsp.focus({ direction = "${dr}" })'';
            special = name: (exec ''if hyprctl clients | grep special:${name} ; then hyprctl dispatch 'hl.dsp.workspace.toggle_special(\"${name}\")' ; else ${name} & fi'');
        in
            map ({
                    keys,
                    dispatcher,
                    flags ? {},
                }:{
                _args = [
                    keys
                    (lua dispatcher)
                    flags
                ];
            })
            [
                {
                    keys = "SUPER + SHIFT + Q";
                    dispatcher = ''hl.dsp.exit()'';
                    flags.description = "Quit Hyprland";
                }
                {
                    keys = "SUPER + W";
                    dispatcher = ''hl.dsp.window.close()'';
                    flags.description = "Close active window";
                }
                {
                    keys = "SUPER + P";
                    dispatcher = (exec "${applauncher}");
                    flags.description = "Open applauncher";
                }
                {
                    keys = "SUPER + Scroll_Lock";
                    dispatcher = (exec "systemctl suspend");
                    flags.description = "Suspends system";
                }
                {
                    keys = "Scroll_Lock";
                    dispatcher = (exec "${hyprlock}");
                    flags.description = "Locks system";
                }
                {
                    keys = "SUPER + F";
                    dispatcher = (fs "miximized");
                    flags.description = "Fullscreen active window";
                }
                {
                    keys = "SUPER + SHIFT + F";
                    dispatcher = ''hl.dsp.window.float({})'';
                    flags.description = "Float active window";
                }
                {
                    keys = "SUPER + SPACE";
                    dispatcher = "hl.dsp.layout( \"swapwithmaster auto\" )";
                    flags.description = "Swap active window with master";
                }
                {
                    keys = "SUPER + SHIFT + J";
                    dispatcher = "hl.dsp.layout( \"swapprev loop\" )";
                    flags.description = "Swap active window up in the stack";
                }
                {
                    keys = "SUPER + SHIFT + K";
                    dispatcher = "hl.dsp.layout( \"swapnext loop\" )";
                    flags.description = "Swap active window down in the stack";
                }
                {
                    keys = "SUPER + M";
                    dispatcher = "hl.dsp.layout( \"addmaster\" )";
                    flags.description = "Add active window to master stack";
                }
                {
                    keys = "SUPER + SHIFT + M";
                    dispatcher = "hl.dsp.layout( \"removemaster\" )";
                    flags.description = "Remove active window from master stack";
                }
                {
                    keys = "SUPER + SHIFT + H";
                    dispatcher = "hl.dsp.layout( \"mfact -0.2\" )";
                    flags.description = "Change master|stack ratio";
                }
                {
                    keys = "SUPER + SHIFT + L";
                    dispatcher = "hl.dsp.layout( \"mfact +0.2\" )";
                    flags.description = "Change master|stack ratio";
                }
                {
                    keys = "SUPER + SHIFT + CTRL + H";
                    dispatcher = "hl.dsp.layout( \"orientationprev\" )";
                    flags.description = "Rotate master|stack";
                }
                {
                    keys = "SUPER + SHIFT + CTRL + L";
                    dispatcher = "hl.dsp.layout( \"orientationnext\" )";
                    flags.description = "Rotate master|stack";
                }
                {
                    keys = "SUPER + H";
                    dispatcher = (focusdr "left");
                    flags.description = "Move focus left";
                }
                {
                    keys = "SUPER + J";
                    dispatcher = (focusdr "down");
                    flags.description = "Move focus down";
                }
                {
                    keys = "SUPER + K";
                    dispatcher = (focusdr "up");
                    flags.description = "Move focus up";
                }
                {
                    keys = "SUPER + L";
                    dispatcher = (focusdr "right");
                    flags.description = "Move focus right";
                }
                {
                    keys = "SUPER + SHIFT + O";
                    dispatcher = (special "obsidian");
                    flags.description = "Open obsidian workspace";
                }
                {
                    keys = "SUPER + SHIFT + P";
                    dispatcher = (special "keepassxc");
                    flags.description = "Open keepass workspace";
                }
                {
                    keys = "SUPER + mouse:272";
                    dispatcher = "hl.dsp.window.drag()";
                    flags.description = "Drag window with mouse";
                }
                {
                    keys = "SUPER + mouse:273";
                    dispatcher = "hl.dsp.window.resize()";
                    flags.description = "Resize window with mouse";
                }
                {
                    keys = "XF86MonBrightnessDown";
                    dispatcher = (exec "${ddcutil} --bus=4 setvcp 10 - 5");
                    flags = {
                        description = "Lower display brightness";
                        repeated = true;
                    };
                } # not supported on all displays
                {
                    keys = "XF86MonBrightnessUp";
                    dispatcher = (exec "${ddcutil} --bus=4 setvcp 10 + 5");
                    flags = {
                        description = "Raise display brightness";
                        repeated = true;
                    };
                } # ddc/ci displays can be used with extra config
                {
                    keys = "XF86AudioMute";
                    dispatcher = (exec "${wpctl} set-mute @DEFAULT_AUDIO_SINK@ toggle");
                    flags.description = "Mute default audio device";
                }
                {
                    keys = "XF86AudioLowerVolume";
                    dispatcher = (exec "${wpctl} set-volume @DEFAULT_AUDIO_SINK@ 5%-");
                    flags.description = "Decrease default audio device volume";
                }
                {
                    keys = "XF86AudioRaiseVolume";
                    dispatcher = (exec "${wpctl} set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+");
                    flags.description = "Increase default audio device volume";
                }
                {
                    keys = "XF86AudioPause";
                    dispatcher = (exec "${playerctl} play-pause");
                    flags.description = "Play/pause media";
                }
                {
                    keys = "XF86AudioPlay";
                    dispatcher = (exec "${playerctl} play-pause");
                    flags.description = "Play/pause media";
                }
                {
                    keys = "XF86AudioStop";
                    dispatcher = (exec "${playerctl} pause");
                    flags.description = "Pause media";
                }
                {
                    keys = "XF86AudioPrev";
                    dispatcher = (exec "${playerctl} previous");
                    flags.description = "Rewind media";
                }
                {
                    keys = "XF86AudioNext";
                    dispatcher = (exec "${playerctl} next");
                    flags.description = "Fastforward media";
                }
                {
                    keys = "SUPER + 1";
                    dispatcher = (movews "1");
                    flags.description = "Go to workspace 1";
                }
                {
                    keys = "SUPER + 2";
                    dispatcher = (movews "2");
                    flags.description = "Go to workspace 2";
                }
                {
                    keys = "SUPER + 3";
                    dispatcher = (movews "3");
                    flags.description = "Go to workspace 3";
                }
                {
                    keys = "SUPER + 4";
                    dispatcher = (movews "4");
                    flags.description = "Go to workspace 4";
                }
                {
                    keys = "SUPER + 5";
                    dispatcher = (movews "5");
                    flags.description = "Go to workspace 5";
                }
                {
                    keys = "SUPER + 6";
                    dispatcher = (movews "6");
                    flags.description = "Go to workspace 6";
                }
                {
                    keys = "SUPER + 7";
                    dispatcher = (movews "7");
                    flags.description = "Go to workspace 7";
                }
                {
                    keys = "SUPER + 8";
                    dispatcher = (movews "8");
                    flags.description = "Go to workspace 8";
                }
                {
                    keys = "SUPER + 9";
                    dispatcher = (movews "9");
                    flags.description = "Go to workspace 9";
                }
                {
                    keys = "SUPER + 0";
                    dispatcher = (movews "0");
                    flags.description = "Go to workspace 0";
                }

                {
                    keys = "SUPER + SHIFT + 1";
                    dispatcher = (movewd "1");
                    flags.description = "Move active window to workspace 1";
                }
                {
                    keys = "SUPER + SHIFT + 2";
                    dispatcher = (movewd "2");
                    flags.description = "Move active window to workspace 2";
                }
                {
                    keys = "SUPER + SHIFT + 3";
                    dispatcher = (movewd "3");
                    flags.description = "Move active window to workspace 3";
                }
                {
                    keys = "SUPER + SHIFT + 4";
                    dispatcher = (movewd "4");
                    flags.description = "Move active window to workspace 4";
                }
                {
                    keys = "SUPER + SHIFT + 5";
                    dispatcher = (movewd "5");
                    flags.description = "Move active window to workspace 5";
                }
                {
                    keys = "SUPER + SHIFT + 6";
                    dispatcher = (movewd "6");
                    flags.description = "Move active window to workspace 6";
                }
                {
                    keys = "SUPER + SHIFT + 7";
                    dispatcher = (movewd "7");
                    flags.description = "Move active window to workspace 6";
                }
                {
                    keys = "SUPER + SHIFT + 8";
                    dispatcher = (movewd "8");
                    flags.description = "Move active window to workspace 7";
                }
                {
                    keys = "SUPER + SHIFT + 9";
                    dispatcher = (movewd "9");
                    flags.description = "Move active window to workspace 9";
                }
                {
                    keys = "SUPER + SHIFT + 0";
                    dispatcher = (movewd "0");
                    flags.description = "Move active window to workspace 0";
                }
            ];
    # END OF BINDINGS ---------------------------------------------------------
}
