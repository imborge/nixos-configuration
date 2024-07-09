{ pkgs, lib, ... }: {
  xsession.windowManager.i3 = {
    enable = true;
    config = rec {
      modifier = "Mod4";
      keybindings = lib.mkOptionDefault {
        "${modifier}+Return" = "exec kitty";

        "${modifier}+d" = "exec \"rofi -modi drun,run -show drun\"";
        
        "${modifier}+j" = "focus left";
        "${modifier}+k" = "focus down";
        "${modifier}+l" = "focus up";
        "${modifier}+semicolon" = "focus right";
        
        "${modifier}+Shift+j" = "move left";
        "${modifier}+Shift+k" = "move down";
        "${modifier}+Shift+l" = "move up";
        "${modifier}+Shift+semicolon" = "move right";

        "XF86AudioRaiseVolume" = "exec --no-startup-id pactl set-sink-volume @DEFAULT_SINK@ +5%";
        "XF86AudioLowerVolume" = "exec --no-startup-id pactl set-sink-volume @DEFAULT_SINK@ -5%";
        "XF86AudioMute" = "exec --no-startup-id pactl set-sink-mute @DEFAULT_SINK@ toggle";
        "XF86AudioMicMute" = "exec --no-startup-id pactl set-source-mute @DEFAULT_SOURCE@ toggle";
        "XF86AudioNext" = "exec --no-startup-id playerctl next";
        "XF86AudioPrev" = "exec --no-startup-id playerctl previous";
        "XF86AudioPlay" = "exec --no-startup-id playerctl play-pause";
      };

      bars = [
        # {
        #   position = "bottom";
        #   statusCommand = "${pkgs.i3status-rust}/bin/i3status-rs ${./i3status-rust.toml}";
        # }
      ];

      startup = [
        {
          command = "picom";
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
          output = "eDP";
        }
        {
          workspace = "7";
          output = "eDP";
        }
        {
          workspace = "8";
          output = "eDP";
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
