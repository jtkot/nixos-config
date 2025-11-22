{ pkgs, ... }:
{
  home.username = "jan";
  home.homeDirectory = "/home/jan";

  home.stateVersion = "25.05";
  home.packages = with pkgs; [
    bottom
    fastfetch
    file
    gh
    gimp
    git
    nur.repos.Ev357.helium
    ibm-plex
    imagemagick
    jujutsu
    jq
    mpv
    nix-index
    nix-tree
    nixd
    nixfmt-rfc-style
    p7zip
    patchelf
    ripgrep
    tmux
    xdg-user-dirs
    widevine-cdm
    yq
  ];

  fonts.fontconfig.enable = true;
}
