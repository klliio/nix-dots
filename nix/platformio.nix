{ pkgs, ... } :
{
    environment.systemPackages = with pkgs; [
        platformio-core
    ];

    services.udev.packages = with pkgs; [
        platformio-core.udev
        openocd
    ];
}
