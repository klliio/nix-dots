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

    nix.settings.max-jobs = 12;

    # Configure keymap in X11
    services.xserver.xkb.layout = "gb";

    # bluetooth
    hardware.bluetooth = {
        enable = true;
        powerOnBoot = true;
        settings.General.Experimental = true; # for gnome-bluetooth percentage
    };

    # opengl
    hardware.graphics.enable = true;
    hardware.graphics.extraPackages = with pkgs; [
        intel-media-driver
    ];

    hardware.enableRedistributableFirmware = true;
    hardware.enableAllFirmware = true;

    # flakes
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
        nix-output-monitor

        unzip
        rar
        p7zip
    ];

    # Enable the OpenSSH daemon.
    services = {
        openssh.enable = true;
        printing.enable = true;
        libinput.enable = true;
        flatpak.enable = true;

        # btrfs
        btrfs.autoScrub.enable = true;
        fstrim.enable = true;
    };

    # automatic store
    nix.optimise.automatic = true;
    nix.gc = {
        automatic = true;
        dates = "weekly";
        options = "--delete-older-than 30d";
    };

    nix.settings = {
        substituters = [
            "https://cache.nixos.org/"
            "https://nix-community.cachix.org"
            "https://hyprland.cachix.org"
            "https://attic.xuyh0120.win/lantian"
        ];
        trusted-public-keys = [
            "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
            "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
            "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
            "lantian:EeAUQ+W+6r7EtwnmYjeVwx5kOGEBpjlBfPlzGlTNvHc="
        ];
    };

    system.stateVersion = "24.05"; # Did you read the comment?
}
