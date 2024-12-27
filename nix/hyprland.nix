# taken from github.com/Aylur/dotfiles
{ pkgs, inputs, lib, ... }: {
    options.hyprland.enable = lib.mkEnableOption "Hyprland";

    services.xserver.displayManager.startx.enable = true;

    programs.hyprland = {
        enable = true;
        package = inputs.hyprland.packages.${pkgs.system}.hyprland;
        portalPackage = with pkgs; xdg-desktop-portal-hyprland;
        xwayland.enable = true;
    };

    xdg = {
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
