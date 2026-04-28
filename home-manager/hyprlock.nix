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
                    color = "rgba(30, 30, 46, 1.0)";
                }
            ];

            shape = [
                # surrounding box
                {
                    size = "350, 100";
                    rounding = 0;
                    color = "rgba(0, 0, 0, 0.0)";
                    border_color = "rgba(88, 91, 112, 1.0)";
                    border_size = 2;
                    valign = "center";
                    halign = "center";
                    zindex = 1;
                }

                # remove border sides
                {
                    size = "370, 50";
                    rounding = 0;
                    color = "rgba(30, 30, 46, 1.0)";
                    border_color = "rgba(0, 0, 0, 0.0)";
                    border_size = 0;
                    valign = "center";
                    halign = "center";
                    zindex = 2;
                }

                # time cutout
                {
                    size = "50, 20";
                    rounding = 0;
                    color = "rgba(30, 30, 46, 1.0)";
                    border_color = "rgba(0, 0, 0, 0.0)";
                    border_size = 0;
                    valign = "center";
                    halign = "center";
                    position = "0, 50";
                    zindex = 2;
                }
            ];

            label = [
                # time
                {
                    color = "rgba(88, 91, 112, 1.0)";
                    text = "<b><tt>$TIME</tt></b>";
                    text_align = "center";
                    valign = "center";
                    halign = "center";
                    position = "0, 50";
                    font_size = 10;
                    font_family = "monospace";
                    zindex = 10;
                }

                # user
                {
                    color = "rgba(147, 153, 178, 1.0)";
                    text = "•_• <b>user:</b> $USER";
                    valign = "center";
                    halign = "left";
                    position = "43%, 1.3%";
                    font_size = 12;
                    font_family = "monospace";
                    zindex = 10;
                }

                # password
                {
                    color = "rgba(147, 153, 178, 1.0)";
                    text = "<b>password:</b>";
                    valign = "center";
                    halign = "left";
                    position = "43%, -1.3%";
                    font_size = 12;
                    font_family = "monospace";
                    zindex = 10;
                }
            ];

            input-field = [
                # time
                {
                    outer_color = "rgba(0, 0, 0, 0.0)";
                    inner_color = "rgba(0, 0, 0, 0.0)";
                    fail_color = "rgba(0, 0, 0, 0.0)";
                    check_color = "rgba(0, 0, 0, 0.0)";
                    valign = "center";
                    halign = "left";
                    position = "47.8%, -1.35%";
                    size = "10%, 25";
                    outline_thickness = 0;
                    rounding = 0;
                    dots_center = false;
                    font_color = "rgba(147, 153, 178, 1.0)";
                    font_family = "monospace";
                    placeholder_text = "";
                    fail_text = "";
                    zindex = 10;
                }
            ];

            animations.enabled = false;
        };
    };
}
