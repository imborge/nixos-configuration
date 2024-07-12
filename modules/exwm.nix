{ pkgs, lib, ... }:

{
  services.xserver = {
    displayManager.session = lib.singleton {
      name = "exwm";
      manage = "window";
      start = ''
        xhost +SI:localuser:$USER
        exec emacs --debug-init --with-exwm
      '';
    };
  };

  environment.systemPackages = with pkgs; [
    xorg.xhost
  ];
}
