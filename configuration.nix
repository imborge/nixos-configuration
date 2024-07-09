# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, lib, ... }:
{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Flakes
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "borgix"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Europe/Oslo";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "nb_NO.UTF-8";
    LC_IDENTIFICATION = "nb_NO.UTF-8";
    LC_MEASUREMENT = "nb_NO.UTF-8";
    LC_MONETARY = "nb_NO.UTF-8";
    LC_NAME = "nb_NO.UTF-8";
    LC_NUMERIC = "nb_NO.UTF-8";
    LC_PAPER = "nb_NO.UTF-8";
    LC_TELEPHONE = "nb_NO.UTF-8";
    LC_TIME = "nb_NO.UTF-8";
  };

  services.libinput.touchpad.naturalScrolling = true;
  services.displayManager = {
   sddm.enable = true;
   # exwm
   defaultSession = "none+exwm";
  };

  services.xserver = {
    xkb.layout = "us,no";

    # exwm
    displayManager.session = lib.singleton {
      name = "exwm";
      manage = "window";
      start = ''
        xhost +SI:localuser:$USER
        # emacs --daemon -f exwm-enable
        exec emacs --with-exwm
      '';
    };
     # let fakeSession = { manage = "window";
     #                     name = "fake";
     #                     start = "";
     #                   };
     # in [ fakeSession ];

    # keyboard switches:
    # win+space = toggle layout (us/no);;; ;
    # caps = escape, escape = caps
    # right win = right ctrl, right ctrl = right win
    #xkb.options = "grp:win_space_toggle,caps:swapescape,ctrl:swap_rwin_rctl";
    xkb.options = "compose:ralt";
    enable = true;

    desktopManager = {
      xterm.enable = false;
    };


    windowManager.i3 = {
      enable = true;
      extraPackages = with pkgs; [
        rofi
        i3status-rust
      ];
    };
  };

  # TODO: Put inside hardware-configuration.nix
  hardware.opengl = {
    enable = true;
    #driSupport = true;
    driSupport32Bit = true;
  };

  # TODO: Put inside hardware-configuration.nix
  hardware.pulseaudio.enable = true;
  hardware.pulseaudio.support32Bit = true;

  # Proprioritary nvidia drivers
  services.xserver.videoDrivers = [ "nvidia" ];

  # TODO: Put inside hardware-configuration.nix
  hardware.nvidia = {
    modesetting.enable = true;
    powerManagement.enable = false;
    #powerManagement.finegrained = false;
    powerManagement.finegrained = true;
    open = true;
    nvidiaSettings = true;
    package = config.boot.kernelPackages.nvidiaPackages.production;

    prime = {
      reverseSync.enable = true;
      nvidiaBusId = "PCI:1:0:0";
      amdgpuBusId = "PCI:4:0:0";
    };
  };

  boot.initrd.kernelModules = [ "nvidia" ];

  # Bluetooh
  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;
  services.blueman.enable = true;

  # Configure console keymap
  console.keyMap = "no";

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.borge = {
    isNormalUser = true;
    description = "Børge";
    shell = pkgs.zsh;
    extraGroups = [ "networkmanager" "wheel" "audio" ];
    packages = with pkgs; [];
  };

  # Allow unfree packages
  #nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    #  vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    wget
    gitFull
    firefox
    google-chrome
    chromium
    gnome.adwaita-icon-theme
    arandr
    feh
    spotify
    picom
    scrot
    brightnessctl
    playerctl
    blueman
    pasystray
    pavucontrol
    slack
    slock
    xss-lock

    # For exwm
    xorg.xhost

    # Draw UML diagrams using a simple and human readable text description
    plantuml

    libnotify
    # lightweight replacement for the notification daemons provided
    # by most desktop envs
    dunst

    # cli clipboard
    xclip
    
    unzip
    # gcc

    # terminal emulator
    kitty
    wezterm
    # gnumake
    # cmake
    # libtool
    expressvpn
    nodejs_20
    # alias for openjdk17
    jdk17
    
    mpv
    clojure
    clojure-lsp
    babashka
    # rustc
    # cargo
    # rust-analyzer
    # discord
    # zola
    #dotnet-sdk_7
    dotnet-sdk_8
    fsautocomplete
    gtk3

    direnv
    nix-direnv
    dbeaver-bin
    obs-studio
    cmake
    gcc
    killall

    qbittorrent

    # PCManFM file manager
    pcmanfm

    # To be offered a list of "Installed applications" when opening a file.
    lxmenu-data
    # To recognise different file types.
    shared-mime-info

    # Useful devtools for podman
    dive # look into docker image layers
    podman-tui
    docker-compose
    podman-compose

    imagemagick
    librsvg
    (python3.withPackages(ps: with ps;
      [ beautifulsoup4
        requests
        # other python packages
      ]))
  ];

  # Fonts
  fonts.packages = with pkgs; [
    nerdfonts
  ];

  # Network Manager applet
  programs.nm-applet.enable = true;

  programs.zsh.enable = true;

  # Containers

  # Docker
  virtualisation.docker = {
    enable = true;

    # rootless = {
    #   enable = true;
    #   setSocketVariable = true;
    # };
  };

  # Podman
  virtualisation.containers.enable = true;
  virtualisation = {
    podman = {
      enable = true;

      # Create a 'docker' alias for podman
      # dockerCompat = true;

      # Required for containers under podman-compose to be able to talk to eachother
      defaultNetwork.settings.dns_enabled = true;
    };
  };


  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };
  
  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Automatic garbage collection
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 30d";
  };

  nix.settings = {
    trusted-users = [ "root" "borge" ];
  };

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.05"; # Did you read the comment?

}
