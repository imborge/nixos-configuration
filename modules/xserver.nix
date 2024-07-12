{ pkgs, lib, ... }:

{
  services.xserver = {
    xkb.layout = "us,no";

    xkb.options = "compose:ralt";
    enable = true;

    desktopManager = {
      xterm.enable = false;
    };
  };

  services.displayManager = {
    sddm.enable = true;
    defaultSession = lib.mkDefault "none+exwm";
  };
}
