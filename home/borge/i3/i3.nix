{ pkgs, lib, ... }: {
  home.packages = with pkgs; [
  ];

  xsession.windowManager.i3 = {
    enable = true;
    config = rec {
      # Super/Win
      modifier = "Mod4";

      keybindings = lib.mkOptionDefault {
        "${modifier}+Return" = "exec wezterm";

        "${modifier}+d" = "exec \"rofi -modi drun,run -show drun\"";
        
        "${modifier}+h" = "focus left";
        "${modifier}+l" = "focus right";
        "${modifier}+k" = "focus up";
        "${modifier}+j" = "focus down";

        "${modifier}+Shift+h" = "move left";
        "${modifier}+Shift+l" = "move down";
        "${modifier}+Shift+k" = "move up";
        "${modifier}+Shift+j" = "move right";

        "${modifier}+-"  = "split horizontal";
        "${modifier}+\\" = "split vertical";

        "${modifier}+f"       = "fullscreen toggle";
        "${modifier}+Shift+f" = "floating toggle";

        # mod+Shift+-
        "${modifier}+_" = "layout horizontal";
        # mod+Shift+\
        "${modifier}+|" = "layout vertical";
        "${modifier}+t" = "layout toggle all";

        # Create quick emacs org-capture frame
        "${modifier}+c" = "exec --no-startup-id emacsclient --alternate-editor='' --create-frame --no-wait --eval '(baj/org-capture-from-desktop)'";

        "XF86AudioRaiseVolume" = "exec --no-startup-id amixer -M set Master 5%+";
        "XF86AudioLowerVolume" = "exec --no-startup-id amixer -M set Master 5%-";
        "XF86AudioMute"        = "exec --no-startup-id amixer -M set Master toggle";
        "XF86AudioNext"        = "exec --no-startup-id playerctl next";
        "XF86AudioPrev"        = "exec --no-startup-id playerctl previous";
        "XF86AudioPlay"        = "exec --no-startup-id playerctl play-pause";
      };

      # gaps.inner = 10;

      # Using polybar
      bars = [
      ];

      startup = [
        {
          command = "picom";
          always = true;
          notification = false;
        }
        {
          command = "sh /home/borge/.screenlayout/std.sh";
          always = true;
          notification = false;
        }
        {
          command = "systemctl --user restart polybar.service";
          always = true;
          notification = false;
        }
      ];

      workspaceOutputAssign = [
        {
          workspace = "1";
          output = ["HDMI-A-0" "eDP"];
        }
        {
          workspace = "2";
          output = ["HDMI-A-0" "eDP"];
        }
        {
          workspace = "3";
          output = ["HDMI-A-0" "eDP"];
        }
        {
          workspace = "4";
          output = ["HDMI-A-0" "eDP"];
        }
        {
          workspace = "5";
          output = ["HDMI-A-0" "eDP"];
        }
        {
          workspace = "6";
          output = ["HDMI-A-0" "eDP"];
        }
        {
          workspace = "7";
          output = ["HDMI-A-0" "eDP"];
        }
        {
          workspace = "8";
          output = ["HDMI-A-0" "eDP"];
        }
        {
          workspace = "9";
          output = "eDP";
        }
        {
          workspace = "10";
          output = "eDP";
        }
      ];

      terminal = "kitty";
    };
  };
}
