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

    security = {
        polkit.enable = true;
        # pam.services.ags = {};
    };

    systemd = {
        user.services.polkit-gnome-authentication-agent-1 = {
            description = "polkit-gnome-authentication-agent-1";
            wantedBy = [ "graphical-session.target" ];
            wants = [ "graphical-session.target" ];
            after = [ "graphical-session.target" ];
            serviceConfig = {
                Type = "simple";
                ExecStart = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
                Restart = "on-failure";
                RestartSec = 1;
                TimeoutStopSec =10;
            };
        };
    };
}
