{ pkgs, inputs, ... } :
{
    home.packages = with pkgs; [
        # utils
        brightnessctl
        playerctl
        mako

        # user
        pavucontrol
        rofi-wayland
        nautilus
        foot
        # firefox
        keepassxc
        obsidian
        # spotify

        # screen capture
        wl-clipboard
        wf-recorder
        slurp
        grim

        # image
        imv
        mpv
    ];


	wayland.windowManager.hyprland =
        let
            hyprland = inputs.hyprland.packages.${pkgs.system}.hyprland;
            playerctl = "${pkgs.playerctl}/bin/playerctl";
            brightnessctl = "${pkgs.brightnessctl}/bin/brightnessctl";
            wpctl = "${pkgs.wireplumber}/bin/wpctl";
        in {
            enable = true;
            systemd.enable = true;
            xwayland.enable = true;
            package = hyprland;
            settings = {
                "$MOD" = "SUPER";
                exec-once = [
                    "ags"
                    "mako"
                    # "[workspace special:keepassxc silent] keepassxc"
                    # "[workspace special:obsidian silent] obsidian"
                    "[workspace special:spotify silent] spotify"
                ];

                monitor = [
                    ",preferred,auto,1"
                ];

                env = [
                    "WLR_NO_HARDWARE_CURSORS,1"
                    "WLR_RENDERER_ALLOW_SOFTWARE,1"
                    "NIXOS_OZONE_WL,1"
                    "MOZ_ENABLE_WAYLAND,1"
                ];

                general = {
                    layout = "master";
                    resize_on_border = true;
                    gaps_in = 0;
                    gaps_out = 0;
                    border_size = 4;
                };

                cursor = {
                    no_hardware_cursors = true;
                    enable_hyprcursor = true;
                    warp_on_change_workspace = true;
                };

                misc = {
                    disable_splash_rendering = true;
                    force_default_wallpaper = 1;
                };

                input = {
                    kb_layout = "gb";
                    repeat_delay = 250;
                    repeat_rate = 50;
                    follow_mouse = true;
                    mouse_refocus = true;
                    touchpad = {
                        natural_scroll = "no";
                        disable_while_typing = true;
                        drag_lock = true;
                    };
                    accel_profile = "flat";
                    sensitivity = 0;
                    numlock_by_default = true;
                    float_switch_override_focus = 2;
                };

                master = {
                    inherit_fullscreen = true;
                    orientation = "left";
                    new_on_top = true;
                    new_status = "master";
                };

                windowrule = let
                    f = regex: "float, ^(${regex})$";
                in [
                    (f "org.gnome.Calculator")
                    (f "pavucontrol")
                    (f "mpv")
                    (f "imv")
                    "workspace special:spotify, title:(.*)(Spotify)(.*)"
                    "workspace special:keepassxc, title:(.*)(KeePassXC)(.*)"
                    "workspace special:obsidian, title:(.*)(Obsidian)(.*)"
                ];

                bind = let
                    binding = mod: cmd: key: arg: "${mod}, ${key}, ${cmd}, ${arg}";
                    mvfocus = binding "SUPER" "movefocus";
                    ws = binding "SUPER" "workspace";
                    resizeactive = binding "SUPER CTRL" "resizeactive";
                    mvactive = binding "SUPER ALT" "moveactive";
                    mvtows = binding "SUPER CTRL SHIFT" "movetoworkspace";
                    mvtowssilent = binding "SUPER SHIFT" "movetoworkspacesilent";
                    special = binding "SUPER SHIFT" "togglespecialworkspace";
                    arr = [1 2 3 4 5 6 7 8 9];
                in [
                    "SUPER SHIFT, Q, exit"
                    "SUPER, W, killactive"

                    "SUPER, P, exec, rofi -show drun"
                    "SUPER, R, exec, rofi -show run"

                    "SUPER, RETURN, exec, ${pkgs.foot}/bin/foot"

                    "SUPER, F, fullscreen"
                    "SUPER SHIFT, F, togglefloating"

                    "SUPER, SPACE,   layoutmsg, swapwithmaster"
                    "SUPER SHIFT, J, layoutmsg, swapprev"
                    "SUPER SHIFT, K, layoutmsg, swapnext"
                    (mvfocus "h" "l")
                    (mvfocus "j" "d")
                    (mvfocus "k" "u")
                    (mvfocus "l" "r")
                    (ws "left" "e-1")
                    (ws "right" "e+1")
                    (mvtows "left" "e-1")
                    (mvtows "left" "e-1")
                    (mvtowssilent "right" "e+1")
                    (mvtowssilent "right" "e+1")
                    (resizeactive "h" "-20 0")
                    (resizeactive "j" "0 20")
                    (resizeactive "k" "0 -20")
                    (resizeactive "l" "20 0")
                    (mvactive "h" "-20 0")
                    (mvactive "j" "0 20")
                    (mvactive "k" "0 -20")
                    (mvactive "l" "20 0")
                    (special "O" "obsidian")
                    (special "P" "keepassxc")
                    (special "S" "spotify")
                ]
                ++ (map (i: ws (toString i) (toString i)) arr)
                ++ (map (i: mvtowssilent (toString i) (toString i)) arr);

                bindle = [
                    ",XF86MonBrightnessDown, exec, ${brightnessctl} set 5%-"
                    ",XF86MonBrightnessUp,   exec, ${brightnessctl} set 5%+"
                    ",XF86AudioMute,         exec, ${wpctl} set-mute @DEFAULT_AUDIO_SINK@ toggle"
                    ",XF86AudioLowerVolume,  exec, ${wpctl} set-volume @DEFAULT_AUDIO_SINK@ 5%-"
                    ",XF86AudioRaiseVolume,  exec, ${wpctl} set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"
                ];

                bindl = [
                    ",XF86AudioPlay,        exec, ${playerctl} play-pause"
                    ",XF86AudioPause,       exec, ${playerctl} play-pause"
                    ",XF86AudioStop,        exec, ${playerctl} pause"
                    ",XF86AudioPrev,        exec, ${playerctl} previous"
                    ",XF86AudioNext,        exec, ${playerctl} next"
                ];

                decoration = {
                    drop_shadow = "no";
                    dim_inactive = false;
                    blur.enabled = false;
                };

                animations = {
                    enabled = "no";
                };
        };
	};
}
