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
        temurin-bin-17
        temurin-bin-21
        temurin-bin-25
      ];
    })
  ];
}
