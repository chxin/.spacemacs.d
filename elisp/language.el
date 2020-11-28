;; ===== js file mode
(add-to-list 'auto-mode-alist '("\\.js\\'" . react-mode))
;; hooks for js file format
(defun chxin/js-mode-hook ()
  (setq js2-basic-offset 2)
  (setq js-indent-level 2)
  (setq js2-include-node-externs t)
  (setq js2-strict-missing-semi-warning nil))
(add-hook 'js2-mode-hook 'chxin/js-mode-hook)
;; === Remove HTML tags
(defun chxin/strip-html-tags ()
  "Remove HTML tags from the current buffer,
   (this will affect the whole buffer regardless of the restrictions in effect)."
  (interactive "*")
  (save-excursion
    (save-restriction
      (widen)
      (goto-char (point-min))
      (while (re-search-forward "<[^<]*>" (point-max) t)
        (replace-match "\\1"))
      (goto-char (point-min))
      (replace-string "&quot;" "\"")
      (goto-char (point-min))
      (replace-string "&nbsp;" " ")
      (goto-char (point-min))
      (replace-string "&copy;" "(c)")
      (goto-char (point-min))
      (replace-string "&amp;" "&")
      (goto-char (point-min))
      (replace-string "&lt;" "<")
      (goto-char (point-min))
      (replace-string "&gt;" ">")
      (goto-char (point-min))
      (replace-string "&#39;" "'")
      (goto-char (point-min))
      (delete-trailing-whitespace)
      )))
;; ===== c and cpp file mode
;; === clang
;; Bind clang-format-region to C-M-tab in all modes:
(global-set-key [C-M-tab] 'clang-format-region)
;; Bind clang-format-buffer to tab on the c++-mode only:
(add-hook 'c++-mode-hook 'clang-format-bindings)
(defun clang-format-bindings ()
  (define-key c++-mode-map [tab] 'clang-format-buffer))
(setq c-c++-enable-clang-support t
      c-c++-default-mode-for-headers 'c++-mode)
;; === format code when saving according to the .clang-format file
;; https://eklitzke.org/smarter-emacs-clang-format
;; (defun clang-format-buffer-smart ()
;;   "reformat buffer if .clang-format exists in the projectile root."
;;   (when (f-exists? (expand-file-name ".clang-format" (projectile-project-root)))
;;     (clang-format-buffer)))
;; (defun clang-format-buffer-smart-on-save ()
;;   "add auto-save hook for clang-format-buffer-smart."
;;   (add-hook 'before-save-hook 'clang-format-buffer-smart nil t))
;; (spacemacs/add-to-hooks 'clang-format-buffer-smart-on-save
;;                         '(c-mode-hook c++-mode-hook))
;; === indent
(setq c-default-style "k&r")
(setq c-basic-offset 4)
;; ===== python
(setq python-indent-offset 4
      python-sort-imports-on-save t
      python-shell-interpreter "python3"
      pippel-python-command "python3"
      flycheck-python-pycompile-executable "python3"
      importmagic-python-interpreter "python3"
      flycheck-python-pylint-executable "pylint"
      flycheck-python-flake8-executable "flake8"
      python-test-runner '(pytest nose)
      python-enable-yapf-format-on-save t)
;; ===== verilog mode
(setq verilog-indent-level             4
      verilog-indent-level-module      4
      verilog-indent-level-declaration 4
      verilog-indent-level-behavioral  4
      verilog-indent-level-directive   4
      verilog-case-indent              4
      verilog-auto-newline             t
      verilog-auto-indent-on-newline   t
      verilog-tab-always-indent        t
      verilog-auto-endcomments         t
      verilog-minimum-comment-distance 40
      verilog-indent-begin-after-if    nil
      verilog-auto-lineup              'all
      verilog-highlight-p1800-keywords nil
      verilog-linter                   "iverilog"
      )

;; end
(provide 'language)
