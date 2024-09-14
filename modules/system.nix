{ pkgs, lib, ... }:

let
  username = "borge";
in {
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.borge = {
    isNormalUser = true;
    description = "Børge";
    shell = pkgs.zsh;
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [];
  };

  nix.settings = {
    trusted-users = [
      username
      # "root"
    ];

    # Flakes
    experimental-features = [ "nix-command" "flakes" ];
  };

  # Automatic garbage collection
  nix.gc = {
    automatic = lib.mkDefault true;
    dates = lib.mkDefault "weekly";
    options = lib.mkDefault "--delete-older-than 7d";
  };

  # Allow unfree packages
  #nixpkgs.config.allowUnfree = true;

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
    LC_TIME = "en_US.UTF-8";
  };

  # Fonts
  fonts.packages = with pkgs; [
    nerdfonts
  ];

  environment.etc = {
    "brave/policies/managed/org-protocol.json" = {
      text = ''
        {
          "AutoLaunchProtocolsFromOrigins": [
            {
              "allowed_origins": [ "*" ],
              "protocol": "org-protocol"
            }
          ]
        }
      '';
    };
  };

  environment.systemPackages = with pkgs; [
    wget
    vim
    git

    # cli clipboard
    xclip

    firefox
    google-chrome
    chromium
    brave

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
  ];


  # Network Manager applet
  programs.nm-applet.enable = true;

  services = {
    # sound
    pipewire = {
      enable = true;
      alsa.enable = true;
      pulse.enable = true;
    };
  };

  programs.zsh.enable = true;
}
