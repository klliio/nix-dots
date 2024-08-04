{ pkgs, ... }: {
    # don't fit in other files / not used by other programs
    home.packages = with pkgs; [
        python3
        lzip
        gimp
        inkscape
    ];
}
