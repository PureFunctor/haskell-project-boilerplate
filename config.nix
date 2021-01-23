{  }:

let
  compiler = "ghc884";

  # Place non-GHC-bundled packages here.
  dependencies = [
    "aeson"
  ];

  config = {
    packageOverrides = pkgs: rec {
      haskell = pkgs.haskell // {
        packages = pkgs.haskell.packages // {
          "${compiler}" = pkgs.haskell.packages."${compiler}".override {
            overrides = 
              let
                collapseOverrides = 
                  pkgs.lib.fold pkgs.lib.composeExtensions (_: _: {});

                # Contains automatic overrides, this particular example
                # disables tests for all project dependencies.
                autoOverrides = self: super:
                  let
                    toPackage = name: {
                      inherit name;
                      value = pkgs.haskell.lib.dontCheck super."${name}";
                    };
                  in
                    builtins.listToAttrs (map toPackage dependencies);

                # Contains manual overrides, can be used to customize
                # transitive dependencies.
                manualOverrides = self: super: {
                  # It's imperative that the derivation for the project exists here as well.
                  haskell-project-boilerplate = super.callCabal2nix "haskell-project-boilerplate" ./. { };
                };
              in
                collapseOverrides [ autoOverrides manualOverrides ];
          };
        };
      };
    };
  };
in
  { compiler = compiler;
    nixpkgs = import <nixpkgs> { inherit config; };
  }
