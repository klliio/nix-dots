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

        # cli
        rename
        ffmpeg
        aria2
        bc
        flatpak

        # game
        prismlauncher
        gamemode
        gamescope
        wineWowPackages.waylandFull # 32 and 64
        winetricks
        protontricks
        lutris
        openttd-jgrpp
        rpcs3
        mangohud
        unigine-superposition
        lsfg-vk
        lsfg-vk-ui

        # image
        gimp
        inkscape
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
        pavucontrol
        tigervnc
        jetbrains.idea-community
        vscode-fhs
        filezilla
        uget
    ];
}
