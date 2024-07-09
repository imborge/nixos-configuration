{
  description = "My NixOS flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.05";
    home-manager = {
      url = "github:nix-community/home-manager/release-24.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    emacs-overlay = {
      url = "github:nix-community/emacs-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  outputs = { self, nixpkgs, home-manager, emacs-overlay, ... }@inputs:
  let
    inherit (self) outputs;
    system = "x86_64-linux";
    pkgs = import nixpkgs {
      inherit system;
      config.allowUnfree = true;
      overlays = [
        emacs-overlay.overlays.default
	(self: super: {
	  emacs = super.emacs.override {};
	})
      ];
    };
    in {
    nixosConfigurations.borgix = nixpkgs.lib.nixosSystem {
      inherit pkgs;
      system = "x86_64-linux";
      modules = [
        ./configuration.nix

        home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
	  home-manager.backupFileExtension = "hmbackup";
          home-manager.useUserPackages = true;
          home-manager.users.borge = import ./home/borge;
	  home-manager.extraSpecialArgs = { inherit inputs outputs; };
        }
      ];
    };  
  };
}
