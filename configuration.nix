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
    waybar.enable = false;
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
        "--ozone-platform=x11"
        "--start-maximized"
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
          command = "${lib.getExe pkgs.tuigreet} --time --asterisks --user-menu --cmd sway";
        };
      };
    };
    onedrive = {
      enable = true;
    };
    flatpak = {
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

  system.stateVersion = "26.11";
}
