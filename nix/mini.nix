{ pkgs, inputs, userInfo, ... }: {
    imports = [
        ./hardware/mini.nix
        ./nixos.nix
        ./corectrl.nix
    ];

    networking.firewall.enable = false;
    # services.udev.extraRules = ''
    #     # Dualshock 4
    #     # USB
    #     ATTRS{name}=="Sony Interactive Entertainment Wireless Controller Touchpad", ENV{LIBINPUT_IGNORE_DEVICE}="1"
    #     # Bluetooth
    #     ATTRS{name}=="Wireless Controller Touchpad", ENV{LIBINPUT_IGNORE_DEVICE}="1"
    # '';
}
