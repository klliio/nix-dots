
{ pkgs, userInfo, ... } :
{
    programs.ydotool = {
        enable = true;
    };
    users.users.${userInfo.username}.extraGroups = [ "ydotool" ];
}
