{
  lib,
  pkgs,
  ...
}:
{
  system.stateVersion = lib.versions.majorMinor lib.version;
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];
  nixpkgs = {
    config.allowUnfree = true;
    overlays = [ (import ./overrides.nix) ];
  };
  documentation.nixos.enable = false;

  # NixOS 25.05 patches
  services.hardware.openrgb.package = pkgs.openrgb-beta;

  boot.consoleLogLevel = 0;
  boot.initrd.verbose = false;
  boot.kernelPackages = pkgs.linuxPackages_lqx;
  boot.kernelParams = [
    "quiet"
    "udev.log_level=3"
  ];
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.timeout = 0;
  boot.lanzaboote = {
    enable = true;
    pkiBundle = "/var/lib/sbctl";
  };
  boot.plymouth.enable = true;

  security.polkit.enable = true;
  security.rtkit.enable = true;
  security.sudo.extraConfig = "Defaults pwfeedback";

  time.timeZone = "Europe/Warsaw";
  i18n.defaultLocale = "pl_PL.UTF-8";
  console = {
    font = "Lat2-Terminus16";
    useXkbConfig = true;
  };

  users.users.jan = {
    description = "Jan Kot";
    isNormalUser = true;
    extraGroups = [
      "wheel"
      "plugdev"
    ];
    shell = pkgs.fish;
  };

  environment.systemPackages = with pkgs; [
    adwaita-icon-theme
    ags
    brightnessctl
    backports.ghostty
    grim
    hyprpaper
    hyprlock
    hyprpolkitagent
	hypridle
	hyprsunset
    nautilus
    nh
    sbctl
    slurp
    walker
    wl-clipboard
  ];
  fonts.packages = [ pkgs.font-awesome ];

  hardware.keyboard.qmk.enable = true;
  hardware.enableRedistributableFirmware = true;
  hardware.graphics.enable = true;

  programs.fish.enable = true;
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };
  programs.neovim = {
    enable = true;
    defaultEditor = true;
  };
  programs.hyprland = {
    enable = true;
    withUWSM = true;
  };
  programs.command-not-found.enable = true;
  programs.gnome-disks.enable = true;

  networking.networkmanager.enable = true;
  networking.firewall.enable = false;
  services.resolved.enable = true;

  services.flatpak.enable = true;
  services.fwupd.enable = true;
  services.gvfs.enable = true;
  services.playerctld.enable = true;
  services.timesyncd.servers = [ "time.apple.com" ];
  services.printing.enable = true;
  services.upower.enable = true;
  services.pipewire = {
    enable = true;
    audio.enable = true;
  };
  services.xserver = {
    enable = true;
    excludePackages = with pkgs; [ xterm ];
    xkb.layout = "pl";
  };
  services.displayManager.gdm.enable = true;

  systemd.user.services.hyprpolkitagent = {
    description = "hyprpolkitagent";
    wantedBy = [ "graphical-session.target" ];
    wants = [ "graphical-session.target" ];
    after = [ "graphical-session.target" ];
    serviceConfig = {
      Type = "simple";
      ExecStart = "${pkgs.hyprpolkitagent}/libexec/hyprpolkitagent";
      Restart = "on-failure";
      RestartSec = 1;
      TimeoutStopSec = 10;
    };
  };
}
