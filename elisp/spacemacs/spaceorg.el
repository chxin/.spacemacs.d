;; ===== org mode
;; === org mode list
(add-to-list 'auto-mode-alist '("\\.\\(org\\|cpt\\|org_archive\\|txt\\)$" . org-mode))
;; === spacemacs dotspacemacs-configuration-layers
(setq org-enable-github-support t
      org-enable-bootstrap-support t
      org-enable-reveal-js-support t
      org-enable-org-journal-support t
      ;; org-enable-hugo-support t
      ;; org-enable-trello-support t
      org-projectile-file "~/Documents/Garage/orgible/refile/projects.org"
      org-enable-roam-support t
      org-enable-sticky-header t
      org-enable-epub-support t
      ;; org-enable-jira-support t
      ;; jiralib-url "https://yourcompany.atlassian.net:443"
      org-enable-verb-support t
      )
;; === spacemacs/user-config
(setq org-superstar-headline-bullets-list '(?■ ?❖ ?▲ ?▶)
      org-reveal-root "https://cdn.jsdelivr.net/npm/reveal.js@3.8.0"
      spaceline-org-clock-p t)
(if (boundp 'org-user-agenda-files)
    (setq org-agenda-files org-user-agenda-files)
  (setq org-agenda-files (quote ("~/Documents/Garage/orgible/inbox.org"
                                 ))))
;; bibtex
(setq org-ref-default-bibliography '("~/Documents/Garage/orgible/references.bib")
      org-ref-pdf-directory "~/Documents/Papers/"
      org-ref-bibliography-notes "~/Documents/Garage/orgible/refile/paper-notes.org"
      bibtex-completion-bibliography "~/Documents/Garage/orgible/references.bib"
      bibtex-completion-pdf-field "file"
      )
;; = org mode journal
(setq org-journal-dir "~/documents/papers/journal/"
      org-journal-file-format "%y-%m-%d"
      org-journal-date-prefix "#+title: "
      org-journal-date-format "%A, %B %d %Y"
      org-journal-time-prefix "* "
      org-journal-time-format "")
; = org projectile file to agenda
(with-eval-after-load 'org
   (require 'org-projectile)
   (mapcar '(lambda (file)
              (when (file-exists-p file)
                (push file org-agenda-files)))
           (org-projectile-todo-files)))
;; = org present
;; org present mode must hide the line number
(eval-after-load "org-present"
  '(progn
     (add-hook 'org-present-mode-hook
               (lambda ()
                 (toggle-frame-fullscreen)
                 (spacemacs/toggle-relative-line-numbers-off)
                 (org-present-big)
                 ;; (org-display-inline-images)
                 (org-present-hide-cursor)
                 (org-present-read-only)))
     (add-hook 'org-present-mode-quit-hook
               (lambda ()
                 (toggle-frame-fullscreen)
                 (spacemacs/toggle-relative-line-numbers-on)
                 (org-present-small)
                 ;; (org-remove-inline-images)
                 (org-present-show-cursor)
                 (org-present-read-write)))))
;; options for org present: font size & subtree depth
(setq-default org-present-text-scale 3)
(setq-default org-present-level-depth 3)
;; ===== latex
(add-hook 'doc-view-mode-hook 'auto-revert-mode)
(setq TeX-view-program-list
      '(("okular" "okular --unique %o#src:%n`pwd`/./%b")
        ;; skim -g option to open skim background
        ("macskim" "displayline -b %n %o %b")
        ("pdf tools" TeX-pdf-tools-sync-view)
        ("zathura"
         ("zathura %o"
          (mode-io-correlate
           " --synctex-forward %n:0:%b -x \"emacsclient +%{line} %{input}\"")))))
(if (spacemacs/system-is-mac) (setq TeX-view-program-selection '((output-pdf "pdf tools"))))
