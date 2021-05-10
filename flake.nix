{
  description = "nix system configurations";

  nixConfig = {
    substituters = [
      "https://kclejeune.cachix.org"
      "https://nix-community.cachix.org/"
      "https://cache.nixos.org"
    ];
    trusted-public-keys = [
      "kclejeune.cachix.org-1:fOCrECygdFZKbMxHClhiTS6oowOkJ/I/dh9q9b1I4ko="
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
    ];
  };

  inputs = {
    devshell.url = "github:numtide/devshell";
    flake-utils.url = "github:numtide/flake-utils";
    nixos-hardware.url = "github:nixos/nixos-hardware";
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    stable.url = "github:nixos/nixpkgs/nixos-20.09";
    treefmt.url = "github:numtide/treefmt";

    flake-compat = {
      url = "github:edolstra/flake-compat";
      flake = false;
    };
    darwin = {
      url = "github:kclejeune/nix-darwin/backup-etc";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    neovim-nightly-overlay = {
      url = "github:nix-community/neovim-nightly-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs@{ self, nixpkgs, stable, darwin, home-manager, nixos-hardware
    , devshell, treefmt, flake-utils, ... }:
    let
      supportedSystems = [ "x86_64-darwin" "x86_64-linux" ];
      overlays = [ inputs.neovim-nightly-overlay.overlay ];
      lib = nixpkgs.lib.extend
        (final: prev: (import ./lib final) // home-manager.lib);

      inherit (darwin.lib) darwinSystem;
      inherit (nixpkgs.lib) nixosSystem;
      inherit (home-manager.lib) homeManagerConfiguration;
      inherit (flake-utils.lib) eachDefaultSystem eachSystem;

      # generate a base darwin configuration with the
      # specified hostname, overlays, and any extraModules applied
      mkDarwinConfig = { system ? "x86_64-darwin", baseModules ? [
        home-manager.darwinModules.home-manager
        ./modules/darwin
      ], extraModules ? [ ] }:
        darwinSystem {
          # system = "x86_64-darwin";
          modules = baseModules ++ extraModules
            ++ [{ nixpkgs.overlays = overlays; }];
          specialArgs = { inherit inputs lib; };
        };

      # generate a base nixos configuration with the
      # specified overlays, hardware modules, and any extraModules applied
      mkNixosConfig = { system ? "x86_64-linux", hardwareModules
        , baseModules ? [
          home-manager.nixosModules.home-manager
          ./modules/nixos
        ], extraModules ? [ ] }:
        nixosSystem {
          inherit system;
          modules = baseModules ++ hardwareModules ++ extraModules
            ++ [{ nixpkgs.overlays = overlays; }];
          specialArgs = { inherit inputs lib; };
        };

      # generate a home-manager configuration usable on any unix system
      # with overlays and any extraModules applied
      mkHomeConfig = { username, system ? "x86_64-linux"
        , baseModules ? [ ./modules/home-manager ], extraModules ? [ ] }:
        homeManagerConfiguration rec {
          inherit system username;
          homeDirectory = "/home/${username}";
          extraSpecialArgs = { inherit inputs lib; };
          configuration = {
            imports = baseModules ++ extraModules
              ++ [{ nixpkgs.overlays = overlays; }];
          };
        };
    in {
      checks = builtins.listToAttrs (
        # darwin checks
        (builtins.map (system: {
          name = system;
          value = {
            darwin =
              self.darwinConfigurations.randall.config.system.build.toplevel;
          };
        }) lib.platforms.darwin) ++
        # linux checks
        (builtins.map (system: {
          name = system;
          value = {
            nixos = self.nixosConfigurations.phil.config.system.build.toplevel;
            server = self.homeConfigurations.server.activationPackage;
          };
        }) lib.platforms.linux)
      );

      darwinConfigurations = {
        randall = mkDarwinConfig {
          extraModules = [ ./profiles/personal.nix ./modules/darwin/apps.nix ];
        };
        work = mkDarwinConfig {
          extraModules =
            [ ./profiles/work.nix ./modules/darwin/apps-minimal.nix ];
        };
      };

      nixosConfigurations = {
        phil = mkNixosConfig {
          hardwareModules = [
            ./modules/hardware/phil.nix
            nixos-hardware.nixosModules.lenovo-thinkpad-t460s
          ];
          extraModules = [ ./profiles/personal.nix ];
        };
      };

      homeConfigurations = {
        server = mkHomeConfig {
          username = "kclejeune";
          extraModules = [ ./profiles/home-manager/personal.nix ];
        };
        workServer = mkHomeConfig {
          username = "lejeukc1";
          extraModules = [ ./profiles/home-manager/work.nix ];
        };
        multipass = mkHomeConfig {
          username = "ubuntu";
          extraModules = [ ./profiles/home-manager/personal.nix ];
        };
      };
    } //
    # add a devShell to this flake
    eachSystem supportedSystems (system:
      let
        pkgs = import nixpkgs {
          inherit system;
          overlays = [ devshell.overlay ];
        };
        pyEnv = (pkgs.python3.withPackages
          (ps: with ps; [ black pylint typer colorama shellingham ]));
        nixBin = pkgs.writeShellScriptBin "nix" ''
          ${pkgs.nixFlakes}/bin/nix --option experimental-features "nix-command flakes" "$@"
        '';
        sysdo = pkgs.writeShellScriptBin "sysdo" ''
          cd $DEVSHELL_ROOT && ${pyEnv}/bin/python3 bin/do.py $@
        '';
        fmt = treefmt.defaultPackage.${system};
      in {
        devShell = pkgs.devshell.mkShell {
          packages = with pkgs; [ nixBin pyEnv fmt ];
          commands = [
            {
              name = "sysdo";
              package = sysdo;
              category = "utilities";
              help = "perform actions on this repository";
            }
            {
              help = "Format the entire code tree";
              name = "fmt";
              command = "treefmt -q";
              category = "utilities";
            }
          ];
        };
      });
}
