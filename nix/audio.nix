{
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    wireplumber.enable = true;
    pulse.enable = true;
    wireplumber.extraConfig = {
      "alsa_output.pci-0000_00_1f.3.analog-stereo" = {
        pause-on-idle = false;
        session.suspend-timeout-seconds = 0;
      };
    };
  };
}
