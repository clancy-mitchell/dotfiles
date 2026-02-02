{
  description = "Home Manager configuration of Jane Doe";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
  
    nixgl = {
      url = "github:nix-community/nixGL";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  
    stylix = {
      url = "github:nix-community/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  
    nix-misc = {
      url = "github:armeenm/nix-misc";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs@{ nixpkgs, home-manager, nixgl, stylix, ... }:
    let
      system = "x86_64-linux";

      extraArgs = { inherit inputs; };

      modules = [{_module.args = extraArgs;}];
      
      pkgs = import nixpkgs {
        inherit system;
        overlays = [
          nixgl.overlay
        ];
      };
    in {
      homeConfigurations.cm =
        home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          modules = modules ++ [
            stylix.homeModules.stylix
            ./home.nix
          ];
        };
    };
}

