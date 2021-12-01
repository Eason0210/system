{ config, lib, pkgs, ... }:
let
  homeDir = config.home.homeDirectory;
  name = "Eason Huang";
  maildir = "${homeDir}/.maildir";
  email = "aqua0210@gmail.com";
  netease = "aqua0210@163.com";
in
{
  accounts.email = {
    maildirBasePath = "${maildir}";
    certificatesFile = "${homeDir}/.maildir/certificates/root-certificates.pem";
    accounts = {
      Gmail = {
        address = "${email}";
        userName = "${email}";
        flavor = "gmail.com";
        passwordCommand = "security find-generic-password -s mu4e-gmail -a aqua0210 -w";
        primary = true;
        mbsync = {
          enable = true;
          create = "both";
          expunge = "both";
          patterns = [ "*" "[Gmail]*" ]; # "[Gmail]/Sent Mail" ];
        };
        realName = "Eason Huang";
        msmtp.enable = true;
      };
      Netease = {
        address = "${netease}";
        userName = "${netease}";
        flavor = "plain";
        passwordCommand = "security find-generic-password -s mu4e-163 -a aqua0210@163.com -w";
        mbsync = {
          enable = true;
          create = "both";
          expunge = "both";
          patterns = [ "*" ];
        };
        imap = {
          host = "imap.163.com";
          port = 993;
          tls.enable = true;
        };
        realName = "Eason Huang";
        msmtp.enable = true;
        smtp = {
          host = "smtp.163.com";
          tls.useStartTls = true;
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
