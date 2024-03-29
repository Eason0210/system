{ self, inputs, config, pkgs, ... }:
let
  homeDir = config.home.homeDirectory;
in
{
  imports = [
    # ./nvim
    # ./emacs.nix
    ./cli
    ./dotfiles
    ./git.nix ];

  programs.home-manager = {
    enable = true;
    path = "${config.home.homeDirectory}/.nixpkgs/modules/home-manager";
  };

  home =
    let NODE_GLOBAL = "${config.home.homeDirectory}/.node-packages";
    in
    {
      # This value determines the Home Manager release that your
      # configuration is compatible with. This helps avoid breakage
      # when a new Home Manager release introduces backwards
      # incompatible changes.
      #
      # You can update Home Manager without changing this value. See
      # the Home Manager release notes for a list of state version
      # changes in each release.
      stateVersion = "22.05";
      sessionVariables = {
        GPG_TTY = "/dev/ttys000";
        EDITOR = "nvim";
        VISUAL = "nvim";
        CLICOLOR = 1;
        LSCOLORS = "ExFxBxDxCxegedabagacad";
        JAVA_HOME = "${pkgs.openjdk.home}";
        NODE_PATH = "${NODE_GLOBAL}/lib";
        # HOMEBREW_NO_AUTO_UPDATE = 1;
        ASPELL_CONF = "conf ${config.xdg.configHome}/aspell/config;";
      };
      sessionPath = [ "${NODE_GLOBAL}/bin" ];

      # define package definitions for current user environment
      packages = with pkgs; [
        # python with default packages
        (python3.withPackages
          (ps: with ps; [ numpy scipy ]))
        aspell
        aspellDicts.en
        cachix
        # comma
        coreutils-full
        curl
        fd
        gawk
        ghc
        git
        gnugrep
        gnused
        hugo
        htop
        httpie
        jq
        libwebp
        mpv
        neofetch
        nix
        nixfmt
        nixpkgs-fmt
        nodejs_latest
        nodePackages.eslint
        nodePackages.pyright
        openjdk
        openssh
        pandoc
        pre-commit
        pstree
        (ruby.withPackages (ps: with ps; [ rufo solargraph ]))
        ripgrep
        rsync
        shfmt
        sqlite
        tealdeer
        torsocks
        treefmt
        vagrant
        yarn
      ];
    };
}
