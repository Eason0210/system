{ config, lib, pkgs, ... }: {
  homebrew = {
    casks = [
      "appcleaner"
      "displaperture"
      "hammerspoon"
      "iterm2"
      "iina"
      "karabiner-elements"
      "kitty"
      "maccy"
      "raycast"
      "skim"
      "stats"
    ];
    masApps = { };
  };
}
