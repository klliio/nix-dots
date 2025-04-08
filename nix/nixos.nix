{ pkgs, inputs, userInfo, ... }: {
    imports = [
        ./system.nix
        ./boot.nix
        ./audio.nix
        ./network.nix
        ./stylix.nix
        ./steam.nix
        ./adb.nix
        ./tuigreet.nix
        ./syncthing.nix
    ];

    users.users.${userInfo.username} = {
        isNormalUser = true;
        initialPassword = userInfo.username;
        extraGroups = [
            "networkmanager"
            "wheel"
            "audio"
            "video"
        ];
    };
    nixpkgs.config = {
        allowUnfree = true;
        allowInsecure = true;
    };

    # fix gtk error
    programs.dconf.enable = true;
    home-manager = {
        backupFileExtension = "backup";
        useGlobalPkgs = true;
        useUserPackages = true;
        extraSpecialArgs = { inherit inputs; inherit userInfo; };
        users.${userInfo.username} = {
            home.username = userInfo.username;
            home.homeDirectory = "/home/${userInfo.username}";
            imports = [
                ./home.nix
                ../home-manager/terminal/foot.nix
                ../home-manager/terminal/nvim.nix
                ../home-manager/terminal/bash.nix
                ../home-manager/terminal/git.nix
                ../home-manager/terminal/btop.nix
                ../home-manager/firefox.nix
                ../home-manager/hyprland.nix
                ../home-manager/hyprlock.nix
                ../home-manager/gtk.nix
                ../home-manager/spicetify.nix
                ../home-manager/mako.nix
                ../home-manager/fuzzel.nix
                ../home-manager/pkgs.nix
                ../home-manager/weechat.nix
                ../home-manager/ags.nix
            ];
        };
    };
}
