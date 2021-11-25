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
      rev = "640ff172f47d3c6ae959494b888f19a75d41ffbd";
    }))
  ];
}
