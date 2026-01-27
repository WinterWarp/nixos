{
  description = "NixOS configuration for fourscore and lpc";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    nixpkgs-xr.url = "github:nix-community/nixpkgs-xr";
  };

  outputs =
    {
      self,
      nixpkgs,
      home-manager,
      nixos-hardware,
      nixpkgs-xr,
      ...
    }@inputs:
    {
      nixosConfigurations.fourscore = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { inherit inputs; };
        modules = [
          nixos-hardware.nixosModules.framework-12-13th-gen-intel
          ./hosts/fourscore
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.r4 = import ./home/fourscore.nix;
          }
        ];
      };

      nixosConfigurations.lpc = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { inherit inputs; };
        modules = [
          nixpkgs-xr.nixosModules.nixpkgs-xr
          ./hosts/lpc
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.r4 = import ./home/lpc.nix;
          }
        ];
      };
    };
}
