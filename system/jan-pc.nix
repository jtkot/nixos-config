{
  config,
  lib,
  pkgs,
  ...
}:
{
  imports = [ ./base.nix ];
  networking.hostName = "jan-pc";
  services.openssh.enable = true;
  services.displayManager.gdm.autoSuspend = false;
  networking.networkmanager.wifi.powersave = false;

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;

  hardware.bluetooth.enable = true;
  services.hardware.openrgb.enable = true;

  services.xserver.videoDrivers = [ "nvidia" ];
  hardware.nvidia = {
    open = true;
    nvidiaSettings = false;
  };

  # NVIDIA 595+; remove it in 26.05
  hardware.nvidia.powerManagement.enable = false; # enable this!
  hardware.nvidia.package = config.boot.kernelPackages.nvidiaPackages.latest;
  boot.kernelPackages = pkgs.backports.linuxPackages;
  boot.kernelParams = [ "nvidia.NVreg_UseKernelSuspendNotifiers=1" ];

  boot.kernelModules = [ "kvm-intel" ];
  boot.initrd.availableKernelModules = [
    "xhci_pci"
    "thunderbolt"
    "ahci"
    "nvme"
    "usbhid"
    "usb_storage"
    "sd_mod"
  ];

  fileSystems = {
    "/" = {
      device = "/dev/disk/by-uuid/1a1bb588-b80b-47be-b469-3f97dc05f1ba";
      fsType = "btrfs";
      options = [
        "compress=zstd"
        "subvol=root"
      ];
    };

    "/home" = {
      device = "/dev/disk/by-uuid/1a1bb588-b80b-47be-b469-3f97dc05f1ba";
      fsType = "btrfs";
      options = [
        "compress=zstd"
        "subvol=home"
      ];
    };

    "/nix" = {
      device = "/dev/disk/by-uuid/1a1bb588-b80b-47be-b469-3f97dc05f1ba";
      fsType = "btrfs";
      options = [
        "compress=zstd"
        "noatime"
        "subvol=nix"
      ];
    };

    "/boot" = {
      device = "/dev/disk/by-uuid/59D7-B538";
      fsType = "vfat";
      options = [
        "umask=0077"
      ];
    };
  };
}
