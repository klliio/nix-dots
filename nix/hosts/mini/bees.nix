{
  config,
  lib,
  pkgs,
  ...
}:
{
    services.beesd.filesystems = {
        root = {
            spec = "LABEl=root";
            hashTableSizeMB = 256;
            verbosity = "crit";
            extraOptions = [ "--loadavg-target" "5.0" ];
        };
    };
}
