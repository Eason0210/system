{ inputs, nixpkgs, stable, ... }: {
  nixpkgs.overlays = [
    (final: prev: {
      # expose stable packages via pkgs.stable
      stable = import stable { system = prev.system; };
    })
    (final: prev: rec {
      kitty = prev.stable.kitty;
      # install comma from shopify repo
      comma = import inputs.comma rec {
        pkgs = import nixpkgs { system = prev.system; };
      };
    })
    # Emacs overlay
    (import (builtins.fetchGit {
      url = "https://github.com/nix-community/emacs-overlay.git";
      ref = "master";
      rev = "89c94427256d2f9960d3437e96ef93def024b215";
    }))
  ];
}
