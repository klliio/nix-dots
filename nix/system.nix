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

    security.polkit.enable = true;

    # Configure keymap in X11
    services.xserver.xkb.layout = "gb";

    # Enable bluetooth
    hardware.bluetooth = {
        enable = true;
        powerOnBoot = true;
        settings.General.Experimental = true; # for gnome-bluetooth percentage
    };

    # Enable opengl
    hardware.graphics.enable = true;
    hardware.graphics.extraPackages = with pkgs; [
        intel-media-driver
    ];

    hardware.enableRedistributableFirmware = true;
    hardware.enableAllFirmware = true;

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
        intel-media-driver
        nano
        wget
        git
        cifs-utils

        unzip
        rar
        p7zip
    ];

    # Enable the OpenSSH daemon.
    services = {
        openssh.enable = true;
        printing.enable = true;
        libinput.enable = true;

        # btrfs
        btrfs.autoScrub.enable = true;
        fstrim.enable = true;

        # hyprland
        gvfs.enable = true;
        devmon.enable = true;
        udisks2.enable = true;
        upower.enable = true;
        power-profiles-daemon.enable = true;
        accounts-daemon.enable = true;
    };

    # automatic store
    nix.optimise.automatic = true;
    nix.gc = {
        automatic = true;
        dates = "weekly";
        options = "--delete-older-than 30d";
    };

    nix.settings = {
        substituters = ["https://hyprland.cachix.org"];
        trusted-public-keys = ["hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="];
    };

    system.stateVersion = "24.05"; # Did you read the comment?
}
