{
  programs.corectrl = {
    enable = true;
  };

  hardware.amdgpu.overdrive.enable = true;
  hardware.amdgpu.overdrive.ppfeaturemask = "0xffffffff";
}
