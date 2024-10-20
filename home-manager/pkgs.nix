{ pkgs, ... }: {
    # don't fit in other files / not used by other programs
    home.packages = with pkgs; [
        python3
        lzip
        ffmpeg
        aria2
        jetbrains.idea-community

        # image
        gimp
        inkscape
        imv
        mpv

        # music
        nicotine-plus
        puddletag
        loudgain

        # general
        nautilus
        firefox
        pavucontrol
        tigervnc
    ];
}
