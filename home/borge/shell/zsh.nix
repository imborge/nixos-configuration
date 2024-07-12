{
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
}
