{ userInfo, ... }: {
    networking.hostName = userInfo.hostname;
    networking.hostId = "58c41ee2";
    networking.networkmanager.enable = true;  # Easiest to use and most distros use this by default.
}
