;; ===== spacemacs
;; === spacemacs ui
;; = color
;; (setq ns-use-srgb-colorspace nil)
;; = font
(when (and (equal system-type 'darwin) (window-system))
  (add-hook 'after-init-hook (create-frame-font-mac)))
(add-hook 'after-make-frame-functions 'emacs-daemon-after-make-frame-hook)
;; = space modeline
;; (spacemacs/toggle-display-time-on)
;; (spacemacs/toggle-mode-line-minor-modes-off)
(setq spaceline-minor-modes-p nil)
;; = all the icons modeline
;; (setq-default spaceline-all-the-icons-eyebrowse-workspace-p nil)
;; (setq-default spaceline-all-the-icons-projectile-p nil)
;; (setq-default spaceline-all-the-icons-flycheck-status-p nil)
;; (setq-default spaceline-all-the-icons-hide-long-buffer-path t)
;; (setq-default spaceline-all-the-icons-git-status-p nil)
;; (setq-default spaceline-all-the-icons-git-ahead-p nil)
;; (setq-default spaceline-all-the-icons-vc-icon-p nil)
;; (setq-default spaceline-all-the-icons-vc-status-p nil)
;; (setq-default spaceline-all-the-icons-buffer-position-p t)
;; (setq-default spaceline-all-the-icons-position-p nil)
;; (setq-default spaceline-all-the-icons-modified-p nil)
;; (setq-default spaceline-all-the-icons-org-clock-current-task-p nil)
;; (setq-default spaceline-all-the-icons-icon-set-window-numbering 'solid)
;; = doom modeline
(setq doom-modeline-height 20)
;; === spacemacs profile
;; = save custom settings of .spacemacs into a file
(setq custom-file (expand-file-name "custom.el" dotspacemacs-directory))
(load custom-file 'no-error 'no-message)
;; === spacemacs tool
;; = `occur-dwim' is define on funcs.el
(global-set-key (kbd "M-s o") 'occur-dwim)
;; ===== org mode
;; === org mode ui
;; = headline bullets
(setq org-superstar-headline-bullets-list '(?■ ?❖ ?▲ ?▶))
;; === org agenda file
(if (boundp 'org-user-agenda-files)
    (setq org-agenda-files org-user-agenda-files)
  (setq org-agenda-files (quote ("~/Documents/Garage/orgible/inbox.org"
                                 ;; "~/Documents/Garage/orgible/refile/"
                                 ))))
;; === org appointments
;; = org appointments notifications
(setq spaceline-org-clock-p t)
(require 'appt)
(appt-activate t)                     ;; active appointments notifications
(setq appt-display-format 'window)    ;; message display
(setq appt-audible t)
(setq appt-display-mode-line t)       ;; display time on mode line
(setq appt-message-warning-time '10)  ;; display notifications 5 minutes before
(setq appt-display-duration '30)
(setq org-agenda-include-diary t)
(setq appt-time-msg-list nil)
(org-agenda-to-appt)                  ;; add event to appt, or press 'r' on agenda to add event
(defadvice org-agenda-redo (after org-agenda-redo-add-appts)
  "Pressing `r' on the agenda will also add appointments."
  (progn
    (setq appt-time-msg-list nil)
    (org-agenda-to-appt)))
(ad-activate 'org-agenda-redo)
;; === org todo keywords
;;; "@" to add comments
;;; "!" to add timestamp
(setq system-time-locale "C")
(setq org-todo-keywords
      (quote ((sequence "TODO(t)" "NEXT(n)" "|" "DONE(d)")
              (sequence "SCHEDULE(s)" "DEADLINE(D)" "WAITING(w@)" "HOLD(h@/!)" "|" "CANCELLED(c@)" "FINISHED(f!)" "PHONE" "MEETING"))))
(setq org-todo-keyword-faces
      (quote (("TODO" :foreground "red" :weight bold)
              ("NEXT" :foreground "blue" :weight bold)
              ("DONE" :foreground "forest green" :weight bold)
              ("WAITING" :foreground "orange" :weight bold)
              ("HOLD" :foreground "magenta" :weight bold)
              ("CANCELLED" :foreground "forest green" :weight bold)
              ("FINISHED" :foreground "forest green" :weight bold)
              ("MEETING" :foreground "forest green" :weight bold)
              ("PHONE" :foreground "forest green" :weight bold))))
(setq org-todo-state-tags-triggers
      (quote (("CANCELLED" ("CANCELLED" . t))
              ("WAITING" ("WAITING" . t))
              ("HOLD" ("WAITING") ("HOLD" . t))
              ("DONE" ("WAITING") ("HOLD"))
              ("TODO" ("WAITING") ("CANCELLED") ("HOLD"))
              ("NEXT" ("WAITING") ("CANCELLED") ("HOLD"))
              ("DONE" ("WAITING") ("CANCELLED") ("HOLD")))))
(setq org-use-fast-todo-selection t)
(setq org-treat-S-cursor-todo-selection-as-state-change nil)
;; === org capture
(setq org-directory "~/Documents/Garage/orgible")
(setq org-default-notes-file "~/Documents/Garage/orgible/inbox.org")
;; = Capture templates for: TODO tasks, Notes, appointments, phone calls, meetings, and org-protocol
(setq org-capture-templates
      (quote (("t" "Todo" entry (file "~/Documents/Garage/orgible/inbox.org")
                "* TODO %?\n%U\n%a\n" :clock-in t :clock-resume t)
              ("r" "Respond" entry (file "~/Documents/Garage/orgible/inbox.org")
                "* NEXT Respond to %:from on %:subject\nSCHEDULED: %t\n%U\n%a\n" :clock-in t :clock-resume t :immediate-finish t)
              ("n" "Note" entry (file "~/Documents/Garage/orgible/inbox.org")
                "* %? :NOTE:\n%U\n%F\n%a\n" :clock-in t :clock-resume t)
              ("i" "Interrupt" entry (file+datetree "~/Documents/Garage/orgible/inbox.org")
                "* %?\n%U\n" :clock-in t :clock-resume t)
              ("w" "Review" entry (file "~/Documents/Garage/orgible/inbox.org")
                "* TODO Review %c\t%F\n%U\n" :immediate-finish t)
              ("m" "Meeting" entry (file "~/Documents/Garage/orgible/inbox.org")
               "* MEETING with %? :MEETING:\n%U" :clock-in t :clock-resume t)
              ("p" "Phone Call" entry (file "~/Documents/Garage/orgible/inbox.org")
                "* PHONE %? :PHONE:\n%U" :clock-in t :clock-resume t)
              ("e" "Email" entry (file "~/Documents/Garage/orgible/inbox.org")
               "* TODO [#A] %?\nSCHEDULED: %(org-insert-time-stamp (org-read-date nil t \"+0d\"))\n%a\n" :immediate-finish t)
              ("h" "Habit" entry (file "~/Documents/Garage/orgible/inbox.org")
               "* NEXT %?\nSCHEDULED: %(format-time-string \"%<<%Y-%m-%d %a .+1d/3d>>\")\n:PROPERTIES:\n:STYLE: habit\n:REPEAT_TO_STATE: NEXT\n:END:\n%U\n%a\n"))))
(add-hook 'org-clock-out-hook 'bh/remove-empty-drawer-on-clock-out 'append)
(add-to-list 'org-capture-templates
             '("s" "Passwords" entry (file "~/Documents/Garage/orgible/oxrign/passwords.org.cpt")
               "* %U - %^{title} %^G\n\n  - NAME: %^{User Name}\n  - PASSWORDS: %(get-or-create-password)"
               :empty-lines 1 :kill-buffer t))
(add-to-list 'org-capture-templates
             '("l" "Billing" plain
               (file+function "~/Documents/Garage/orgible/inbox.org" find-month-tree)
               " | %U | %^{Type} | %^{Detailed} | %^{money} |" :kill-buffer t))
;; === Tags
; Tags with fast selection keys
(setq org-tag-alist (quote ((:startgroup)
                            ("@errand" . ?e)
                            ("@office" . ?o)
                            ("@home" . ?H)
                            ("@farm" . ?f)
                            (:endgroup)
                            ("WAITING" . ?w)
                            ("HOLD" . ?h)
                            ("PERSONAL" . ?P)
                            ("WORK" . ?W)
                            ("FARM" . ?F)
                            ("ORG" . ?O)
                            ("NORANG" . ?N)
                            ("crypt" . ?E)
                            ("NOTE" . ?n)
                            ("CANCELLED" . ?c)
                            ("FLAGGED" . ??))))
; Allow setting single tags without the menu
(setq org-fast-tag-selection-single-key (quote expert))
; For tag searches ignore tasks with scheduled and deadline dates
(setq org-agenda-tags-todo-honor-ignore-options t)
;; === org download
;; = org download screenshot
(setq org-download-screenshot-method "screencapture -i %s")
(setq-default org-download-image-dir "~/Downloads")
;; === org present
;; org present mode must hide the line number
;; options for org present: font size & subtree depth
(setq-default org-present-text-scale 3)
(setq-default org-present-level-depth 3)
;; === org reveal
(setq org-reveal-root "https://cdn.jsdelivr.net/npm/reveal.js@3.8.0")
;; === org ref and bibtex
(setq org-ref-default-bibliography '("~/Documents/Garage/orgible/references.bib")
      org-ref-pdf-directory "~/Documents/Papers/"
      org-ref-bibliography-notes "~/Documents/Garage/orgible/refile/paper-notes.org"
      bibtex-completion-bibliography "~/Documents/Garage/orgible/references.bib"
      bibtex-completion-pdf-field "file")
;; === org babel
(org-babel-do-load-languages 'org-babel-load-languages '((shell . t) (latex . t) (C . t) (python . t) (dot . t) (gnuplot . t) (plantuml . t)))
;; === eww
(setq browse-url-browser-function 'eww-browse-url)
;; === org latex class
(with-eval-after-load 'ox-latex
(add-to-list 'org-latex-classes
             '("beamer"
               "\\documentclass\[presentation\]\{beamer\}"
               ("\\section\{%s\}" . "\\section*\{%s\}")
               ("\\subsection\{%s\}" . "\\subsection*\{%s\}")
               ("\\subsubsection\{%s\}" . "\\subsubsection*\{%s\}")))
(add-to-list 'org-latex-classes
             '("ctexart"
               "\\documentclass\[UTF8\]\{ctexart\}"
               ("\\section\{%s\}" . "\\section*\{%s\}")
               ("\\subsection\{%s\}" . "\\subsection*\{%s\}")
               ("\\subsubsection\{%s\}" . "\\subsubsection*\{%s\}")))
(add-to-list 'org-latex-classes
             '("hustthesis"
               "\\documentclass\[format=draft,language=chinese,degree=master\]\{hustthesis\}"
               ("\\chapter\{%s\}" . "\\chapter*\{%s\}")
               ("\\section\{%s\}" . "\\section*\{%s\}")
               ("\\subsection\{%s\}" . "\\subsection*\{%s\}")
               ("\\subsubsection\{%s\}" . "\\subsubsection*\{%s\}")))
)
;; (add-hook 'org-mode-hook 'turn-on-org-cdlatex)
;; enable tikzpicture when preview latex tikz code
(add-to-list 'org-latex-packages-alist
             '("" "tikz" t))
;; ===== latex
(setq-default TeX-PDF-mode t)
(add-hook 'doc-view-mode-hook 'auto-revert-mode)
(setq-default fill-column 200)
(setq TeX-source-correlate-mode t)
(setq TeX-source-correlate-start-server t)
(setq TeX-source-correlate-method 'synctex)
(setq TeX-view-program-list
      '(("okular" "okular --unique %o#src:%n`pwd`/./%b")
        ;; skim -g option to open skim background
        ("macskim" "displayline -b %n %o %b")
        ("pdf tools" TeX-pdf-tools-sync-view)
        ("zathura"
         ("zathura %o"
          (mode-io-correlate
           " --synctex-forward %n:0:%b -x \"emacsclient +%{line} %{input}\"")))))
;; (if (spacemacs/system-is-mac) (setq TeX-view-program-selection '((output-pdf "pdf tools"))))
(if (spacemacs/system-is-mac) (setq TeX-view-program-selection '((output-pdf "macskim"))))
;; ===== layouts and workspace
(setq spacemacs-layouts-directory "/Users/xin/Documents/Garage/orgible/workspace/")
(setq purpose-layout-dirs "/Users/xin/Documents/Garage/orgible/workspace/")
