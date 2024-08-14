{
    boot.loader.grub = {
        enable = true;
        efiSupport = true;
        efiInstallAsRemovable = true;
        useOSProber = true;
        device = "nodev";
    };

    boot.supportedFilesystems = [ "ntfs" ]; # enable ntfs support at boot
}
