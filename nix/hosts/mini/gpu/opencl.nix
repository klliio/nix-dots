{ pkgs, ... }: {
    # hardware.graphics.extraPackages = with pkgs; [
    #     rocmPackages.clr.icd
    # ];
    hardware.amdgpu.opencl.enable = true;

    environment.systemPackages = with pkgs; [
        clinfo
    ];
}
