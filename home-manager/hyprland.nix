{ pkgs, inputs, config, ... } :
{
    home.packages = with pkgs; [
        # utils
        brightnessctl
        playerctl
        mako
        wl-clipboard

        # user
        foot
        keepassxc
        obsidian
        # spotify /* added by spicetify */
    ];


	wayland.windowManager.hyprland =
        let
            hyprland = inputs.hyprland.packages.${pkgs.system}.hyprland;
            colours = config.lib.stylix.colors;

            # audio
            wpctl = "${pkgs.wireplumber}/bin/wpctl";
            playerctl = "${pkgs.playerctl}/bin/playerctl";

            # user
            brightnessctl = "${pkgs.brightnessctl}/bin/brightnessctl";
            applauncher = "${pkgs.fuzzel}/bin/fuzzel";
            term = "${pkgs.foot}/bin/foot";

            # screen capture
            screenshot = import ./scripts/screenshot.nix pkgs;
            screencapture = import ./scripts/screencapture.nix pkgs;
            screenclip = import ./scripts/screenclip.nix pkgs;

            # utility
            notification = "${pkgs.mako}/bin/mako";
            polkit = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
        in {
            enable = true;
            systemd.enable = true;
            xwayland.enable = true;
            package = hyprland;
            settings = {
                "$MOD" = "SUPER";
                exec-once = [
                    notification
                    polkit
                    "systemctl --user restart pipewire.service" # fix bluetooth audio
                    "[workspace special:keepassxc silent] keepassxc"
                    # "[workspace special:obsidian silent] ${obsidian}"
                    # "[workspace special:spotify silent] ${spotify}"
                ];

                monitor = [
                    "eDP-1,1920x1080,auto,1"
                    "HDMI-A-1,1920x1080,auto,1"
                    "HDMI-A-2,1920x1080,auto,1,mirror, HDMI-A-1"
                ];

                env = [
                    # "WLR_NO_HARDWARE_CURSORS,1"
                    # "WLR_RENDERER_ALLOW_SOFTWARE,1"
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
                    vrr = 1;
                };

                # per device config at the bottom of the file
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
                    scroll_factor = 1.0;
                    sensitivity = 0.5;
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
                    f = regex: "float, initialClass:^(${regex})$";
                in [
                    (f "pavucontrol")
                    (f "mpv")
                    (f "imv")

                    # workspace name is the same as cmd
                    "workspace special:spotify, title:.*((?i)Spotify).*"
                    "workspace special:keepassxc, title:(.*)(KeePassXC)(.*)"
                    "workspace special:obsidian, title:.*((?i)Obsidian).*"
                ];

                bind = let
                    binding = mod: cmd: key: arg: "${mod}, ${key}, ${cmd}, ${arg}";
                    mvfocus = binding "SUPER" "movefocus";
                    ws = binding "SUPER" "workspace";
                    resizeactive = binding "SUPER CTRL" "resizeactive";
                    mvactive = binding "SUPER ALT" "moveactive";
                    mvtows = binding "SUPER CTRL SHIFT" "movetoworkspace";
                    mvtowssilent = binding "SUPER SHIFT" "movetoworkspacesilent";
                    arr = [1 2 3 4 5 6 7 8 9];

                    # if hyprctl clients | grep special:${cmd}; then
                    #     hyprctl dispatch togglespecialworkspace ${cmd}
                    # else
                    #     ${cmd} &
                    # fi
                    special = key: cmd: "SUPER SHIFT, ${key}, exec, if hyprctl clients | grep special:${cmd} ; then hyprctl dispatch togglespecialworkspace ${cmd} ; else ${cmd} & fi";
                in [
                    "SUPER SHIFT, Q, exit"
                    "SUPER, W, killactive"

                    "SUPER, P, exec, ${applauncher}"

                    "SUPER, RETURN, exec, ${term}"

                    ",                  PRINT, exec, ${screenshot} --quick"
                    "SUPER,             PRINT, exec, ${screenshot} --background ${colours.base00}80 --border ${colours.base0D}ff --select 00000000"
                    "SUPER CONTROL,     PRINT, exec, ${screencapture} --background ${colours.base00}80 --border ${colours.base0D}ff --select 00000000"
                    "SUPER SHIFT,       PRINT, exec, ${screenclip} --save"
                    "SUPER CONTROL SHIFT,    PRINT, exec, ${screenclip}"

                    "SUPER,       F, fullscreen"
                    "SUPER SHIFT, F, togglefloating"
                    "SUPER, SPACE,   layoutmsg, swapwithmaster"
                    "SUPER SHIFT, J, layoutmsg, swapprev"
                    "SUPER SHIFT, K, layoutmsg, swapnext"

                    # add/remove window from the master area
                    "SUPER, M, layoutmsg, addmaster"
                    "SUPER SHIFT, M, layoutmsg, removemaster"

                    # change master split ratio
                    "SUPER CTRL SHIFT, H, layoutmsg, mfact -0.2"
                    "SUPER CTRL SHIFT, L, layoutmsg, mfact +0.2"

                    # rotate orientation of master
                    "SUPER SHIFT, H, layoutmsg, orientationprev"
                    "SUPER SHIFT, L, layoutmsg, orientationnext"

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

                    # key | cmd
                    (special "O" "obsidian")
                    (special "P" "keepassxc")
                    (special "S" "spotify")
                ]
                ++ (map (i: ws (toString i) (toString i)) arr)
                ++ (map (i: mvtowssilent (toString i) (toString i)) arr);

                bindle = [
                    ",XF86MonBrightnessDown, exec, ${brightnessctl} set 5%-" # not supported on all displays
                    ",XF86MonBrightnessUp,   exec, ${brightnessctl} set 5%+" # ddc/ci displays can be used with extra config
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

                bindm = [
                    "SUPER, mouse:272, movewindow"
                    "SUPER, mouse:273, resizewindow"
                ];

                decoration = {
                    dim_inactive = false;
                    blur.enabled = false;
                    # shadow.enabled = false;
                };

                animations = {
                    enabled = "no";
                };
        };
        extraConfig = ''
            device {
                name=microsoft-microsoft-3-button-mouse-with-intellieye(tm)
                sensitivity=0.2
            }
            device {
                name=logitech-usb-optical-mouse
                sensitivity=-0.2
            }
        '';
	};
}
