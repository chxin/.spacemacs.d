;; ===== elpa china
(setq configuration-layer--elpa-archives
      '(("melpa-cn" . "http://mirrors.tuna.tsinghua.edu.cn/elpa/melpa/")
        ("org-cn"   . "http://mirrors.tuna.tsinghua.edu.cn/elpa/org/")
        ("gnu-cn"   . "http://mirrors.tuna.tsinghua.edu.cn/elpa/gnu/")))
;; ===== elisp directory
(if (boundp 'org-mode-user-lisp-path)
    (add-to-list 'load-path org-mode-user-lisp-path)
  (add-to-list 'load-path (expand-file-name "~/.spacemacs.d/elisp")))
;; ===== editing style
(setq dotspacemacs-editing-style 'hybrid)
;; ===== appearance
;; === startup menu
;; maximized not work, put bakc .spacemacs or use (spacemacs/toggle-maximize-frame) SPC+T+M
(setq dotspacemacs-maximized-at-startup t)
(setq dotspacemacs-startup-buffer-show-version nil)
(setq dotspacemacs-startup-banner nil)
(setq dotspacemacs-frame-title-format "[%t] %b @%U%I")
(setq dotspacemacs-mode-line-theme '(spacemacs :separator zigzag :separator-scale 1.2))
;; (setq dotspacemacs-mode-line-theme 'doom)
;; (setq dotspacemacs-mode-line-theme '(all-the-icons))

(setq dotspacemacs-loading-progress-bar nil)
(setq dotspacemacs-inactive-transparency 50)
;; === font
(setq dotspacemacs-default-font
      '("Source Code Pro"
        :size 22.0
        :weight normal
        :width normal))
(setq dotspacemacs-themes
      '(spacemacs-dark
        dichromacy
        leuven
        monokai
        zenburn
        spacemacs-light))
(setq dotspacemacs-line-numbers
 '(:relative t
   :visual nil
   :disabled-for-modes dired-mode
                       doc-view-mode
                       markdown-mode
                       org-mode
                       pdf-view-mode
                       text-mode
   :size-limit-kb 1000))
;; ===== project agenda list
;; not work, must put back .spacemeacs
(setq dotspacemacs-startup-lists
      '((recents . 5)
        (agenda . 3)
        (projects . 3)))
;; ===== kill ring cycle
(setq dotspacemacs-enable-paste-transient-state t)
;; ===== smart parens
(setq dotspacemacs-smartparens-strict-mode nil)
(setq dotspacemacs-smart-closing-parenthesis nil)
;; ===== server
(setq dotspacemacs-enable-server t)
;; ===== format
(setq dotspacemacs-whitespace-cleanup `trailing)
(setq dotspacemacs-pretty-docs t)
(setq dotspacemacs-scratch-mode 'lisp-mode)
;; ===== dired sort: gls
(when (eq system-type 'darwin) (setq insert-directory-program "/usr/local/bin/gls"))
