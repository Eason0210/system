{ config, lib, pkgs, ... }:
let
  homeDir = config.home.homeDirectory;
  name = "Eason Huang";
  maildir = "${homeDir}/.maildir";
  email = "aqua0210@gmail.com";
  foxmail = "aqua0210@foxmail.com";
in
{
  accounts.email = {
    maildirBasePath = "${maildir}";
    certificatesFile = "${homeDir}/.maildir/certificates/root-certificates.pem";
    accounts = {
      Gmail = {
        address = "${email}";
        userName = "${email}";
        flavor = "plain";
        passwordCommand = "security find-generic-password -s mu4e-gmail -a aqua0210@gmail.com -w";
        mbsync = {
          enable = false;
          create = "both";
          expunge = "both";
          patterns = [ "*" ];
        };
        imap = {
          host = "imap.gmail.com";
          port = 993;
          tls.enable = true;
        };

        realName = "Eason Huang";
        msmtp.enable = true;
        smtp = {
          host = "smtp.gmail.com";
          port = 465;
        };
      };
      Foxmail = {
        address = "${foxmail}";
        userName = "${foxmail}";
        flavor = "plain";
        passwordCommand = "security find-generic-password -s mu4e-foxmail -a aqua0210@foxmail.com -w";
        primary = true;
        mbsync = {
          enable = true;
          create = "both";
          expunge = "both";
          patterns = [ "*" ];
        };
        imap = {
          host = "imap.qq.com";
          port = 993;
          tls.enable = true;
        };
        realName = "Eason Huang";
        msmtp.enable = true;
        smtp = {
          host = "smtp.qq.com";
          port = 465;
        };
      };
    };
  };

  programs = {
    mu.enable = true;
    msmtp.enable = true;
    mbsync.enable = true;
  };
}
