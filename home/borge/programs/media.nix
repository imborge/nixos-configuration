{ pkgs, ... }:

{
  home.packages = with pkgs; [
    playerctl
    mediainfo
    ffmpeg-full
    imagemagick
    librsvg
    mpv
    obs-studio
  ];

  services.playerctld.enable = true;
}
