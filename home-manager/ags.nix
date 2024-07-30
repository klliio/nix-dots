{ pkgs, lib, inputs, ... } : {
    imports = [
        inputs.ags.homeManagerModules.default
    ];

    home.packages = with pkgs; [
        inputs.ags.packages.${pkgs.system}.default
        gtk3
        sassc
        networkmanager
        pavucontrol
        brightnessctl
    ];

	programs.ags = {
        enable = true;
        # configDir = ../ags;
	};
}
