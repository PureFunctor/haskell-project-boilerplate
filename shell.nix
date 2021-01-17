{ pkgs ? import <nixpkgs> {}
, compiler ? "ghc8103"
}:
let
  ghc = pkgs.haskell.packages.${compiler}.ghcWithPackages (pkgs: with pkgs; [base aeson]);
in
  pkgs.mkShell {
    buildInputs = [ ghc ];
  }
