{ pkgs, inputs, config, lib,  ... } :
{
    services.hypridle = {
        enable = true;
        settings = {
            general = {
                lock_cmd = "hyprlock";
                before_sleep_cmd = "hyprlock";
            };

            listener = [
                {
                  timeout = 600;
                  on-timeout = "hyprlock";
                }
            ];
        };
    };
}
