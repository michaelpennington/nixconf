{
  description = "Distributed Homelab Flake";

  inputs = {
    # NixOS Official Package Source
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    # Home Manager for user configuration
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    # Sops-Nix for secret management
    sops-nix.url = "github:Mic92/sops-nix";
    sops-nix.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
    sops-nix,
    ...
  } @ inputs: let
    system = "x86_64-linux";
    lib = nixpkgs.lib;
    # Function to reduce boilerplate for creating systems
    mkSystem = host:
      lib.nixosSystem {
        inherit system;
        specialArgs = {inherit inputs;}; # Pass inputs to modules
        modules = [
          ./hosts/${host}
          home-manager.nixosModules.home-manager
          sops-nix.nixosModules.sops
        ];
      };
  in {
    nixosConfigurations = {
      hermes = mkSystem "hermes";
      cronos = mkSystem "cronos";
    };
  };
}
