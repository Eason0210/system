{ config, lib, pkgs, ... }: {
  user.name = "aqua0210";
  hm = { imports = [ ./home-manager/personal.nix ]; };
}
