{
  description = "dev stuff for glossarium";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    master.url = "github:nixos/nixpkgs/master";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = {
    self,
    nixpkgs,
    master,
    flake-utils,
  }:
    flake-utils.lib.eachDefaultSystem
    (
      system: let
        pkgs = nixpkgs.legacyPackages.${system};
        masterPkgs = master.legacyPackages.${system};
      in {
        devShell = pkgs.mkShell {
          buildInputs = [
            pkgs.typst
            pkgs.just
            pkgs.zathura
            pkgs.typstyle

            masterPkgs.tbump
          ];
        };
      }
    );
}
