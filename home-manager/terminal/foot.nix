{ pkgs, ... }: {
    home.packages = with pkgs; [
        nerd-fonts.hack
        libsixel
    ];

    programs.foot = {
        enable = true;
        settings = {
            main = {
                box-drawings-uses-font-glyphs = "yes";
                pad = "5x5center";
                selection-target = "clipboard";
            };

            scrollback = {
                lines = 10000;
                multiplier = 3;
            };

            url = {
                launch = "xdg-open \${url}";
                label-letters = "sadfjklewcmpgh";
                osc8-underline = "url-mode";
            };

            cursor = {
                style = "underline";
                underline-thickness = 1.5;
                blink = true;
                blink-rate = 500;
            };

            tweak = {
                font-monospace-warn = "no";
                sixel = "yes";
            };
        };
    };
}
