{
    boot.loader.grub = {
        enable = true;
        efiSupport = true;
        efiInstallAsRemovable = true;
        useOSProber = true;
        device = "nodev";
    };

    boot.supportedFilesystems = [ "ntfs" ]; # enable ntfs support at boot

    fileSystems."/media" = {
        device = "/media";
        fsType = "tmpfs";
    };

    swapDevices = [{
        device = "/swapfile";
        size = 16 * 1024; # 16GB
    }];
}
