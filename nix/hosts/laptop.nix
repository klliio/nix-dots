{ pkgs, inputs, userInfo, ... }: {
    imports = [
        ./hardware/laptop.nix
        ./nixos.nix
    ];
}
