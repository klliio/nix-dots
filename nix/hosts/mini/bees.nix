{
  config,
  lib,
  pkgs,
  ...
}:
{
    services.beesd.filesystems = {
        root = {
            spec = "UUID=be0aadf7-f1d7-470d-ac23-df671f48761f";
            hashTableSizeMB = 256;
            verbosity = "crit";
            extraOptions = [ "--loadavg-target" "5.0" ];
        };
    };
}
