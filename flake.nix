{
  description = "my project description";

  inputs = {

    flake-utils.url = "github:numtide/flake-utils";
    nixpkgs.url = "path:/nix/store/nr5nl3zwzl02x3rnikjbry3s5xy7bm1d-source";

  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem
      (system:
        let nixpkgsPkgs = if builtins.hasAttr "packages" nixpkgs then nixpkgs.packages.${system} else ( if builtins.hasAttr "legacyPackages" nixpkgs then nixpkgs.legacyPackages.${system} else nixpkgs);
        in
        {
          devShells.default = import ./shell.nix { pkgs=nixpkgsPkgs; };
        }
      );
}