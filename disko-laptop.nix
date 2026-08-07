{
  disko.devices = {
    disk = {
      main = {
        type = "disk";
        device = "/dev/nvme0n1";   # adjust if your NVMe is different
        content = {
          type = "gpt";
          partitions = {
            boot = {
              size = "1G";
              type = "EF00";        # EFI system partition
              content = {
                type = "filesystem";
                format = "vfat";
                mountpoint = "/boot";
                mountOptions = [
                  "fmask=0077"
                  "dmask=0077"
                ];
              };
            };
            root = {
              size = "100%";        # rest of the disk
              content = {
                type = "filesystem";
                format = "ext4";    # you can change to btrfs if you prefer
                mountpoint = "/";
                # optional: if you want encryption, add:
                # type = "luks";
                # format = "luks";
                # content = { type = "filesystem"; format = "ext4"; mountpoint = "/"; };
              };
            };
          };
        };
      };
    };
  };
}