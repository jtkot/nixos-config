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

  hardware.nvidia.open = true;
  hardware.nvidia.powerManagement.enable = true;
  services.xserver.videoDrivers = [ "nvidia" ];

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
        "fmask=0022"
        "dmask=0022"
      ];
    };
  };

  # ddcci
  hardware.i2c.enable = true;
  systemd.services."ddcci@" = {
    description = "DDC/CI device auto-attachment for NVIDIA";
    scriptArgs = "%i";
    script = ''
      		echo Trying to attach ddcci to $1
      		id=$(echo $1 | cut -d "-" -f 2)
      		if ${pkgs.ddcutil}/bin/ddcutil getvcp 10 -b $id --discard-cache; then
      			echo "ddcci 0x37" > /sys/bus/i2c/devices/$1/new_device
      			echo "ddcci attached to $1"
      		fi
      	'';
    serviceConfig.Type = "oneshot";
  };

  services.udev.extraRules = ''
    SUBSYSTEM=="i2c-dev", ACTION=="add",\
      ATTR{name}=="NVIDIA i2c adapter*",\
      TAG+="ddcci",\
      TAG+="systemd",\
      ENV{SYSTEMD_WANTS}+="ddcci@$kernel.service"
  '';

  boot.extraModulePackages = with config.boot.kernelPackages; [ ddcci-driver ];
  boot.kernelModules = [
    "ddcci_backlight"
    "kvm-intel"
  ];
  environment.systemPackages = with pkgs; [
    ddcutil
  ];
}
