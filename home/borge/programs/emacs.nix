{pkgs, lib, ...}:
let
  bajEmacs = (pkgs.emacsWithPackagesFromUsePackage {
      package = pkgs.emacs-git;
      config = "/home/borge/.emacs.d/init.el";
      extraEmacsPackages = epkgs: [
        epkgs.pdf-tools
        epkgs.mu4e
        epkgs.treesit-grammars.with-all-grammars
        epkgs.exwm
        epkgs.vterm
        pkgs.emacs-all-the-icons-fonts
        pkgs.emacs-lsp-booster
      ];
    });
in {
  services.emacs = {
    # enable = true;
    # Not sure about this
    # startWithUserSession = true;

    # Whether to enable generation of Emacs client desktop file.
    client.enable = true;
  };

  home.packages = [
    pkgs.emacs-lsp-booster
    pkgs.sqlfluff
    # proxy for matrix
    pkgs.python3Full
    pkgs.gtk3
    pkgs.pkg-config
    pkgs.glibc
    pkgs.glib
    pkgs.gobject-introspection
    pkgs.python3Packages.pygobject3
    pkgs.python3Packages.dbus-python
    pkgs.cairo
    pkgs.python3Packages.pycairo
    pkgs.olm
    pkgs.python3Packages.python-olm
  ];

  services.pantalaimon.enable = true;
  services.pantalaimon.package = pkgs.pantalaimon;
  services.pantalaimon.settings = {
    Default = {
      LogLevel = "Debug";
      SSL = true;
    };
    local-matrix = {
      Homeserver = "https://matrix.org";
      ListenAddress = "127.0.0.1";
      ListenPort = 8008;
    };
  };

  programs.emacs = {
    enable = true;
    package = bajEmacs;
    extraPackages = epkgs: [
      pkgs.ffmpeg
      epkgs.mu4e
      epkgs.lspce
      pkgs.keychain
      pkgs.emacs-lsp-booster
    ];
  };
}
