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
            brightnessctl = "${pkgs.brightnessctl}/bin/brightnessctl";
            applauncher = "${pkgs.fuzzel}/bin/fuzzel";
            term = "${pkgs.foot}/bin/foot";

            # utility
            hyprlock = "${pkgs.hyprlock}/bin/hyprlock";

            arr = [1 2 3 4 5 6 7 8 9 0];
            lua = lib.generators.mkLuaInline;
            exec = cmd: ''hl.dsp.exec_cmd("${cmd}")'';
            bind = key: action: {
                _args = [
                    key
                        (lua action)
                ];
            };

            movews = ws: ''hl.dsp.focus({ workspace = "${ws}" })'';
            movewd = ws: ''hl.dsp.window.move({ workspace = "${ws}", follow = false })'';
            movewddr = dr: ''hl.dsp.window.move({ direction = "${dr}" })'';
            fs = mode: ''hl.dsp.window.fullscreen({ move = "${mode}" })'';
            focusdr = dr: ''hl.dsp.focus({ direction = "${dr}" })'';
            special = name: (exec "if hyprctl clients | grep special:${name} ; then hyprctl dispatch togglespecialworkspace ${name} ; else ${name} & fi");
        in [
            (bind "SUPER + SHIFT + Q" "hl.dsp.exit()")
            (bind "SUPER + W" "hl.dsp.window.kill()")

            (bind "SUPER + P" (exec "${applauncher}"))
            (bind "SUPER + RETURN" (exec "${term}"))

            (bind "Scroll_Lock"  (exec "${hyprlock}"))

            (bind "SUPER + F" (fs "maximized"))
            (bind "SUPER + SHIFT + F" "hl.dsp.window.float({})")
            (bind "SUPER + SPACE" "hl.dsp.layout( \"swapwithmaster auto\" )")
            (bind "SUPER + SHIFT + J" "hl.dsp.layout( \"swapprev loop\" )")
            (bind "SUPER + SHIFT + K" "hl.dsp.layout( \"swapnext loop\" )")

            # add/remove window from the master area
            (bind "SUPER + M" "hl.dsp.layout( \"addmaster\" )")
            (bind "SUPER + SHIFT + M" "hl.dsp.layout( \"removemaster\" )")

            # change master split ratio
            (bind "SUPER + SHIFT + H" "hl.dsp.layout( \"mfact -0.2\" )")
            (bind "SUPER + SHIFT + L" "hl.dsp.layout( \"mfact +0.2\" )")

            # rotate orientation of master
            (bind "SUPER + SHIFT + CTRL + H" "hl.dsp.layout( \"orientationprev\" )")
            (bind "SUPER + SHIFT + CTRL + L" "hl.dsp.layout( \"orientationnext\" )")

            (bind "SUPER + H" (focusdr "left"))
            (bind "SUPER + J" (focusdr "down"))
            (bind "SUPER + K" (focusdr "up"))
            (bind "SUPER + L" (focusdr "right"))

            # key | cmd
            (bind "SUPER + SHIFT + O" (special "obsidian"))
            (bind "SUPER + SHIFT + P" (special "keepassxc"))

            (bind "SUPER + mouse:272" "hl.dsp.window.drag()")
            (bind "SUPER + mouse:273" "hl.dsp.window.resize()")

            (bind "XF86MonBrightnessDown" (exec "${brightnessctl} set 5%-")) # not supported on all displays
            (bind "XF86MonBrightnessUp" (exec "${brightnessctl} set 5%+")) # ddc/ci displays can be used with extra config

            (bind "XF86AudioMute" (exec "${wpctl} set-mute @DEFAULT_AUDIO_SINK@ toggle"))
            (bind "XF86AudioLowerVolume" (exec "${wpctl} set-volume @DEFAULT_AUDIO_SINK@ 5%-"))
            (bind "XF86AudioRaiseVolume" (exec "${wpctl} set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"))

            (bind "XF86AudioPause" (exec "${playerctl} play-pause"))
            (bind "XF86AudioPlay" (exec "${playerctl} play-pause"))
            (bind "XF86AudioStop" (exec "${playerctl} pause"))
            (bind "XF86AudioPrev" (exec "${playerctl} previous"))
            (bind "XF86AudioNext" (exec "${playerctl} next"))
        ]
        ++ (map (i: (bind (toString i) (movews (toString i) ))) arr)
        ++ (map (i: (bind (toString i) (movewd (toString i) ))) arr);
}
