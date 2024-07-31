{ pkgs, config, userInfo, ... }: {
    # Set your time zone.
    time.timeZone = "Europe/London";

    # Select internationalisation properties.
    i18n.defaultLocale = "en_GB.UTF-8";
    console = {
        packages = [pkgs.terminus_font];
        font = "${pkgs.terminus_font}/share/consolefonts/ter-i24b.psf.gz";
        useXkbConfig = true; # use xkb.options in tty.
    };

    # Configure keymap in X11
    services.xserver.xkb.layout = "gb";

    # Enable bluetooth
    hardware.bluetooth = {
        enable = true;
        powerOnBoot = false;
        settings.General.Experimental = true; # for gnome-bluetooth percentage
    };

    # Enable opengl
    hardware.graphics.enable = true;

    # Enable flakes
    nix.settings.experimental-features = [ "nix-command" "flakes" ];

    # List installed packages
    environment.etc."current-system-packages".text =
      let
        packages = builtins.map (p: "${p.name}") config.environment.systemPackages;
        sortedUnique = builtins.sort builtins.lessThan (pkgs.lib.lists.unique packages);
        formatted = builtins.concatStringsSep "\n" sortedUnique;
      in
        formatted;

    # System packages
    environment.systemPackages = with pkgs; [
        mesa
        nano
        wget
        git
        cifs-utils
    ];

    # Enable the OpenSSH daemon.
    services = {
        openssh.enable = true;
        zfs.autoScrub.enable = true;
        zfs.trim.enable = true;
        printing.enable = true;
        libinput.enable = true;

        # hyprland
        gvfs.enable = true;
        devmon.enable = true;
        udisks2.enable = true;
        upower.enable = true;
        power-profiles-daemon.enable = true;
        accounts-daemon.enable = true;

        syncthing = {
            enable = true;
            user = userInfo.username;
            dataDir = "/home/${userInfo.username}/Syncthing";
            configDir = "/home/${userInfo.username}/.config/syncthing";
            overrideDevices = true;     # overrides any devices added or deleted through the WebUI
            overrideFolders = false;     # overrides any folders added or deleted through the WebUI
            settings = {
                devices = {
                    "pixel" = { id = "TA6YGIP-ZPMMDCL-TZ35VAD-VBGDY4E-YJ4QWCL-RDUUA4V-QH7BVRF-73DYGQQ"; };
                };
                folders = {
                    "Passwords" = {         # Name of folder in Syncthing, also the folder ID
                        path = "/home/${userInfo.username}/Passwords";    # Which folder to add to Syncthing
                        devices = [ "pixel" ];      # Which devices to share the folder with
                    };
                    "Obsidian" = {         # Name of folder in Syncthing, also the folder ID
                        path = "/home/${userInfo.username}/Obsidian";    # Which folder to add to Syncthing
                        devices = [ "pixel" ];      # Which devices to share the folder with
                    };
                };
            };
        };
    };

    nix.settings = {
        substituters = ["https://hyprland.cachix.org"];
        trusted-public-keys = ["hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="];
    };

    system.stateVersion = "24.05"; # Did you read the comment?
}
