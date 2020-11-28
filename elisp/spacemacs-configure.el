;; dotspacemacs/layers ()
  ;; (setq-default
  ;;  dotspacemacs-distribution 'spacemacs
  ;;  dotspacemacs-enable-lazy-installation 't
  ;;  dotspacemacs-ask-for-lazy-installation t
  ;;  dotspacemacs-configuration-layer-path '()
  ;;  dotspacemacs-configuration-layers
  ;;  '(
  ;;    ruby
  ;;    yaml
  ;;    javascript
  ;;    windows-scripts
  ;;    octave
  ;;    html
  ;;    speed-reading
  ;;    (python :variables
  ;;            python-test-runner '(pytest nose)
  ;;            python-enable-yapf-format-on-save t)
  ;;    markdown
  ;;    myleetcode
  ;;    (latex :variables
  ;;           latex-build-command "LatexMk"
  ;;           latex-enable-auto-fill t
  ;;           latex-enable-folding t)
  ;;    pdf-tools
  ;;    bibtex
  ;;    (c-c++ :variables
  ;;           c-c++-enable-clang-support t
  ;;           c-c++-default-mode-for-headers 'c++-mode)
  ;;    helm
  ;;    (auto-completion :variables
  ;;                     auto-completion-enable-sort-by-usage t
  ;;                     auto-completion-enable-snippets-in-popup t)
  ;;    better-defaults
  ;;    emacs-lisp
  ;;    git
  ;;    (org :variables
  ;;         org-enable-github-support t
  ;;         org-enable-bootstrap-support t
  ;;         org-enable-org-journal-support t
  ;;         org-enable-sticky-header t
  ;;         org-enable-epub-support t
  ;;         org-enable-reveal-js-support nil)
  ;;    (shell :variables
  ;;           shell-default-shell 'term
  ;;           shell-default-height 30
  ;;           shell-default-position 'bottom)
  ;;    spell-checking
  ;;    syntax-checking
  ;;    version-control
  ;;    (mu4e :variables
  ;;          mu4e-account-alist t
  ;;          mu4e-enable-notifications t
  ;;          mu4e-installation-path "/usr/local/Cellar/mu/1.2.0_1/share/emacs/site-lisp/mu/mu4e")
  ;;    (elfeed :variables
  ;;            ;; elfeed-enable-web-interface t
  ;;            rmh-elfeed-org-files (list
  ;;                                  "~/Documents/Garage/orgible/elfeed.org"
  ;;                                  ))
  ;;    asciidoc
  ;;    auto-completion
	;;  )
  ;;  dotspacemacs-additional-packages
  ;;  '(
  ;;    org-brain
  ;;    org-re-reveal
  ;;    )
  ;;  dotspacemacs-frozen-packages '()
  ;;  dotspacemacs-excluded-packages '()
  ;;  dotspacemacs-install-packages 'used-only)

;; dotspacemacs/init
;; (defun dotspacemacs/init ()
  (setq-default
   dotspacemacs-elpa-https t
   dotspacemacs-elpa-timeout 5
   dotspacemacs-check-for-update t
   dotspacemacs-elpa-subdirectory nil
   dotspacemacs-editing-style 'hybrid
   dotspacemacs-verbose-loading nil
   dotspacemacs-startup-banner 'random
   dotspacemacs-startup-lists '((recents . 5)
                                (projects . 3)
                                (agenda . 3))
   dotspacemacs-startup-buffer-responsive t
   dotspacemacs-scratch-mode 'text-mode
   dotspacemacs-themes '(
                         dichromacy
                         leuven
                         )
   dotspacemacs-colorize-cursor-according-to-state t
   dotspacemacs-default-font '("Menlo" ;;Menlo ;;"Noto Sans Mono"
                               :size 19
                               :weight normal
                               :width normal
                               :powerline-scale 1.1)
   dotspacemacs-leader-key "SPC"
   dotspacemacs-emacs-command-key "SPC"
   dotspacemacs-ex-command-key ":"
   dotspacemacs-emacs-leader-key "M-m"
   dotspacemacs-major-mode-leader-key ","
   dotspacemacs-major-mode-emacs-leader-key "C-M-m"
   dotspacemacs-distinguish-gui-tab nil
   dotspacemacs-remap-Y-to-y$ t
   dotspacemacs-retain-visual-state-on-shift t
   dotspacemacs-visual-line-move-text nil
   dotspacemacs-ex-substitute-global nil
   dotspacemacs-default-layout-name "Default"
   dotspacemacs-display-default-layout nil
   dotspacemacs-auto-resume-layouts nil
   dotspacemacs-large-file-size 1
   dotspacemacs-auto-save-file-location 'original
   dotspacemacs-max-rollback-slots 5
   dotspacemacs-helm-resize nil
   dotspacemacs-helm-no-header nil
   dotspacemacs-helm-position 'bottom
   dotspacemacs-helm-use-fuzzy 'always
   dotspacemacs-enable-paste-transient-state nil
   dotspacemacs-which-key-delay 0.4
   dotspacemacs-which-key-position 'bottom
   dotspacemacs-loading-progress-bar nil
   dotspacemacs-fullscreen-at-startup nil
   dotspacemacs-fullscreen-use-non-native nil
   dotspacemacs-maximized-at-startup t
   dotspacemacs-active-transparency 90
   dotspacemacs-inactive-transparency 90
   dotspacemacs-show-transient-state-title t
   dotspacemacs-show-transient-state-color-guide t
   dotspacemacs-mode-line-unicode-symbols t
   dotspacemacs-smooth-scrolling t
   dotspacemacs-line-numbers '(:relative t
                                         :disabled-for-modes
                                         dired-mode
                                         demo-it-mode
                                         doc-view-mode
                                         org-present-mode
                                         markdown-mode
                                         org-mode
                                         pdf-view-mode
                                         text-mode
                                         :size-limit-kb 1000)
   dotspacemacs-folding-method 'evil
   dotspacemacs-smartparens-strict-mode nil
   dotspacemacs-smart-closing-parenthesis nil
   dotspacemacs-highlight-delimiters 'all
   dotspacemacs-persistent-server nil
   dotspacemacs-search-tools '("ag" "pt" "ack" "grep")
   dotspacemacs-default-package-repository nil
   dotspacemacs-whitespace-cleanup 'changed
   )
;; elpa china
  (setq configuration-layer--elpa-archives
        '(("melpa-cn" . "http://mirrors.tuna.tsinghua.edu.cn/elpa/melpa/")
          ("org-cn"   . "http://mirrors.tuna.tsinghua.edu.cn/elpa/org/")
          ("gnu-cn"   . "http://mirrors.tuna.tsinghua.edu.cn/elpa/gnu/")))

;; end
(provide 'spacemacs-configure)
