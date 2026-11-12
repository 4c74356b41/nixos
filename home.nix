{
  lib,
  pkgs,
  isLaptop,
  antigravity-nix,
  # nixpkgs-unstable,
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

        # nixos
        fastfetch
        btop
        podman-compose

        # files
        (pkgs.thunar.override {
          thunarPlugins = [ pkgs.thunar-archive-plugin ];
        })
        xfconf
        file-roller

        # network
        curl
        bind
        networkmanagerapplet
        networkmanager_dmenu

        # bluetooth
        rofi-bluetooth
        playerctl

        # tools
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
        # terraform
        # tflint

        jsonnet
        jq
        yq

        antigravity-nix.packages.${pkgs.stdenv.hostPlatform.system}.google-antigravity-cli
        yt-dlp

        claude-code
        codex
        rtk

        # defined in home/programs.nix
        # code
        # keepassxc
        # foot
        # defined in configuration.nix
        # helium
      ]
      ++ (lib.optional isLaptop pkgs.brightnessctl)
      ++ (lib.optionals (!isLaptop) [
        pkgs.android-studio
        pkgs.android-tools
        pkgs.jdk17
      ]);
  };
}
