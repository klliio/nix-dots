{ pkgs, config, ... }: {
    programs.fuzzel = {
        enable = true;
        package = pkgs.fuzzel;
        settings = {
            main = {
                terminal = "${pkgs.foot}/bin/foot";
                layer = "overlay";
                icons-enabled = false;
                fuzzy = true;
                anchor = "center";
                lines = 12;
                width = 20;
                exit-on-keyboard-focus-loss = true;
            };
            border = {
                width = 5;
                radius = 0;
            };
        };
    };
}
