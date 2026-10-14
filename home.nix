{
  lib,
  pkgs,
  isLaptop,
  nixpkgs-unstable,
  antigravity-nix,
  ...
}:
let
  pkgs-unstable = import nixpkgs-unstable {
    inherit (pkgs) system;
    config = pkgs.config;
  };
in
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

        # nixos debug
        fastfetch
        btop

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

        python312
        powershell
        git
        gh
        git-credential-keepassxc

        # kubectl
        # kubernetes-helm
        # fluxcd
        # istioctl

        azure-cli
        terraform
        tflint

        jsonnet
        jq
        yq

        antigravity-nix.packages.${pkgs.stdenv.hostPlatform.system}.google-antigravity-cli
        pkgs-unstable.yt-dlp

        # defined in programs
        # code
        # keepassxc
        # foot
        # defined in global config
        # helium
      ]
      ++ (lib.optional isLaptop pkgs.brightnessctl);
  };
}
