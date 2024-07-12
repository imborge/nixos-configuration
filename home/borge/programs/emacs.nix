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
    enable = true;
    # Not sure about this
    startWithUserSession = true;

    # Whether to enable generation of Emacs client desktop file.
    client.enable = true;
  };

  home.packages = [pkgs.emacs-lsp-booster];

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
