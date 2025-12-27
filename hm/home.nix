{ pkgs, ... }:
{
  home.username = "jan";
  home.homeDirectory = "/home/jan";

  home.stateVersion = "25.11";
  home.packages = with pkgs; [
    bintools
    bottom
	d-spy
    fastfetch
    file
    fzf
    gdb
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
    qview
    pax-utils
    ripgrep
    tmux
    unzip
    widevine-cdm
    yq
    yt-dlp
    zbar
  ];

  fonts.fontconfig.enable = true;
  xdg.userDirs = {
    enable = true;
    createDirectories = true;
  };
}
