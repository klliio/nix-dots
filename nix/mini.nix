{ pkgs, inputs, userInfo, ... }: {
    imports = [
        ./hardware/mini.nix
        ./nixos.nix
    ];

    networking.firewall.enable = false;
}
