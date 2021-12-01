{ config, lib, pkgs, ... }: {
  programs = {
    mu.enable = true;
    msmtp.enable = true;
    mbsync.enable = true;
  };
}
