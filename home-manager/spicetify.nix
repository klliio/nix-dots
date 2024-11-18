{ inputs, pkgs, config, ... }: {
    imports = [ inputs.spicetify-nix.homeManagerModules.default ];

    programs.spicetify =
    let
        # spicePkgs = inputs.spicetify-nix.packages.${pkgs.system}.default;
        spicePkgs = inputs.spicetify-nix.legacyPackages.${pkgs.system};
    in {
        enable = true;

        enabledExtensions = with spicePkgs.extensions; [
            volumePercentage
            adblock
            hidePodcasts
            shuffle
            oneko
        ];
    };
}
