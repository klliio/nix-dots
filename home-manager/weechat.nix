{ pkgs, ... }: {
    home.packages = with pkgs; [
        weechat
        weechatScripts.autosort
        weechatScripts.colorize_nicks
    ];
}
