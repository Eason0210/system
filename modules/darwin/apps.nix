{ config, lib, pkgs, ... }: {
  homebrew = {
    casks = [
      "appcleaner"
      "displaperture"
      "hammerspoon"
      "iina"
      "karabiner-elements"
      "maccy"
      "raycast"
      "skim"
      "stats"
      # "syncthing"
    ];
    masApps = { };
  };
}
