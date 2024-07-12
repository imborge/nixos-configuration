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
    alsa-utils
  ];

  services.playerctld.enable = true;
}
