{ pkgs, ... }: {
    # don't fit in other files / not used by other programs
    home.packages = with pkgs; [
        python3
        python3Packages.pip
        lzip
        jq
        wireguard-tools
        qbittorrent
        gtk3
        gtk4
        libnotify
        dotnetCorePackages.sdk_9_0-bin
        android-tools

        # cli
        rename
        ffmpeg
        aria2
        bc
        flatpak
        ncdu

        # game
        gamescope
        winetricks
        protontricks
        protonplus
        rpcs3
        mangohud

        # image
        gimp
        imv
        mpv
        blender
        kicad

        # music
        nicotine-plus
        puddletag
        beets
        loudgain
        lrcget

        # userland
        nautilus
        nautilus-open-any-terminal
        pavucontrol
        tigervnc
        jetbrains.idea-oss
        vscode-fhs
        filezilla
        uget
    ];
}
