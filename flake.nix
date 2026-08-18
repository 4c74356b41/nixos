{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/148bab9c1c3c53136ecb44a6ea356a0ed5b39b06";
    home-manager.url = "github:nix-community/home-manager/bf9ce9fec78f95f374e8dd3b503863a3ec128ebe";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    helium-flake.url = "github:oxcl/nix-flake-helium-browser";
    helium-flake.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = inputs@{ self, nixpkgs, home-manager, helium-flake, ... }: {
    nixosConfigurations = {
      laptop = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./configuration.nix
          ./hardware-laptop.nix
          home-manager.nixosModules.home-manager
          {
            networking.hostName = "laptop";
            nixpkgs.overlays = [ helium-flake.overlays.default ];
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.extraSpecialArgs = {
              isLaptop = true;
              inherit helium-flake;
            };
            home-manager.users.sway = import ./home.nix;
          }
        ];
      };

      desktop = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./configuration.nix
          ./hardware-desktop.nix
          home-manager.nixosModules.home-manager
          {
            networking.hostName = "desktop";
            nixpkgs.overlays = [ helium-flake.overlays.default ];
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.extraSpecialArgs = {
              isLaptop = false;
              inherit helium-flake;
            };
            home-manager.users.sway = import ./home.nix;
          }
        ];
      };
    };
  };
}