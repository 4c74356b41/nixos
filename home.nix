{
  lib,
  pkgs,
  isLaptop,
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
    stateVersion = "26.05";
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
        htop

        # files
        (pkgs.thunar.override {
          thunarPlugins = [ pkgs.thunar-archive-plugin ];
        })
        xfconf
        file-roller
        # universal-android-debloater
        # android-tools

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
        nixd
        nixfmt

        powershell
        git
        gh
        git-credential-keepassxc

        kubectl
        kubernetes-helm
        fluxcd
        istioctl

        azure-cli
        terraform
        tflint

        jsonnet
        jq
        yq

        # coming from programs
        # code
        # keepassxc
        # foot
        # helium >> this one comes from global config
      ]
      ++ (lib.optional isLaptop pkgs.brightnessctl);
  };
}
