{
  description = "My NixOS setup";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";
    unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    lanzaboote = {
      url = "github:nix-community/lanzaboote/v0.4.3";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  outputs =
    {
      nixpkgs,
      lanzaboote,
      unstable,
      ...
    }:
	let
		backportsModule = import ./backports.nix unstable;
	in
    {
      nixosConfigurations.jan-pc = nixpkgs.lib.nixosSystem {
        modules = [
          ./jan-pc.nix
		  backportsModule
          lanzaboote.nixosModules.lanzaboote
        ];
      };
    };
}
