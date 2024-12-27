{ pkgs, inputs, userInfo, ... }: {
    imports = [
        ./hardware/mini.nix
        ./nixos.nix
        ./corectrl.nix
    ];

    networking.firewall.enable = false;
}
