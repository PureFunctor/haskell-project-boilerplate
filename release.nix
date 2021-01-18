{  }:

let
  config = import ./config.nix {  };

in
  { haskell-project-boilerplate = config.nixpkgs.haskell.packages.${config.compiler}.haskell-project-boilerplate;
  }
