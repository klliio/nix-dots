{
    boot.loader.grub = {
        enable = true;
        zfsSupport = true;
        efiSupport = true;
        efiInstallAsRemovable = true;
        mirroredBoots = [
            { devices = [ "nodev" ]; path = "/boot"; }
        ];
    };

    fileSystems."/" = {
        device = "zroot/root";
        fsType = "zfs";
    };

    fileSystems."/nix" = {
        device = "zroot/nix";
        fsType = "zfs";
    };

    fileSystems."/var" = {
        device = "zroot/var";
        fsType = "zfs";
    };

    fileSystems."/home" = {
        device = "zroot/home";
        fsType = "zfs";
    };

    fileSystems."/media" = {
        device = "zroot/media";
        fsType = "tmpfs";
    };

    fileSystems."/boot" = {
        device = "/dev/disk/by-uuid/A8C3-2611";
        fsType = "vfat";
    };

    swapDevices = [ ];
    boot.kernelParams = [ "zfs.zfs_arc_max=6000000000" ];
}
