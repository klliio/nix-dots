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

    imports = [
        ./hl-autostart.nix
        ./hl-keybinds.nix
    ];

	wayland.windowManager.hyprland =
        let
            hyprland = inputs.hyprland.packages.${pkgs.system}.hyprland;
            colours = config.lib.stylix.colors;
        in {
            enable = true;
            systemd.enable = true;
            xwayland.enable = true;
            package = hyprland;
            configType= "lua";
            settings = {
                mod = { _var = "SUPER"; };

                config = {
                    general = {
                        layout = "master";
                        resize_on_border = true;
                        gaps_in = 0;
                        gaps_out = 0;
                        border_size = 4;
                    };

                    monitor = [
                        "HDMI-A-1,2560x1440,auto,1, bitdepth, 10, cm, wide"
                        "HDMI-A-4,2560x1440,auto,1"
                    ];

                    env = [
                        # "WLR_NO_HARDWARE_CURSORS,1"
                        # "WLR_RENDERER_ALLOW_SOFTWARE,1"
                        "NIXOS_OZONE_WL,1"
                        "MOZ_ENABLE_WAYLAND,1"
                    ];

                    cursor = {
                        no_hardware_cursors = 0;
                        enable_hyprcursor = true;
                        warp_on_change_workspace = true;
                    };

                    misc = {
                        disable_splash_rendering = true;
                        force_default_wallpaper = 1;
                        vrr = 0;
                    };

                    decoration = {
                        dim_inactive = false;
                        blur.enabled = false;
                        # shadow.enabled = false;
                    };

                    # per device config at the bottom of the file
                    input = {
                        kb_layout = "gb";
                        kb_options = "caps:none";
                        repeat_delay = 250;
                        repeat_rate = 50;
                        follow_mouse = true;
                        mouse_refocus = true;
                        touchpad = {
                            natural_scroll = false;
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
                        orientation = "left";
                        new_on_top = true;
                        new_status = "master";
                    };

                    windowrule = let
                        f = regex: "match:initial_class ^(${regex})$, float on";
                    in [
                        (f "pavucontrol")
                        (f "mpv")
                        (f "imv")

                        # workspace name is the same as cmd
                        "workspace special:keepassxc, match:title (.*)(KeePassXC)(.*)"
                        "workspace special:obsidian, match:title .*((?i)Obsidian).*"
                    ];

                    workspace = [
                        "1,monitor:HDMI-A-1"
                        "2,monitor:HDMI-A-1"
                        "3,monitor:HDMI-A-1"
                        "4,monitor:HDMI-A-1"
                        "5,monitor:HDMI-A-1"
                        "6,monitor:HDMI-A-1"
                        "7,monitor:HDMI-A-1"
                        "8,monitor:HDMI-A-1"
                        "9,monitor:HDMI-A-1"
                    ];
                };

                animation = {
                    leaf = "global";
                    enabled = false;
                };
        };
        extraConfig = ''
            hl.device ({
                name = "microsoft-microsoft-3-button-mouse-with-intellieye(tm)",
                sensitivity = 0.2
            })
            hl.device ({
                name = "logitech-usb-optical-mouse",
                sensitivity = -0.2
            })
        '';
	};
}
