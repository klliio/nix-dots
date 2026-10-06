{
  config,
  pkgs,
  userInfo,
  ...
}:
{
  boot.extraModulePackages = with config.boot.kernelPackages; [ ddcci-driver ];
  boot.kernelModules = [
    "ddcci_backlight"
    "i2c-dev"
  ];

  hardware.i2c.enable = true;
  users.users.${userInfo.username}.extraGroups = [ "i2c" ];

  environment.systemPackages = [ pkgs.ddcutil ];
  services.udev.packages = [ pkgs.ddcutil ];
}
