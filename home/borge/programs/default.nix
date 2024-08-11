{ pkgs, ... }:

{
  imports = [
    ./media.nix
    ./emacs.nix
  ];

  home.packages = with pkgs; [
    pcmanfm
    qbittorrent
    killall
    brave
  ];
}
