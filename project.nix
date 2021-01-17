{ mkDerivation, aeson, base, stdenv }:
mkDerivation {
  pname = "haskell-project-boilerplate";
  version = "0.1.0.0";
  src = ./.;
  isLibrary = true;
  isExecutable = true;
  libraryHaskellDepends = [ aeson base ];
  executableHaskellDepends = [ base ];
  testHaskellDepends = [ base ];
  homepage = "https://github.com/PureFunctor/haskell-project-boilerplate";
  description = "Boilerplate repository for setting up Haskell projects using Cabal and Nix with support for HLS";
  license = stdenv.lib.licenses.bsd3;
}
