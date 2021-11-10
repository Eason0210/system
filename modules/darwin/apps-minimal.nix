{ config, lib, pkgs, ... }: {
  homebrew = {
    casks = [
      "karabiner-elements"
      "hammerspoon"
      "raycast"
      "stats"
    ];
  };
}
