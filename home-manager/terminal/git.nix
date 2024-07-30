let
    name = "klliio";
in {
    programs.git = {
        enable = true;
        extraConfig = {
            color.ui = true;
            core.editor = "nvim";
            github.user = name;
            push.autoSetupRemote = true;
        };
        userEmail = "111129234+klliio@users.noreply.github.com";
        userName = name;
    };
}
