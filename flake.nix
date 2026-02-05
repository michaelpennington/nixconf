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

    colmena.url = "github:zhaofengli/colmena";
  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
    sops-nix,
    colmena,
    ...
  } @ inputs: let
    system = "x86_64-linux";
    lib = nixpkgs.lib;
    baseModules = [
      home-manager.nixosModules.home-manager
      sops-nix.nixosModules.sops
    ];
    # Function to reduce boilerplate for creating systems
    mkSystem = host:
      lib.nixosSystem {
        inherit system;
        specialArgs = {inherit inputs;}; # Pass inputs to modules
        modules = [./hosts/${host}] ++ baseModules;
      };
  in {
    nixosConfigurations = {
      hermes = mkSystem "hermes";
      cronos = mkSystem "cronos";
    };
    colmenaHive = colmena.lib.makeHive {
      meta = {
        nixpkgs = import nixpkgs {
          inherit system;
        };
        specialArgs = {inherit inputs;};
      };
      cronos = {
        deployment = {
          targetHost = "192.168.1.10";
          tags = ["home" "private"];
          allowLocalDeployment = true; # Allow deploying to itself if you run colmena on cronos
        };

        imports = [./hosts/cronos] ++ baseModules;
      };
    };
  };
}
