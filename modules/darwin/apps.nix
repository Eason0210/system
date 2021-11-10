{ config, lib, pkgs, ... }: {
  homebrew = {
    casks = [
      "appcleaner"
      "displaperture"
      "hammerspoon"
      "iina"
      # "karabiner-elements"
      "kitty"
      "maccy"
      "raycast"
      "skim"
      "stats"
    ];
    masApps = { };
  };
}
