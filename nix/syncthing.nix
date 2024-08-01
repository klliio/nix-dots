{ userInfo, ... }: {
    services.syncthing = {
        enable = true;
        user = userInfo.username;
        dataDir = "/home/${userInfo.username}/Syncthing";
        configDir = "/home/${userInfo.username}/.config/syncthing";
        overrideDevices = true;     # overrides any devices added or deleted through the WebUI
        overrideFolders = false;     # overrides any folders added or deleted through the WebUI
        settings = {
            devices = {
                "pixel" = { id = "TA6YGIP-ZPMMDCL-TZ35VAD-VBGDY4E-YJ4QWCL-RDUUA4V-QH7BVRF-73DYGQQ"; };
            };
            folders = {
                "Passwords" = {         # Name of folder in Syncthing, also the folder ID
                    path = "/home/${userInfo.username}/Passwords";    # Which folder to add to Syncthing
                    devices = [ "pixel" ];      # Which devices to share the folder with
                };
                "Obsidian" = {
                    path = "/home/${userInfo.username}/Obsidian";
                    devices = [ "pixel" ];
                };
                "Mihon" = {
                    path = "/home/${userInfo.username}/Backups";
                    devices = [ "pixel" ];
                };
            };
        };
    };
}
