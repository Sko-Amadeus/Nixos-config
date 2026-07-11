{
  description = "Sko NixOS Modular Flake";
  inputs = {
    # Temporarily tracking the unmerged rnsd/lxmd PR
    # (https://github.com/NixOS/nixpkgs/pull/530406) instead of plain
    # nixos-unstable, so `pkgs` and the rnsd/lxmd module files come from
    # the same tree (the module needs pkgs.formats.configobj, which this
    # PR also adds — mixing it with a separate nixpkgs input causes an
    # "attribute 'configobj' missing" eval error).
    # Revert to "github:NixOS/nixpkgs/nixos-unstable" once the PR merges.
    # Re-resolve if the PR is updated:
    #   nix flake prefetch "github:NixOS/nixpkgs/pull/530406/head"
    nixpkgs.url = "github:NixOS/nixpkgs/35f8cdcc379f7a737419e4f518b4f00232b7788d";
    spicetify-nix = {
      url = "github:Gerg-L/spicetify-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    twintail-launcher.url = "github:Tw1ZZLER/twintail-launcher-flake";
    nix-gaming.url = "github:fufexan/nix-gaming";
    nix-citizen = {
      url = "github:LovingMelody/nix-citizen";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.nix-gaming.follows = "nix-gaming";
    };
    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  outputs = { self, nixpkgs, spicetify-nix, nix-citizen, sops-nix, ... }@inputs:
  let
    system = "x86_64-linux";
  in {
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      inherit system;
      specialArgs = { inherit inputs; };
      modules = [
        ./configuration.nix
        spicetify-nix.nixosModules.default
        nix-citizen.nixosModules.default
        sops-nix.nixosModules.sops
      ];
    };
  };
}
