{ pkgs, ... }: {
  # imports = [
  #   # ./hardware-configuration.nix
  #   # ./networking.nix # generated at runtime by nixos-infect
  # ];
  boot.tmp.cleanOnBoot = true;
  zramSwap.enable = true;
  networking.hostName = "plaintext-pub-1";
  networking.domain = "";

  services.openssh.enable = true;

  users.users = {
    root.openssh.authorizedKeys.keys = [''ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIE3PuDCKlBrLwUkU9i7bbtlZthtW/FuGAMziR4ik+51s borge@jnzn.no'' ];

    borge = {
      isNormalUser = true;
      extraGroups = [ "wheel" ];

      openssh.authorizedKeys.keys = [''ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIE3PuDCKlBrLwUkU9i7bbtlZthtW/FuGAMziR4ik+51s borge@jnzn.no'' ];
    };
  };

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  environment.systemPackages = with pkgs; [
    git
  ];

  system.stateVersion = "23.11";
}
