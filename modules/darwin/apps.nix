{ config, lib, pkgs, ... }: {
  homebrew = {
    casks = [
      "appcleaner"
      "displaperture"
      "hammerspoon"
      "iterm2"
      "iina"
      "karabiner-elements"
      "maccy"
      "raycast"
      "skim"
      "stats"
    ];
    masApps = { };
  };
}
