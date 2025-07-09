{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
  };

  outputs = inputs: {
    nixosModules.default = ./configuration.nix;
  };
}
