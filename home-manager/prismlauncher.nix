{
  pkgs,
  ...
}:
{
  home.packages = with pkgs; [
    (prismlauncher.override {

      jdks = [
        zulu17
        zulu21
        zulu25
      ];
    })
  ];
}
