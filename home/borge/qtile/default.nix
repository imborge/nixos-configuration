{ pkgs, ... }:

{
  home.file = {
    qtile_config = {
      source = ./config.py;
      target = ".config/qtile/config.py";
    };
    qtile_autostart = {
      executable = true;
      text = ''
        #!/usr/bin/env bash
        ${pkgs.picom}/bin/picom --daemon &

        /home/borge/.screenlayout/std.sh &
        sleep 1

        ALTERNATE_EDITOR="" ${pkgs.emacs}/bin/emacsclient -e '(delete-frame)'
        ${pkgs.feh}/bin/feh --bg-center /home/borge/wallpapers/nature/arr8f7jqzbgd1.png
      '';
      target = ".config/qtile/autostart.sh";
    };
  };
}
