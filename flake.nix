{
  inputs = {
    flake-parts.url = "github:hercules-ci/flake-parts";
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

    nix.url = "github:NixOS/nix";
    nix-super.url = "github:privatevoid-net/nix-super?rev=fbe214b76e4caae52c33d06d20dbc09053925274";
    lix.url = "github:lix-project/lix";
  };

  outputs = inputs: inputs.flake-parts.lib.mkFlake { inherit inputs; } {
    imports = [
      ./nix
    ];

    systems = inputs.nixpkgs.lib.systems.flakeExposed;
  };
}
