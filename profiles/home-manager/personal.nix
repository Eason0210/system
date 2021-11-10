{ config, lib, pkgs, ... }: {
  programs.git = {
    userEmail = "aqua0210@163.com";
    userName = "Eason Huang";
    # signing = {
    #   key = "aqua0210@163.com";
    #   signByDefault = true;
    # };
  };
}
