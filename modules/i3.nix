{ pkgs, ... }:

{
    services.xserver.windowManager.i3 = {
      enable = true;
      extraPackages = with pkgs; [
        rofi
      ];
    };
}
