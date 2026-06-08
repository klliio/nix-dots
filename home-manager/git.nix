let
    name = "klliio";
in {
    programs.git = {
        enable = true;
        signing.format = null;
        settings = {
            color.ui = true;
            core.editor = "nvim";
            github.user = name;
            push.autoSetupRemote = true;
            user.email = "111129234+klliio@users.noreply.github.com";
            user.name = name;
        };
    };
}
