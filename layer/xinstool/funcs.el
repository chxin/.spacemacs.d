(defun occur-dwim ()
  "call `occur' with a sane default"
  (interactive)
  (push (if (region-active-p)
            (buffer-substring-no-properties
             (region-beginning)
             (region-end))
          (let ((sym (thing-at-point 'symbol)))
            (when (stringp sym)
              (regexp-quote sym))))
        regexp-history)
  (call-interactively 'occur))

(defun create-frame-font-mac ()  ;; mac emacs
  (set-face-attribute
   'default nil :font "Source Code Pro 22")
  ;; Chinese Font
  (dolist (charset '( han symbol cjk-misc bopomofo))
    (set-fontset-font (frame-parameter nil 'font)
                      charset
                      (font-spec :family "STKaiti")))
  ;; (font-spec :family "STKaiti" :size 26)))
  (set-fontset-font (frame-parameter nil 'font)
                    'kana
                    (font-spec :family "Hiragino Sans" :size 22))
  (set-fontset-font (frame-parameter nil 'font)
                    'hangul
                    (font-spec :family "Apple SD Gothic Neo" :size 26))
  (setq face-font-rescale-alist '(("Source Code Pro" . 1) ("STKaiti" . 1.2)))
  )

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

;; Remove empty LOGBOOK drawers on clock out
(defun bh/remove-empty-drawer-on-clock-out ()
  (interactive)
  (save-excursion
    (beginning-of-line 0)
    ;; (org-remove-empty-drawer-at "LOGBOOK" (point))))
    (org-remove-empty-drawer-at (point))))

(defun org-add-overlays ()
  (interactive)
  "Add overlays for this mode."
  (add-to-invisibility-spec '(org-present))
  (save-excursion
    ;; hide org-mode options starting with #+
    (goto-char (point-min))
    (while (re-search-forward "^[[:space:]]*\\(#\\+\\)\\([^[:space:]]+\\).*" nil t)
      (let ((end (if (org-present-show-option (match-string 2)) 2 0)))
        (org-present-add-overlay (match-beginning 1) (match-end end))))
    ;; hide stars in headings
    (goto-char (point-min))
    (while (re-search-forward "^\\(*+\\)" nil t)
      (org-present-add-overlay (match-beginning 1) (match-end 1)))
    ;; hide emphasis/verbatim markers if not already hidden by org
    (if org-hide-emphasis-markers nil
      ;; TODO https://github.com/rlister/org-present/issues/12
      ;; It would be better to reuse org's own facility for this, if possible.
      ;; However it is not obvious how to do this.
      (progn
        ;; hide emphasis markers
        (goto-char (point-min))
        (while (re-search-forward org-emph-re nil t)
          (org-present-add-overlay (match-beginning 2) (1+ (match-beginning 2)))
          (org-present-add-overlay (1- (match-end 2)) (match-end 2)))
        ;; hide verbatim markers
        (goto-char (point-min))
        (while (re-search-forward org-verbatim-re nil t)
          (org-present-add-overlay (match-beginning 2) (1+ (match-beginning 2)))
          (org-present-add-overlay (1- (match-end 2)) (match-end 2)))))))

(defun org-present-rm-overlays ()
  "Remove overlays for this mode."
  (mapc 'delete-overlay org-present-overlays-list)
  (remove-from-invisibility-spec '(org-present)))
;; ===== verilog mode
(defvar verilog-inst-name nil)
(defvar verilog-inst-port nil)
(defun verilog-get-module-name ()
  "Get module name"
  (interactive)
  (save-excursion
    (when (verilog-re-search-backward "\\bmodule\\b" nil t)
      (skip-syntax-forward "w_")
      (when (verilog-re-search-forward "[a-zA-Z][a-zA-Z0-9_]*" nil t)
        (match-string-no-properties 0)))))
(defun verilog-insert-tb (mod_name)
  (interactive)
  (insert "`timescale 1ns/100ps\n")
  (insert (format  "module %s %s" (format "%s_tb" mod_name) " (/*AUTOARG*/);"))
  (insert "

    /*AUTOREGINPUT*/
    /*AUTOWIRE*/
    "
    (format "%s" mod_name) " uut(/*AUTOINST*/);

    initial begin : STIMULUS
        /*$sdf_annotate ( <\"sdf_file\">, <module_instance>?,
        <\"config_file\">?, <\"log_file\">?, <\"mtm_spec\">?,
        <\"scale_factors\">?, <\"scale_type\">? );*/
        $dumpfile(\"wave\");
        $dumpvars(0, " (format "%s" verilog-inst-name)  "_tb);
        <stimulus>
        #2000 $finish;
    end

endmodule // " (format "%s" mod_name) "_tb")
(insert "\n// Local Variables:
// verilog-library-flags:(\"-y ../ -y ./\")
// End:

"))
(defun verilog-create-tb()
  "Create a testbench file for current module..."
  (interactive)
  (setq verilog-inst-name (verilog-get-module-name))
  (setq verilog-inst-ports (verilog-read-decls))
  (switch-to-buffer (format "%s-testbench.v" verilog-inst-name))
  (verilog-mode)
  (goto-char (point-max))
  (verilog-insert-tb verilog-inst-name)
  (goto-line 1)
  ;; (search-forward "<REFERENCE>") (replace-match verilog-inst-name t t);

  ;; insert values table
  ;; (search-forward "<table>") (replace-match "" t t);
  ;; (insert "#+NAME: TABLE0\n")
  ;; (insert "|Ports\\\No.|0|\n")
  ;; (insert "|-")
  ;; (dolist (port (verilog-decls-get-inputs verilog-inst-ports))
  ;;   (insert (concat "|" (car port) "| \n")))

  ;; insert default values of input port
  (search-forward "<stimulus>") (replace-match "" t t);
  (verilog-indent-line-relative)
  (dolist (port (verilog-decls-get-inputs verilog-inst-ports))
    (insert (concat (car port) " = 'd0;\n"))
    (verilog-indent-line-relative)))
