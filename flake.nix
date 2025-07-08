{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
    # arion = {
    #   url = "github:hercules-ci/arion";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };
  };

  outputs = inputs: {
    nixosModules.default = {
      imports = [
        ./configuration.nix
        # inputs.arion.nixosModules.arion
      ];
    };
  };
}
