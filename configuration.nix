{
  config,
  lib,
  pkgs,
  helium-flake,
  ...
}:
{
  imports = [
    helium-flake.nixosModules.default
    ./flatpak.nix
  ];

  time.timeZone = "Europe/Minsk";
  boot = {
    loader.systemd-boot.enable = true;
    loader.efi.canTouchEfiVariables = true;
  };

  nix = {
    gc = {
      automatic = true;
      dates = [
        "09:00"
      ];
      options = "--delete-older-than 5d";
    };
    settings.experimental-features = [
      "nix-command"
      "flakes"
    ];
  };

  nixpkgs.config.allowUnfree = true;

  networking = {
    networkmanager = {
      enable = true;
      dns = "systemd-resolved";
    };
  };

  programs = {
    sway = {
      enable = true;
      wrapperFeatures.gtk = true;
    };
    waybar.enable = false; # managed by home-manager. until toggling this off I had 2 waybars :)
    helium = {
      enable = true;
      policies = {
        "BrowserSignin" = 0;
        "PasswordManagerEnabled" = false;
        "SyncDisabled" = true;
        "HomepageLocation" = "https://youtube.com";
        "DownloadDirectory" = "/home/sway/downloads";
        "DefaultSearchProviderEnabled" = true;
        "DefaultSearchProviderSearchURL" = "https://www.google.com/search?q={searchTerms}";
        "RestoreOnStartup" = 1;
        "ExtensionInstallForcelist" = [
          "oboonakemofpalcgghocfoadofidjkkk" # keepassxc
          "hipncndjamdcmphkgngojegjblibadbe" # freeplanetvpn
          "ponfpcnoihfmfllpaingbgckeeldkhle" # enhancer for youtube
        ];
      };
      flags = [
        "--new-window"
        "--start-maximized"
        "--ozone-platform=wayland"
        "--enable-features=VaapiVideoDecodeLinuxGL,VaapiVideoDecoder,WaylandWindowDecorations"
        "--ignore-gpu-blocklist"
        "--enable-gpu-rasterization"
        "--enable-zero-copy"
      ];
    };
  };

  services = {
    speechd = {
      enable = false;
    };

    greetd = {
      enable = true;
      settings = {
        default_session = {
          user = "greeter";
          command = "${lib.getExe pkgs.tuigreet} --asterisks --user-menu --cmd sway";
        };
      };
    };
    onedrive = {
      enable = true;
    };
    pipewire = {
      enable = true;
      alsa.enable = true;
      pulse.enable = true;
    };
    power-profiles-daemon = {
      enable = config.networking.hostName == "laptop";
    };
    resolved = {
      enable = true;
    };
    gvfs = {
      enable = true;
    };
    dbus = {
      enable = true;
    };
  };

  xdg.portal = {
    enable = true;
    wlr.enable = true;
  };

  systemd.services.greetd.serviceConfig = {
    Type = "idle";
    StandardInput = "tty";
    StandardOutput = "tty";
    StandardError = "journal";
    TTYReset = true;
    TTYVHangup = true;
    TTYVTDisallocate = true;
  };

  virtualisation = {
    containers = {
      enable = true;
      registries.settings.unqualified-search-registries = [
        "docker.io"
        "ghcr.io"
        "mirror.gcr.io"
        "quay.io"
        "mcr.microsoft.com"
      ];
    };
    podman = {
      enable = true;
      defaultNetwork.settings.dns_enabled = true;
    };
  };

  users.users.sway = {
    isNormalUser = true;
    extraGroups = [
      "wheel"
      "podman"
      "networkmanager"
      "adbusers"
    ];
  };

  system.stateVersion = "26.05";
}
