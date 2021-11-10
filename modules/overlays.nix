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
    (import (builtins.fetchTarball {
      url =
        "https://github.com/nix-community/emacs-overlay/archive/2b1f3e962b1e504cec6226499ad76ac69596ecbe.tar.gz";
      sha256 = "0n1ngwn725bqrdpp6a4a1q9gkf2582awdwyi4ny1lc3pv08pb3x2";
    }))
    # Install scripts in ../bin
    (import ./overlays/00-nix-scripts.nix)
  ];
}
