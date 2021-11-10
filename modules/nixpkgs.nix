{ inputs, config, lib, pkgs, nixpkgs, stable, ... }: {
  nixpkgs = {
    config = import ./config.nix;
    overlays = [
      (import (builtins.fetchTarball {
        url =
          "https://github.com/nix-community/emacs-overlay/archive/2b1f3e962b1e504cec6226499ad76ac69596ecbe.tar.gz";
        sha256 = "0n1ngwn725bqrdpp6a4a1q9gkf2582awdwyi4ny1lc3pv08pb3x2";
      }))
      (import ../overlays/00-nix-scripts.nix)
    ];
  };

  nix = {
    package = pkgs.nixFlakes;
    extraOptions = ''
      keep-outputs = true
      keep-derivations = true
      ${lib.optionalString (config.nix.package == pkgs.nixFlakes)
      "experimental-features = nix-command flakes"}
    '';
    trustedUsers = [ "${config.user.name}" "root" "@admin" "@wheel" ];
    gc = {
      automatic = true;
      options = "--delete-older-than 30d";
    };
    buildCores = 8;
    maxJobs = 8;
    readOnlyStore = true;
    nixPath = [
      "nixpkgs=/etc/${config.environment.etc.nixpkgs.target}"
      "home-manager=/etc/${config.environment.etc.home-manager.target}"
    ];

    binaryCaches =
      [ "https://kclejeune.cachix.org" "https://nix-community.cachix.org/" ];
    binaryCachePublicKeys = [
      "kclejeune.cachix.org-1:fOCrECygdFZKbMxHClhiTS6oowOkJ/I/dh9q9b1I4ko="
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
    ];

    registry = {
      nixpkgs = {
        from = {
          id = "nixpkgs";
          type = "indirect";
        };
        flake = nixpkgs;
      };

      stable = {
        from = {
          id = "stable";
          type = "indirect";
        };
        flake = stable;
      };
    };
  };
}
