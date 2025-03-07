{ pkgs, ... }: {
    # don't fit in other files / not used by other programs
    home.packages = with pkgs; [
        python3
        lzip
        jq
        wireguard-tools
        qbittorrent
        gtk3
        gtk4
        libnotify

        # cli
        rename
        ffmpeg
        aria2
        bc

        # game
        prismlauncher
        gamemode
        gamescope
        wineWowPackages.waylandFull # 32 and 64
        winetricks
        protontricks

        # image
        gimp
        inkscape
        imv
        mpv

        # music
        nicotine-plus
        puddletag
        beets
        loudgain

        # userland
        nautilus
        pavucontrol
        tigervnc
        jetbrains.idea-community
    ];
}
