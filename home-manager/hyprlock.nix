{ pkgs, inputs, config, lib,  ... } :
{
    programs.hyprlock = lib.mkForce {
        enable = true;
        settings = {
            general = {
                ignore_empty_input = true;
                hide_cursor = true;
            };

            background = [
                {
                    path = "screenshot";
                    blur_passes = 3;
                    blur_size = 3;
                }
            ];

            input-field = [
                {
                    size = "200, 50";
                    position = "0, -60";
                    halign = "center";
                    valign = "center";
                    monitor = "";
                    dots_center = true;
                    fade_on_empty = false;
                    font_size = 16;
                    font_color = "rgb(205, 214, 244)";
                    inner_color = "rgb(30, 30, 46)";
                    outer_color = "rgb(116, 199, 236)";
                    fail_color = "rgb(243, 139, 168)";
                    check_color = "rgb(166, 227, 161)";
                    outline_thickness = 3;
                    placeholder_text = "<tt><b>Password</b></tt>";
                }
            ];

            label = [
                #time
                {
                    position = "0, 0";
                    halign = "center";
                    valign = "center";
                    monitor = "";
                    color = "rgb(205, 214, 244)";
                    font_size = 40;
                    text = "<b><tt>$TIME</tt></b>";
                }
            ];

            animations.enabled = true;
        };
    };
}
