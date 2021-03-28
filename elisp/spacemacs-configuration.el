;; ===== fullscreen
(toggle-frame-maximized)
;; ===== font
;; abcdefghijkl
;; 数据测试宽度
(setq dotspacemacs-default-font '("Source Code Pro"
                                  :size 19.0
                                  :weight normal
                                  :width normal))
(defun create-frame-font-mac ()  ;; mac emacs
  (set-face-attribute
   'default nil :font "Source Code Pro 19")
  ;; Chinese Font
  (dolist (charset '( han symbol cjk-misc bopomofo))
    (set-fontset-font (frame-parameter nil 'font)
                      charset
                      (font-spec :family "STKaiti" :size 22)))
  (set-fontset-font (frame-parameter nil 'font)
                    'kana
                    (font-spec :family "Hiragino Sans" :size 22))
  (set-fontset-font (frame-parameter nil 'font)
                    'hangul
                    (font-spec :family "Apple SD Gothic Neo" :size 26))
  )
(when (and (equal system-type 'darwin) (window-system))
  (add-hook 'after-init-hook (create-frame-font-mac)))
(defun emacs-daemon-after-make-frame-hook(&optional f) ; emacsclient
  ;; (when (fboundp 'tool-bar-mode) (tool-bar-mode -1))
  ;; (when (fboundp 'scroll-bar-mode) (scroll-bar-mode -1))
  ;; (when (fboundp 'menu-bar-mode) (menu-bar-mode -1))
  (with-selected-frame f
    (when (window-system)
      (when (equal system-type 'darwin) (create-frame-font-mac))
      ;; (set-frame-position f 160 80)
      ;; (set-frame-size f 140 50)
      ;; (set-frame-parameter f 'alpha 85)
      ;; (raise-frame)
      )))
(add-hook 'after-make-frame-functions 'emacs-daemon-after-make-frame-hook)
;; ===== edit style
;(spacemacs/toggle-hybrid-mode-on)
;; ===== gls
