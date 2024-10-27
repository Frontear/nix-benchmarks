{
  ...
}:
{
  perSystem = { inputs', pkgs, ... }: {
    packages.default = pkgs.callPackage ./package.nix {
      nix = inputs'.nix.packages.default;
      nix-super = inputs'.nix-super.packages.default;
      lix = inputs'.lix.packages.default;
    };
  };
}
