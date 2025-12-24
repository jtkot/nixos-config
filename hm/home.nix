{ pkgs, ... }:
{
  home.username = "jan";
  home.homeDirectory = "/home/jan";

  home.stateVersion = "25.11";
  home.packages = with pkgs; [
    bottom
    fastfetch
    file
    fzf
    gh
    gimp
    git
    ibm-plex
    imagemagick
    jq
    jujutsu
    license-cli
    mpv
    nix-index
    nix-tree
    nixd
    nixfmt-rfc-style
    nur.repos.Ev357.helium
    p7zip
    patchelf
    ripgrep
    tmux
    widevine-cdm
    xdg-user-dirs
    yq
    yt-dlp
  ];

  fonts.fontconfig.enable = true;
}
