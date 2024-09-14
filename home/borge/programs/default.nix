{ pkgs, ... }:

{
  imports = [
    ./emacs.nix
    ./fzf.nix;
    ./media.nix
  ];

  home.packages = with pkgs; [
    pcmanfm
    qbittorrent
    killall
  ];
}
