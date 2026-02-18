{ pkgs, inputs, userInfo, lib, ... }: {
    imports = [
        ./system.nix
        ./boot.nix
        ./audio.nix
        ./network.nix
        ./stylix.nix
        ./steam.nix
        ./tuigreet.nix
        ./syncthing.nix
        ./hyprland.nix
        ./makima.nix
        ./vpn.nix
        ./appimage.nix
        ./ydotool.nix
    ];

    users.users.${userInfo.username} = {
        isNormalUser = true;
        initialPassword = userInfo.username;
        extraGroups = [
            "networkmanager"
            "wheel"
            "audio"
            "video"
            "input"
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
                ../home-manager
            ];
        };
    };
}
