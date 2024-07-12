{ pkgs, ... }:
{
  imports = [
    ./zsh.nix
  ];

  home.packages = with pkgs; [
    direnv
    nix-direnv
  ];
}
