{ pkgs, ... }:
{
  home.username = "jan";
  home.homeDirectory = "/home/jan";

  home.stateVersion = "25.11";
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
	license-cli
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
