{
    pkgs,
    inputs,
    userInfo,
    ...
}:
{
    imports = [ inputs.stylix.nixosModules.stylix ];

    config = {
        stylix = {
            enable = true;

            base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-mocha.yaml";
            image = userInfo.wallpaper;

            cursor = {
                name = "Bibata-Modern-Ice";
                size = 24;
                package = pkgs.bibata-cursors;
            };

            fonts = {
                monospace = {
                    name = "Hack Nerd Font";
                    package = pkgs.nerdfonts.override { fonts = [ "Hack" ]; };
                };
                sansSerif = {
                    name = "DejaVu Sans";
                    package = pkgs.dejavu_fonts;
                };
                serif = {
                    name = "DejaVu Serif";
                    package = pkgs.dejavu_fonts;
                };

                sizes = {
                    applications = 12;
                    terminal = 12;
                    desktop = 10;
                    popups = 10;
                };
            };

            opacity = {
                applications = 1.0;
                terminal = 0.9;
                desktop = 1.0;
                popups = 1.0;
            };

            polarity = "dark";

            targets = {
                nixos-icons.enable = true;
                gtk.enable = true;
                grub.enable = true;
                gnome.enable = true;
            };
        };
    };
}
