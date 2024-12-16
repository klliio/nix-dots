{
  hardware.alsa.enablePersistence = true;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    pulse.enable = true;
    wireplumber.enable = true;
    wireplumber.extraConfig = {
      "disable-devices" = {
        "monitor.alsa.rules" = [
          {
            matches = [
              {
                "device.name" = "alsa_card.pci-0000_c4_00.1";
              }
            ];
            actions = {
              update-props = {
                "device.disabled" = true;
              };
            };
          }
        ];
      };
    };
  };
}
