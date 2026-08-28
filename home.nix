{
  config,
  lib,
  pkgs,
  isLaptop,
  helium-flake,
  ...
}:
{
  imports = [
    ./home/waybar.nix
    ./home/dotfiles.nix
    ./home/programs.nix
    ./home/sway.nix
  ];

  home = {
    username = "sway";
    homeDirectory = "/home/sway";
    stateVersion = "26.11"; # Bumped to 26.11
    packages =
      with pkgs;
      [
        # quality of life
        ksnip
        rofi
        grim
        slurp
        wl-clipboard
        copyq
        fastfetch

        # files
        (pkgs.thunar.override {
          thunarPlugins = [ pkgs.thunar-archive-plugin ];
        })
        xfconf
        file-roller
        universal-android-debloater
        android-tools

        # network
        curl
        bind
        networkmanagerapplet
        networkmanager_dmenu

        # bluetooth
        rofi-bluetooth
        playerctl

        # tools
        code
        nixd # nix ide support
        nixfmt-rfc-style # nix ide support

        powershell
        git
        gh
        git-credential-manager

        kubectl
        kubernetes-helm
        fluxcd
        istioctl

        azure-cli
        terraform

        jsonnet
        jq
        yq
      ]
      ++ (lib.optional isLaptop pkgs.brightnessctl);
  };
}
