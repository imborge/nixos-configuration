{ pkgs, ... }:

# Created By @icanwalkonwater
# Edited and ported to Nix by Th0rgal

let
  ac = "#1E88E5";
  mf = "#383838";

  bg = "#000000";
  fg = "#FFFFFF";

  transparent = "#00000000";

  # Colored
  primary = "#91ddff";

  # Dark
  secondary = "#141228";

  # Colored (light)
  tertiary = "#65b2ff";

  # white
  quaternary = "#ecf0f1";

  # middle gray
  quinternary = "#20203d";

  # Red
  urgency = "#e74c3c";

in {
  home.file.".local/bin/scripts/pomodoro-bar.sh" = {
    text = ''
    #!/bin/sh

    underline_color="%{u#99c2ff}%{+u}"
    pomo_message=$(${pkgs.emacs}/bin/emacsclient -e '(baj/org-pomodoro-time)' | ${pkgs.coreutils}/bin/cut -d '"' -f 2)
    echo ''${underline_color}''${pomo_message}
  '';
    executable = true;
  };
  services.polybar = {
    enable = true;

    package = pkgs.polybar.override {
      i3Support = true;
      alsaSupport = true;
    };

    #script = "$HOME/.config/polybar/launch-polybar.sh";
    script = ''
        polybar --list-monitors | while IFS=$'\n' read line; do
            monitor=$(echo $line | ${pkgs.coreutils}/bin/cut -d ':' -f 1)
            primary=$(echo $line | ${pkgs.coreutils}/bin/cut -d ' ' -f 3)

            if [[ $primary =~ "(primary)" ]]; then
                MONITOR=$monitor polybar --reload --quiet primary &
            else
                MONITOR=$monitor polybar --reload --quiet secondary &
            fi
        done
    '';

    config = {
      "global/wm" = {
        margin-bottom = 0;
        margin-top = 0;
      };

      #====================BARS====================#

      "bar/primary" = {
        monitor = "\${env:MONITOR:}";
        bottom = true;
        fixed-center = true;

        width = "100%";
        height = 19;

        offset-x = "1%";

        background = bg;
        foreground = fg;

        radius-top = 0;

        padding = 1;

        font-0 = "Iosevka NF:size=10;3";
        font-1 = "Iosevka NF:style=Bold:size=10;3";

        modules-left = "i3";
        modules-right = "pomodoro audio cpu memory battery date tray";

        locale = "en_US.UTF-8";
      };

      "bar/secondary" = {
        monitor = "\${env:MONITOR:}";
        bottom = true;
        fixed-center = true;

        width = "100%";
        height = 19;

        offset-x = "1%";

        background = bg;
        foreground = fg;

        radius-top = 0;

        padding = 1;

        font-0 = "Iosevka NF:size=10;3";
        font-1 = "Iosevka NF:style=Bold:size=10;3";

        modules-left = "i3";
        modules-right = "pomodoro audio cpu memory battery date";

        locale = "en_US.UTF-8";
      };

      "settings" = {
        screenchange-reload = true;

        compositing-background = "source";
        compositing-foreground = "over";
        compositing-overline = "over";
        comppositing-underline = "over";
        compositing-border = "over";

        pseudo-transparency = "false";
      };

      #--------------------MODULES--------------------"

      "module/tray" = {
        type = "internal/tray";
        tray-detached = false;
        tray-maxsize = 15;
        tray-offset-x = -19;
        tray-offset-y = 0;
        tray-padding = 5;
        tray-scale = 1;
      };

      "module/audio" = {
        type = "internal/alsa";

        format-volume = "VOL <label-volume>";
        format-volume-padding = 1;
        format-volume-foreground = secondary;
        format-volume-background = tertiary;
        label-volume = "%percentage%%";

        format-muted = "<label-muted>";
        format-muted-padding = 1;
        format-muted-foreground = secondary;
        format-muted-background = tertiary;
        format-muted-prefix = "婢 ";
        format-muted-prefix-foreground = urgency;
        format-muted-overline = bg;

        label-muted = "VOL Muted";
      };

      "module/battery" = {
        type = "internal/battery";
        full-at = 101; # to disable it
        battery = "BAT1"; # TODO: Better way to fill this
        adapter = "AC1";

        poll-interval = 2;

        label-full = " 100%";
        format-full-padding = 1;
        format-full-foreground = secondary;
        format-full-background = primary;

        format-charging = " <animation-charging> <label-charging>";
        format-charging-padding = 1;
        format-charging-foreground = secondary;
        format-charging-background = primary;
        label-charging = "%percentage%% +%consumption%W";
        animation-charging-0 = "";
        animation-charging-1 = "";
        animation-charging-2 = "";
        animation-charging-3 = "";
        animation-charging-4 = "";
        animation-charging-framerate = 500;

        format-discharging = "<ramp-capacity> <label-discharging>";
        format-discharging-padding = 1;
        format-discharging-foreground = secondary;
        format-discharging-background = primary;
        label-discharging = "%percentage%% -%consumption%W";
        ramp-capacity-0 = "";
        ramp-capacity-0-foreground = urgency;
        ramp-capacity-1 = "";
        ramp-capacity-1-foreground = urgency;
        ramp-capacity-2 = "";
        ramp-capacity-3 = "";
        ramp-capacity-4 = "";
      };

      "module/cpu" = {
        type = "internal/cpu";

        interval = "0.5";

        format = " <label>";
        format-foreground = quaternary;
        format-background = secondary;
        format-padding = 1;

        label = "CPU %percentage%%";
      };

      "module/date" = {
        type = "internal/date";

        interval = "1.0";

        date = "%Y-%m-%d";

        time = "%H:%M:%S";
        time-alt = "%Y-%m-%d%";

        format = "<label>";
        format-padding = 1;
        format-foreground = fg;

        label = "%date% %time%";
      };

      "module/i3" = {
        type = "internal/i3";
        pin-workspaces = true;
        strip-wsnumbers = false;
        format = "<label-state> <label-mode>";
        format-background = tertiary;
        index-sort = true;

        ws-icon-0 = "1;1";
        ws-icon-1 = "2;2";
        ws-icon-2 = "3;3";
        ws-icon-3 = "4;4";
        ws-icon-4 = "5;5";
        ws-icon-5 = "6;6";
        ws-icon-6 = "7;7";
        ws-icon-7 = "8;8";
        ws-icon-8 = "9;9";
        ws-icon-9 = "10;10";

        label-mode = "%mode%";
        label-mode-padding = 1;

        label-unfocused = "%icon%";
        label-unfocused-foreground = "#FFFFFF";
        label-unfocused-background = bg;
        label-unfocused-padding = 1;

        label-focused = "%index%";
        label-focused-font = 2;
        label-focused-foreground = secondary;
        label-focused-background = primary;
        label-focused-padding = 1;

        label-visible = "%icon%";
        label-visible-underline = "#FFFFFF";
        label-visible-padding = 1;

        label-urgent = "%index%";
        label-urgent-foreground = urgency;
        label-urgent-padding = 1;

        #label-separator = "|";
      };

      "module/title" = {
        type = "internal/xwindow";
        format = "<label>";
        format-foreground = secondary;
        label = "%title%";
        label-maxlen = 70;
      };

      "module/memory" = {
        type = "internal/memory";

        interval = 3;

        format = "<label>";
        format-background = tertiary;
        format-foreground = secondary;
        format-padding = 1;

        label = "RAM %percentage_used%%";
      };

      "module/network" = {
        type = "internal/network";
        interface = "enp3s0";

        interval = "1.0";

        accumulate-stats = true;
        unknown-as-up = true;

        format-connected = "<label-connected>";
        format-connected-background = mf;
        format-connected-underline = bg;
        format-connected-overline = bg;
        format-connected-padding = 2;
        format-connected-margin = 0;

        format-disconnected = "<label-disconnected>";
        format-disconnected-background = mf;
        format-disconnected-underline = bg;
        format-disconnected-overline = bg;
        format-disconnected-padding = 2;
        format-disconnected-margin = 0;

        label-connected = "D %downspeed:2% | U %upspeed:2%";
        label-disconnected = "DISCONNECTED";
      };

      "module/temperature" = {
        type = "internal/temperature";

        interval = "0.5";

        thermal-zone = 0; # TODO: Find a better way to fill that
        warn-temperature = 60;
        units = true;

        format = "<label>";
        format-background = mf;
        format-underline = bg;
        format-overline = bg;
        format-padding = 2;
        format-margin = 0;

        format-warn = "<label-warn>";
        format-warn-background = mf;
        format-warn-underline = bg;
        format-warn-overline = bg;
        format-warn-padding = 2;
        format-warn-margin = 0;

        label = "TEMP %temperature-c%";
        label-warn = "TEMP %temperature-c%";
        label-warn-foreground = "#f00";
      };
      
      "module/wireless-network" = {
       type = "internal/network";
       interval = "wlp2s0";
      };

      "module/pomodoro" = {
        type = "custom/script";
        exec-if = "${pkgs.procps}/bin/pgrep -x emacs";
        exec = "~/.local/bin/scripts/pomodoro-bar.sh";
        interval = 1;
      };
    };
  };
}
