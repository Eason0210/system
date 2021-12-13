{ config, pkgs, ... }:

{
  programs.emacs = {
    enable = true;
    package = pkgs.emacsGit;
    extraPackages =
      (epkgs: (with epkgs.elpaPackages; [
      ]) ++ (with epkgs.melpaPackages; [
        telega
      ]) ++ (with epkgs; [ pkgs.mu ]));
  };
}
