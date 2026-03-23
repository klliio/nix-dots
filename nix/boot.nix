{ pkgs, ... }: {
    boot.loader.grub = {
        enable = true;
        efiSupport = true;
        efiInstallAsRemovable = false;
        useOSProber = true;
        device = "nodev";
    };

    # boot.loader.limine = {
    #     enable = true;
    #     efiSupport = true;
    #     efiInstallAsRemovable = false;
    # };

    boot.supportedFilesystems = [ "ntfs" ]; # enable ntfs support at boot
    boot.kernelPackages = pkgs.cachyosKernels.linuxPackages-cachyos-latest;
}
