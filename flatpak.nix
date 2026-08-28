{
  config,
  lib,
  pkgs,
  ...
}:

{
  services.flatpak = {
    enable = true;

    packages = [
      "com.microsoft.Edge"
      "org.telegram.desktop"
      "com.rtosta.zapzap"
      "org.mozilla.thunderbird_esr"
    ];

    update = {
      onActivation = true;
      auto = {
        enable = true;
        onCalendar = "daily";
      };
    };
  };
}
