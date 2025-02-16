{
  description = "Nixos config flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, ... }@inputs: {
    nixosConfigurations.default = nixpkgs.lib.nixosSystem {
      specialArgs = {inherit inputs;};
      modules = [
        ./hosts/default/configuration.nix
	./modules/nixos/default.nix
	inputs.home-manager.nixosModules.home-manager
        {
          home-manager = {
	    useGlobalPkgs = true;
            useUserPackages = true;
            users.vishwa = import ./hosts/default/home.nix;
	    extraSpecialArgs = { inherit inputs; };
	  };
        }
      ];
    };
  };
}
