{ pkgs, ... } :
{
    services.mako = {
        enable = true;
        settings = {
            sort = "+time";
            icons = true;
            defaultTimeout = 2000;
            ignoreTimeout = true;
        };
    };
}
