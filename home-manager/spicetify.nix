{ inputs, pkgs, config, ... }: {
    imports = [ inputs.spicetify-nix.homeManagerModules.default ];

    programs.spicetify =
    let
        # spicePkgs = inputs.spicetify-nix.packages.${pkgs.system}.default;
        spicePkgs = inputs.spicetify-nix.legacyPackages.${pkgs.system};
    in {
        enable = true;

        theme = spicePkgs.themes.comfy;

        enabledExtensions = with spicePkgs.extensions; [
            volumePercentage
            adblock
            hidePodcasts
            shuffle
            oneko
        ];

        colorScheme = "custom";
        customColorScheme = with config.lib.stylix.colors; {
            text = base05;
            subtext = base05;
            sidebar-text = base05;
            main = base00;
            sidebar = base01;
            player = base00;
            card = base01;
            shadow = base01;
            selected-row = base05;
            button = base0D;
            button-active = base0D;
            button-disabled = base05;
            tab-active = base01;
            notification = "00ff00";
            notification-error = "00ff00";
            misc = "0000ff";
        };
    };
}
