{ config, pkgs, ... }:

{
  programs.emacs = {
    enable = true;
    package = pkgs.emacsGit;
    extraPackages = epkgs: with epkgs; [
      aggressive-indent
      anzu
      auto-package-update
      avy
      beacon
      bind-key
      browse-at-remote
      color-theme-sanityinc-tomorrow
      company
      consult
      consult-flycheck
      crontab-mode
      csv-mode
      dante
      default-text-scale
      diff-hl
      diminish
      dimmer
      diredfl
      eglot
      embark
      embark-consult
      fanyi
      flycheck
      flycheck-color-mode-line
      flycheck-package
      flycheck-relint
      flyspell-correct
      forge
      fullframe
      git-modes
      git-timemachine
      github-review
      go-translate
      haskell-mode
      highlight-escape-sequences
      highlight-quoted
      ibuffer-projectile
      ibuffer-vc
      immortal-scratch
      j-mode
      js2-mode
      json-mode
      json-reformat
      json-snatcher
      lua-mode
      macrostep
      magit
      magit-todos
      marginalia
      markdown-mode
      mode-line-bell
      modern-cpp-font-lock
      move-dup
      multiple-cursors
      nix-mode
      nixpkgs-fmt
      ns-auto-titlebar
      orderless
      org-download
      org-pomodoro
      org-roam
      origami
      osx-dictionary
      paredit
      projectile
      quickrun
      rainbow-delimiters
      rainbow-mode
      reformatter
      rime
      rustic
      scratch
      session
      shfmt
      shift-number
      sis
      skewer-less
      skewer-mode
      super-save
      switch-window
      symbol-overlay
      textile-mode
      typescript-mode
      undo-tree
      use-package
      vertico
      vlf
      web-mode
      which-key
      whole-line-or-region
      writeroom-mode
      ws-butler
      yaml-mode
      yasnippet
      yasnippet-snippets
    ];
  };
}