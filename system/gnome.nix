{
  pkgs,
  ...
}:
{
  services.desktopManager.gnome.enable = true;
  services.displayManager.gdm.enable = true;
  services.gnome.gnome-browser-connector.enable = true;
  environment.gnome.excludePackages = with pkgs; [
    baobab
    decibels
    epiphany
    geary
    gnome-connections
    gnome-console
    gnome-contacts
    gnome-logs
    gnome-maps
    gnome-music
    gnome-software
    gnome-system-monitor
    gnome-text-editor
    gnome-tour
    gnome-weather
    loupe
    papers
    showtime
    simple-scan
    snapshot
  ];
}
