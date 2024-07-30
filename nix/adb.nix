{ pkgs, services, userInfo, ... }: {
    programs.adb.enable = true;
    users.users.${userInfo.username}.extraGroups = [ "adbusers" ];
}
