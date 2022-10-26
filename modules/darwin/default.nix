{ pkgs, ... }: {
  imports = [
    ../common.nix
    ./core.nix
    ./preferences.nix
  ];
}
