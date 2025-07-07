{ pkgs, userInfo, ... }:
{
  environment.systemPackages = with pkgs; [
    makima
  ];

  systemd.services.makima = {
    enable = true;
    description = "makima remapping daemon.";
    wantedBy = [ "default.target" ];
    script = "${pkgs.makima}/bin/makima";
    serviceConfig = {

    # throws error because it is unable to access the users path
    Environment = "PATH=/home/klliio/.local/bin:/run/wrappers/bin:/home/klliio/.local/share/flatpak/exports/bin:/var/lib/flatpak/exports/bin:/home/klliio/.nix-profile/bin:/nix/profile/bin:/home/klliio/.local/state/nix/profile/bin:/etc/profiles/per-user/klliio/bin:/nix/var/nix/profiles/default/bin:/run/current-system/sw/bin:/nix/store/hhfm5fkvb1alg1np5a69m2qlcjqhr062-binutils-wrapper-2.44/bin:/nix/store/2cwp49w4q8j6kmi3qxb1g62kbnlgvgsk-hyprland-qtutils-0.1.4+date=2025-06-05_396e8aa/bin:/nix/store/fx0cjyvqjmfnbqxcd60bwaf36ak16q2q-pciutils-3.13.0/bin:/nix/store/scygnffjs378x8h9ssk2fk765p80g030-pkgconf-wrapper-2.4.3/bin";
      Type = "simple";
      User = "${userInfo.username}";
      Group = "input";
      Restart = "always";
      RestartSec = "3";
    };
  };
}
