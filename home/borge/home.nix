{ inputs, config, pkgs, lib, ... }:

{  
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "borge";
  home.homeDirectory = "/home/borge";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "23.11"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = [
    # system ops
    pkgs.htop
    pkgs.btop
    pkgs.tree
    pkgs.ripgrep
    pkgs.fd
    pkgs.procps

    pkgs.pinentry-curses
    pkgs.keychain

    # email
    pkgs.protonmail-bridge
    pkgs.mu
    pkgs.isync
    pkgs.meson

    # Development
    pkgs.emacs-all-the-icons-fonts
    pkgs.emacs-lsp-booster
    pkgs.gnumake
    pkgs.eask # for developing emacs packages
    pkgs.entr
    # inputs.devenv.packages."${pkgs.system}".devenv
    pkgs.cachix
    pkgs.scc

    # pkgs.python3
    # JS/TS world
    pkgs.corepack # for pnpm
    pkgs.nodePackages.prettier

    # golang
    pkgs.go_1_22    # go lang
    pkgs.gopls # go language server
    pkgs.gotools
    pkgs.godef # find symbol information in Go source
    #pkgs.air # live reload for Go apps

    # lua
    pkgs.lua-language-server

    # rust
    pkgs.rustup

    # Utilities
    pkgs.flameshot # screenshots
    pkgs.git-sync
    pkgs.graphviz
    pkgs.playerctl
    pkgs.sound-theme-freedesktop
    pkgs.imagemagick
    pkgs.mediainfo
    pkgs.elinks
    pkgs.ffmpeg-full
    pkgs.vimb

    # postgres linter
    # pkgs.squawk
    # pkgs.libpg_query # squawk dependency

    # Communication
    pkgs.discord

    # dev libs
    pkgs.glib
    pkgs.pango
    pkgs.gdk-pixbuf
    pkgs.atkmm
    pkgs.gobject-introspection
    pkgs.libepoxy
    pkgs.gtk4
    pkgs.pkg-config
  ];

  services.playerctld.enable = true;

  services.blueman-applet = {
    enable = true;
  };

  services.poweralertd.enable = true;
  # services.emacs = {
  #   enable = true;
  #   startWithUserSession = "graphical";
  # };

  services.ssh-agent = {
    enable = true;
  };

  services.git-sync = {
    enable = true;
    repositories = {
      org-files = {
        path = "/home/borge/org";
        uri = "git@github.com:imborge/org.git";
      };
    };
  };

  services.syncthing = {
    enable = true;
    extraOptions = [];
  };

  # services.dunst = {
  #   settings = {
  #     global = {
  #       follow = "keyboard";
  #     };
  #   };
  # };

  services.redshift = {
    enable = true;
    tray = true;

    # Oslo
    latitude = 59.9139;
    longitude = 10.7522;
  };

  systemd.user.targets.tray = {
    Unit = {
      Description = "Home Manager System Tray";
			Requires = [ "graphical-session-pre.target" ];
    };
  };

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;
    # ".profile".text = ''
    #   # GENERATED FILE - Do not edit this manually.
    #   setxkbmap -option caps:escape
    # '';
    # ".zprofile".text = ''
    #   # GENERATED FILE - Do not edit this manually.
    #   setxkbmap -option caps:escape
    # '';

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. If you don't want to manage your shell through Home
  # Manager then you have to manually source 'hm-session-vars.sh' located at
  # either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/borge/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
    # EDITOR = "emacs";
    GOPATH = "$HOME/go";
  };
  home.sessionPath = [ "$HOME/go/bin" ];

  nixpkgs.config.allowUnfree = true;
  
  # https://github.com/nix-community/home-manager/issues/2942
  nixpkgs.config.allowUnfreePredicate = (_: true);

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  programs.gpg = {
    enable = true;
  };

  services.gpg-agent = {
    enable = true;
    pinentryPackage = pkgs.pinentry-gtk2;
    extraConfig = ''
      allow-emacs-pinentry
      allow-loopback-pinentry
    '';
  };

  programs.kitty = {
    enable = true;
    theme = "Tokyo Night";
    font = {
      name = "JetBrainsMono NF";
      size = 11;
    };
    settings = {
      shell_integration = "no-cursor";
    };
  };

  programs.tmux = {
    enable = true;
    clock24 = true;
    keyMode = "emacs";
    mouse = false;
    shell = "${pkgs.zsh}/bin/zsh";
    prefix = "C-b";
    # no delay when pressing <Esc>
    escapeTime = 0;
    extraConfig = ''
      set -g status-bg black
      set -g status-fg white
    '';
  };

  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
  };

  programs.rofi = {
    enable = true;
  };
  
  programs.zsh = {
    enable = true;
    shellAliases = {
      l = "ls -alh";
      ll = "ls -l";
      update = "sudo nixos-rebuild switch";
      ec = "emacsclient --alternate-editor=\"\" --create-frame";
      ecn = "ec -n";
      go = "go1.22.4";
      proj = "cd ~/Projects/";
    };
    oh-my-zsh = {
      enable = true;
      plugins = [ "git" "direnv" ];
      theme = "robbyrussell";
    };
    initExtraFirst = ''
      . "$HOME/.nix-profile/etc/profile.d/hm-session-vars.sh"
    '';
  };

  programs.password-store = {
    enable = true;
  };

  programs.git = {
    enable = true;
    userName = "Børge André Jensen";
    userEmail = "borge@jnzn.no";
    extraConfig = {
      github.userName = "imborge";
    };
  };
}
