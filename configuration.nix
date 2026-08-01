{ config, lib, pkgs, ... }: 
{
  imports = [
    ./hardware-configuration.nix
  ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  
  networking.networkmanager.enable = true;
  time.timeZone = "Europe/Minsk";

  programs = {
    sway = {
      enable = true;
      wrapperFeatures.gtk = true;
    };
    waybar.enable = false;
  };

  environment.systemPackages = with pkgs; [
    git
    gh
  ];

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
    blueman = {
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
    StandartOutput = "tty";
    StandardError = "journal";
    TTYReset = true;
    TTYVHangup = true;
    TTYVTDisallocate = true;
  };

  virtualisation = {
    containers = {
      enable = true;
      registries = {
        search = [ "docker.io" ];
        insecure = [ ];
        block = [ ];
      };
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
    ];
  };
}
