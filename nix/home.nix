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
            rar
            p7zip

            gtk3
            gtk4

            rename

            prismlauncher
            gamemode

            wineWowPackages.waylandFull # 32 and 64
            winetricks
        ];
    };

    programs.home-manager.enable = true;
    home.stateVersion = "24.05";
}
