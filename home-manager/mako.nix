{ pkgs, ... } :
{
    services.mako = {
        enable = true;
        settings = {
            sort = "+time";
            icons = true;
            default-timeout = 2000;
            ignore-timeout = true;
        };
    };
}
