{ pkgs, ... }: {
    home.packages = with pkgs; [
        nerdfonts
        libsixel
    ];

    programs.foot = {
        enable = true;
        settings = {
            main = {
                box-drawings-uses-font-glyphs = "yes";
                pad = "5x5center";
                notify = "notify-send -a \${app-id} -i \${app-id} \${title} \${body}";
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
                protocols = "https, https, ftp, ftps, file";
                uri-characters = ''
                    abcdefhijklmnopqrstuvwxyzABCDEFHIJKLMNOPQRSTUVWXYZ0123456789-_.,~:;/?\#@!$&%*+="'()[]
                '';
            };

            cursor = {
                style = "beam";
                beam-thickness = "2";
            };

            tweak = {
                font-monospace-warn = "no";
                sixel = "yes";
            };
        };
    };
}
