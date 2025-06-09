{ pkgs, inputs, lib, ... }: {
    config.xdg = {
        autostart.enable = true;
        portal = {
            enable = true;
            extraPortals = with pkgs; [
                xdg-desktop-portals-gtk
                xdg-dektop-portal
            ];
        };
    };
}
