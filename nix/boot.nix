{
    boot.loader.grub = {
        enable = true;
        efiSupport = true;
        efiInstallAsRemovable = true;
        useOSProber = true;
        device = "nodev";
    };

    fileSystems."/media" = {
        device = "/media";
        fsType = "tmpfs";
    };

    swapDevices = [{
        device = "/swapfile";
        size = 16 * 1024; # 16GB
    }];
}
