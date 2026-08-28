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
      "org.mozilla.Thunderbird"
    ];

    update.onActivation = true;
  };
}
