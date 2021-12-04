{ config, pkgs, ... }:

{
  programs.emacs = {
    enable = true;
    package = pkgs.emacsGit;
    overrides = self: super: {
      org = self.elpaPackages.org;
    };
    extraPackages =
      (epkgs: (with epkgs.elpaPackages; [
        csv-mode
        rainbow-mode
        undo-tree
        vertico
      ]) ++ (with epkgs.melpaPackages; [
        aggressive-indent
        ahk-mode
        anzu
        auto-package-update
        avy
        beacon
        bind-key
        browse-at-remote
        cmake-mode
        code-review
        color-theme-sanityinc-tomorrow
        company
        consult
        consult-flycheck
        crontab-mode
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
        sudo-edit
        super-save
        switch-window
        symbol-overlay
        textile-mode
        typescript-mode
        use-package
        vlf
        web-mode
        which-key
        whole-line-or-region
        writeroom-mode
        ws-butler
        yaml-mode
        yasnippet
        yasnippet-snippets
      ]) ++ (with epkgs; [ pkgs.mu ]));
  };
}
