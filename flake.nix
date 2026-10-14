{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/148bab9c1c3c53136ecb44a6ea356a0ed5b39b06";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    home-manager.url = "github:nix-community/home-manager/bf9ce9fec78f95f374e8dd3b503863a3ec128ebe";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    helium-flake.url = "github:oxcl/nix-flake-helium-browser";
    helium-flake.inputs.nixpkgs.follows = "nixpkgs";

    antigravity-nix = {
      url = "github:jacopone/antigravity-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-flatpak.url = "github:gmodena/nix-flatpak/440818969ac2cbd77bfe025e884d0aa528991374";
  };

  outputs =
    {
      self,
      nixpkgs,
      nixpkgs-unstable,
      home-manager,
      helium-flake,
      nix-flatpak,
      antigravity-nix,
      ...
    }:
    {
      nixosConfigurations = {
        laptop = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          specialArgs = { inherit helium-flake; };
          modules = [
            ./configuration.nix
            ./laptop/hardware.nix
            nix-flatpak.nixosModules.nix-flatpak
            home-manager.nixosModules.home-manager
            {
              networking.hostName = "laptop";
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.extraSpecialArgs = {
                isLaptop = true;
                inherit nixpkgs-unstable antigravity-nix;
              };
              home-manager.users.sway = import ./home.nix;
            }
          ];
        };

        desktop = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          specialArgs = { inherit helium-flake; };
          modules = [
            ./configuration.nix
            ./desktop/hardware.nix
            nix-flatpak.nixosModules.nix-flatpak
            home-manager.nixosModules.home-manager
            {
              networking.hostName = "desktop";
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.extraSpecialArgs = {
                isLaptop = false;
                inherit nixpkgs-unstable antigravity-nix;
              };
              home-manager.users.sway = import ./home.nix;
            }
          ];
        };
      };
    };
}
