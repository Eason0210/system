{ config, pkgs, ... }: {
  home.file = {
    # raycast = {
    #   source = ./raycast;
    #   target = ".local/bin/raycast";
    #   recursive = true;
    # };
    npmrc = {
      text = ''
        prefix = ${config.home.sessionVariables.NODE_PATH};
      '';
      target = ".npmrc";
    };
  };

  xdg.enable = true;
  xdg.configFile = {
    "nixpkgs/config.nix".source = ../../config.nix;
    karabiner = {
      source = ./karabiner;
      recursive = true;
    };
    kitty = {
      source = ./kitty;
      recursive = true;
    };
  };
}
