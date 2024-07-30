{
    description = "klliio config";

    inputs = {
        nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
        home-manager.url = "github:nix-community/home-manager/master";
        home-manager.inputs.nixpkgs.follows = "nixpkgs";

        # firefox extensions
        firefox-addons.url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
        firefox-addons.inputs.nixpkgs.follows = "nixpkgs";

        # ags
        ags.url = "github:Aylur/ags";

        # hyprland
        hyprland.url = "git+https://github.com/hyprwm/Hyprland?submodules=1";

        # stylix
        stylix.url = "github:danth/stylix";

        # spicetify
        spicetify-nix.url = "github:Gerg-L/spicetify-nix";
        spicetify-nix.inputs.nixpkgs.follows = "nixpkgs";
    };

    outputs = { self, nixpkgs, ... }@inputs:
    let
        system = "x86_64-linux";
        userInfo = {
            username = "klliio";
            hostname = "nix";
            wallpaper = ./Wallpapers/bocchi-vending.png;
        };
    in {
        nixosConfigurations = {
            ${userInfo.username} = nixpkgs.lib.nixosSystem {
                inherit system;
                specialArgs = { inherit inputs userInfo; };
                modules = [
                    inputs.home-manager.nixosModules.home-manager
                    ./nix/nixos.nix
                ];
            };
        };
    };
}
