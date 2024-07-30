{ pkgs, ... } :
{
    services.mako = {
        enable = true;
        sort = "+time";
        icons = true;
        defaultTimeout = 2000;
        ignoreTimeout = true;
    };
}
