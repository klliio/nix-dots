# taken from github.com/Aylur/dotfiles
{ pkgs, inputs, lib, ... }: {
    options.hyprland.enable = lib.mkEnableOption "Hyprland";

    config = {
        programs.hyprland = {
            enable = true;
            package = inputs.hyprland.packages.${pkgs.system}.hyprland;
            portalPackage = with pkgs; xdg-desktop-portal-hyprland;
            xwayland.enable = true;
        };

        services = {
            xserver.displayManager.startx.enable = true;
            gvfs.enable = true;
            devmon.enable = true;
            udisks2.enable = true;
            upower.enable = true;
            power-profiles-daemon.enable = true;
            accounts-daemon.enable = true;
            flatpak.enable = true;
        };

        security.polkit.enable = true;

        xdg.portal = {
            enable = true;
            extraPortals = with pkgs; [
                xdg-desktop-portal-gtk
                xdg-desktop-portal
            ];
        };
    };
}
