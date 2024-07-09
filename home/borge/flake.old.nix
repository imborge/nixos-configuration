{
  description = "Home Manager configuration of borge";

  inputs = {
    # Specify the source of Home Manager and Nixpkgs.
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    devenv.url = "github:cachix/devenv/latest";
    home-manager = {
      url = "github:nix-community/home-manager";
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
      #pkgs = nixpkgs.legacyPackages.${system};
      pkgs = import nixpkgs {
        inherit system;
        overlays = [
          emacs-overlay.overlays.default
          (self: super: {
            emacs = super.emacs.override {
            };
          })
        ];
      };
    in {
      homeConfigurations."borge" = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;

        # Specify your home configuration modules here, for example,
        # the path to your home.nix.
        modules = [
          ./modules/i3.nix
          # ./modules/i3status-rust.nix
          # ./modules/polybar.nix
          # ./modules/emacs.nix ({ nixpkgs.overlays = [emacs-overlay.overlays.default]; })
          ./modules/emacs.nix
          ./home.nix ];

        # Optionally use extraSpecialArgs
        # to pass through arguments to home.nix
        extraSpecialArgs = { inherit inputs outputs; };
      };
    };
}
