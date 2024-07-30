{ pkgs, ... }: {
    news.display = "show";

    nix.settings = {
        experimental-features = [ "nix-command" "flakes" ];
        warn-dirty = false;
    };

    home = {
        sessionVariables = {
            NIXPKGS_ALLOW_UNFREE = "1";
            NIXPKGS_ALLOW_INSECURE = "1";
        };

        sessionPath = [
            "$HOME/.local/bin"
        ];

        packages = with pkgs; [
            unzip
            gtk3
            gtk4

            prismlauncher
            gamemode
        ];
    };

    programs.home-manager.enable = true;
    home.stateVersion = "24.05";
}
