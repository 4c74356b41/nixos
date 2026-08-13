{ config, lib, pkgs, modulesPath, ... }:
let
  modprobedDb = /home/sway/.config/modprobed.db;
in
{
  imports = [
    ( modulesPath + "/installer/scan/not-detected.nix" )
  ];

  boot = {
    initrd = {
      availableKernelModules = [ "nvme" "xhci_pci" "thunderbolt" "usbhid" "usb_storage" "sd_mod" ];
      kernelModules = [ ];
    };
    swraid = {
      enable = true;
      mdadmConf = ''
        PROGRAM ${pkgs.inetutils}/bin/logger -t mdadm-raid-alert
      '';
    };
    extraModulePackages = [ ];
    kernelModules = [ "kvm-amd" ];
  };

  fileSystems."/" = {
    device = "/dev/disk/by-uuid/165aecac-61c8-477b-9e5f-2d561242aeb6";
    fsType = "ext4";
  };

  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/12CE-A600";
    fsType = "vfat";
    options = [ "fmask=0022" "dmask=0022" ];
  };

  swapDevices = [ ];

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware = {
    bluetooth.enable = true;
    bluetooth.powerOnBoot = true;
    cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
  };
}
