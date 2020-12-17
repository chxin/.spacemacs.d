;; ===== spell check
(add-hook 'prog-mode-hook #'flyspell-prog-mode)
;; ===== latex mode
(setq-default TeX-PDF-mode t)
(add-hook 'doc-view-mode-hook 'auto-revert-mode)
(setq-default fill-column 200)
(setq preview-gs-command "/usr/local/bin/gs")
;; === use skim on macos to utilize synctex.
;; confer https://mssun.me/blog/spacemacs-and-latex.html
;; (require 'tex-buf)
(setq TeX-source-correlate-mode t)
(setq TeX-source-correlate-start-server t)
(setq TeX-source-correlate-method 'synctex)
;; auctex recognizes some standard viewers, but the default view command
;; does not appear to sync.
(setq TeX-view-program-list
      '(("okular" "okular --unique %o#src:%n`pwd`/./%b")
        ;; skim -g option to open skim background
        ("macskim" "displayline -b %n %o %b")
        ("pdf tools" tex-pdf-tools-sync-view)
        ("zathura"
         ("zathura %o"
          (mode-io-correlate
           " --synctex-forward %n:0:%b -x \"emacsclient +%{line} %{input}\"")))))
;; select the viewers for each file type.
(setq TeX-view-program-selection
      '((output-dvi "open")
        ;; (output-pdf "macskim")
        ;; (output-pdf "pdf tools")
        (output-html "eww")))
(cond
 ((spacemacs/system-is-mac) (setq TeX-view-program-selection '((output-pdf "macskim"))))
 ;; ((spacemacs/system-is-mac) (setq TeX-view-program-selection '((output-pdf "pdf tools"))))
 ;; for linux, use okular or perhaps zathura.
 ((spacemacs/system-is-linux) (setq TeX-view-program-selection '((output-pdf "okular")))))
;; ===== org mode
(setq org-enable-github-support t
      org-enable-bootstrap-support t
      org-enable-org-journal-support t
      org-enable-sticky-header t
      org-enable-epub-support t
      org-enable-reveal-js-support nil)
(add-to-list 'auto-mode-alist '("\\.\\(org\\|org_archive\\|txt\\)$" . org-mode))
;; === org format
(setq-default indent-tabs-mode nil)
(setq default-tab-width 4)
(add-hook 'org-mode-hook (lambda () (setq truncate-lines nil)))
(setq latex-enable-auto-fill t
      latex-build-command "LatexMk"
      latex-enable-folding t)
;; === golden ratio mode
(golden-ratio-mode 1)
(setq golden-ratio-auto-scale t)
;; === modeline clock display
(setq spaceline-org-clock-p t)
;; === org bullets
(setq org-bullets-bullet-list '("■" "◆" "▲" "▶"))
;; === Inline images in HTML instead of producting links to the image
(setq org-html-inline-images t)
;; === org html code highlight
(setq org-html-htmlize-output-type 'css)
;; = org online image
;; add image link tag: [[imghttp(s)://xxxx.png]]
(require 'org-yt)
(defun chxin/org-image-link (protocol link _description)
  "Interpret LINK as base64-encoded image data."
  (cl-assert (string-match "\\`img" protocol) nil
             "Expected protocol type starting with img")
  (let ((buf (url-retrieve-synchronously (concat (substring protocol 3) ":" link))))
    (cl-assert buf nil
               "Download of image \"%s\" failed." link)
    (with-current-buffer buf
      (goto-char (point-min))
      (re-search-forward "\r?\n\r?\n")
      (buffer-substring-no-properties (point) (point-max)))))
(org-link-set-parameters
 "imghttp"
 :image-data-fun #'chxin/org-image-link)
(org-link-set-parameters
 "imghttps"
 :image-data-fun #'chxin/org-image-link)
;; set image size
(if (image-type-available-p 'imagemagick)
    (setq org-image-actual-width nil)
  (setq org-image-actual-width (/ (display-pixel-width) 8)))
;; #+ATTR_ORG: :width 50
;; ===== reveal
(setq org-reveal-root "http://cdn.jsdelivr.net/reveal.js/3.0.0/")
(use-package org-re-reveal :after org)
;; ===== org present
;; org present mode must hide the line number
;; (add-hook 'org-present-mode-hook (lambda () (linum-relative-on)))
;; dotspacemacs-line-numbers `relative
(eval-after-load "org-present"
  '(progn
     (add-hook 'org-present-mode-hook
               (lambda ()
                 (toggle-frame-fullscreen)
                 (linum-relative-off)
                 (org-present-big)
                 ;; (org-display-inline-images)
                 (org-present-hide-cursor)
                 (org-present-read-only)))
     (add-hook 'org-present-mode-quit-hook
               (lambda ()
                 (toggle-frame-fullscreen)
                 (linum-relative-on)
                 (org-present-small)
                 ;; (org-remove-inline-images)
                 (org-present-show-cursor)
                 (org-present-read-write)))))
;; options for org present: font size & subtree depth
(setq-default org-present-text-scale 3)
(setq-default org-present-level-depth 3)
;; ===== insert structure templates
;; use c-c c-, or <s
;; (require 'org-tempo)
;; ===== add execute language for latex when conduct c-c c-c for latex src block
(org-babel-do-load-languages 'org-babel-load-languages '((shell . t) (latex . t) (C . t) (python . t) (dot . t) (gnuplot . t) (plantuml . t)))
(setq exec-path (append  exec-path '("/library/tex/texbin")))
;; (setq org-latex-create-formula-image-program 'dvipng)
(setq org-latex-create-formula-image-program 'imagemagick)
;; ===== org preview
;; === org latex size
(setq org-format-latex-options (plist-put org-format-latex-options :scale 1.5))
;; ===== latex class
(require 'ox-latex)
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
;; (add-hook 'org-mode-hook 'turn-on-org-cdlatex)
;; enable tikzpicture when preview latex tikz code
(add-to-list 'org-latex-packages-alist
             '("" "tikz" t))
;; (eval-after-load "preview"
;;   '(add-to-list 'preview-default-preamble "\\previewenvironment{tikzpicture}" t))
;; ===== org bibtex
(require 'ox-bibtex)
(require 'ox-extra)
(require 'org-mac-link)
;; === org mode journal
(setq org-journal-dir "~/documents/papers/journal/")
;; (setq org-journal-file-format "%y-%m-%d"
;;       org-journal-date-prefix "#+title: "
;;       org-journal-date-format "%a, %b %d %y"
;;       org-journal-time-prefix "* "
;;       org-journal-time-format "")
;; ===== org brain
;; init
(setq org-brain-path "~/documents/garage/orgible/brain")
;; for evil users
(with-eval-after-load 'evil
  (evil-set-initial-state 'org-brain-visualize-mode 'emacs))
:config
(setq org-id-track-globally t)
(push '("b" "brain" plain (function org-brain-goto-end)
        "* %i%?" :empty-lines 1)
      org-capture-templates)
(setq org-brain-visualize-default-choices 'all)
(setq org-brain-title-max-length 12)
;; === org to mindmap
(require 'ox-freemind)
(setq org-export-backends '(freemind odt latex icalendar html ascii))
;; = org mindmap using graphviz
(require 'ox-org)
(require 'org-mind-map)
;; ===== mobile org
;; /davs:user:password@remote.host:/org/webdav/
;; (setq org-mobile-directory "/dav:chengxinhust\@163.com@dav.jianguoyun.com:/dav/orgible")
;; (setq org-mobile-directory "/Users/xin/Downloads/Garage/orgible")
;; the fold to sync on MAC
;; (setq org-directory "/Users/xin/Documents/Garage/orgible")
;; the fold to sync on mobile phone
;; (setq org-mobile-directory "~/dl/owncloud/mobileorg")
;; the file to store pull message and tags
;; (setq org-mobile-inbox-for-pull "/Users/xin/Documents/Garage/orgible/inbox.org")
;; === org blog site
;; (require 'init-site)
;; (setq org-export-in-background nil
;;       ;; Hide html built-in style and script.
;;       org-html-htmlize-output-type 'inline-css
;;       org-html-head-include-default-style nil
;;       org-html-head-include-scripts nil
;;       )
;; ===== org ref
;; bibtex
(setq org-ref-default-bibliography '("~/Documents/Garage/orgible/references.bib")
      org-ref-pdf-directory "~/Documents/Papers/"
      org-ref-bibliography-notes "~/Documents/Garage/orgible/refile/paper-notes.org"
      bibtex-completion-bibliography "~/Documents/Garage/orgible/references.bib"
      bibtex-completion-pdf-field "file"
      org-ref-get-pdf-filename-function 'chxin/org-ref-get-pdf-filename)
;; use =, p= to open pdf in bibtex entry file
(defun chxin/org-ref-get-pdf-filename (key)
  "Return the pdf filename indicated by zotero file field.
Argument KEY is the bibtex key."
  (let* ((results (org-ref-get-bibtex-key-and-file key))
         (bibfile (cdr results))
         entry)
    (with-temp-buffer
      (insert-file-contents bibfile)
      (bibtex-set-dialect (parsebib-find-bibtex-dialect) t)
      (bibtex-search-entry key nil 0)
      (setq entry (bibtex-parse-entry))
      (let ((e (org-ref-reftex-get-bib-field "file" entry)))
        (if (> (length e) 4)
            (let ((clean-field (replace-regexp-in-string "/+" "/" e)))
              (let ((first-file (car (split-string clean-field ";" t))))
                ;; (concat org-ref-pdf-directory first-file) ;; add prefix to pad path
                first-file
                ))
          (message "PDF filename not found.")
          )))))
;; Override this function.
(with-eval-after-load 'org-ref-core
  (defun org-ref-open-bibtex-pdf ()
    "Open pdf for a bibtex entry, if it exists. assumes point is in
the entry of interest in the bibfile.  but does not check that."
    (interactive)
    (save-excursion
      (bibtex-beginning-of-entry)
      (let* ((bibtex-expand-strings t)
             (entry (bibtex-parse-entry t))
             (key (reftex-get-bib-field "=key=" entry))
             (pdf (chxin/org-ref-get-pdf-filename key)))
        (message "%s" pdf)
        (if (file-exists-p pdf)
            (org-open-link-from-string (format "[[Skim://%s]]" pdf))
          )))))
;; set default app for org link
;; (setq org-file-apps
;;       '((auto-mode . emacs)
;;         ("\\.mm\\'" . default)
;;         ("\\.x?html?\\'" . default)
;;         ("\\.pdf\\'" . default)
;;         ;; ("\\.pdf\\'" . "displayline 1 %s")
;;         ))
;; === ebib
(setq ebib-preload-bib-files '("references.bib"))
(setq ebib-bib-search-dirs ' ("~/Documents/Garage/orgible"))
;; ===== org noter
(setq org-noter-separate-notes-from-heading t
      org-noter-default-notes-file-names '("org-notes.org")
      org-noter-notes-search-path '("~/Documents/Papers"))
;; ===== add skim annotation to org
(push (quote ("S" "Skim Annotation" entry
              (file+function org-ref-bibliography-notes my-org-move-point-to-capture-skim-annotation)
              "* %^{Logging for...} :skim_annotation:read:literature:
:PROPERTIES:
:Created: %U
:CITE: cite:%(my-as-get-skim-bibtex-key)
:SKIM_NOTE: %(my-org-mac-skim-get-page)
:SKIM_PAGE: %(my-as-get-skim-page)
:END:
%i
%?"
              :prepend f :empty-lines 1)) org-capture-templates)
;; (with-eval-after-load 'org-mac-skim-insert-page
(org-link-set-parameters "Skim" :follow #'my-org-mac-skim-open)
(defun my-org-mac-skim-open (uri)
  "Visit page and notes of pdf in Skim"
  (let* ((empty (when (string-match "\\(\\'\\)" uri) (match-string 1 uri)))
         (note (when (string-match ";;\\(.+\\)\\'" uri) (match-string 1 uri)))
         (page (when (string-match "::\\(.+\\);;" uri) (match-string 1 uri)))
         (document (substring uri 0 (match-beginning 0))))
    (message "page:%s, note:%s" page note)
    (do-applescript
     (concat
      "tell application \"Skim\"\n"
      "activate\n"
      "set theDoc to \"" document "\"\n"
      "open theDoc\n"
      (when page
        (concat
         "set thePage to " page "\n"
         "go document 1 to page thePage of document 1\n"))
      (when note
        (concat
         "set theNote to " note "\n"
         "go document 1 to item theNote of notes of page thePage of document 1\n"
         "set active note of document 1 to item theNote of notes of page thePage of document 1\n"))
      "end tell"))))
(defadvice org-capture-finalize
    (after org-capture-finalize-after activate)
  "Advise capture-finalize to close the frame"
  (if (equal "S" (org-capture-get :key))
      (do-applescript "tell application \"Skim\"\n    activate\nend tell")))
(defun my-as-get-skim-page-link ()
  (do-applescript
   (concat
    "tell application \"Skim\"\n"
    "set theDoc to front document\n"
    "set theTitle to (name of theDoc)\n"
    "set thePath to (path of theDoc)\n"
    "set thePage to (get index for current page of theDoc)\n"
    "set theSelection to selection of theDoc\n"
    "set theContent to (contents of (get text for theSelection))\n"
    "try\n"
    "    set theNote to active note of theDoc\n"
    "end try\n"
    "if theNote is not missing value then\n"
    "    set theContent to contents of (get text for theNote)\n"
    "    set theNotePage to get page of theNote\n"
    "    set thePage to (get index for theNotePage)\n"
    "    set theNoteIndex to (get index for theNote on theNotePage)\n"
    "else\n"
    "    if theContent is missing value then\n"
    "        set theContent to theTitle & \", p. \" & thePage\n"
    "        set theNoteIndex to 0\n"
    "    else\n"
    "        tell theDoc\n"
    "            set theNote to make new note with data theSelection with properties {type:highlight note, color:green}\n"
    "            set active note of theDoc to theNote\n"
    "            set text of theNote to (get text for theSelection)\n"
    "            set theNotePage to get page of theNote\n"
    "            set thePage to (get index for theNotePage)\n"
    "            set theNoteIndex to (get index for theNote on theNotePage)\n"
    "            set theContent to contents of (get text for theNote)\n"
    "        end tell\n"
    "    end if\n"
    "end if\n"
    "set theLink to \"Skim://\" & thePath & \"::\" & thePage & \";;\" & theNoteIndex & "
    "\"::split::\" & theContent\n"
    "end tell\n"
    "return theLink as string\n")))
(defun my-as-get-skim-bibtex-key ()
  (let* ((name (do-applescript
                (concat
                 "tell application \"Skim\"\n"
                 "set theDoc to front document\n"
                 "set theTitle to (name of theDoc)\n"
                 "end tell\n"
                 "return theTitle as string\n")))
         (key (when (string-match "\\(.+\\).pdf" name) (match-string 1 name))))
    key)
  ;; (message "%s" key))
  )
(defun my-as-get-skim-page ()
  (let* ((page (do-applescript
                (concat
                 "tell application \"Skim\"\n"
                 "set theDoc to front document\n"
                 "set thePage to (get index for current page of theDoc)\n"
                 "end tell\n"
                 "return thePage as string\n"))))
    page))
(defun my-as-clean-skim-page-link (link)
  (let* ((link (replace-regexp-in-string "\n" " " link))
         (link (replace-regexp-in-string "- " " " link)))
    link))
(defun my-org-mac-skim-get-page ()
  (interactive)
  (message "Applescript: Getting Skim page link...")
  ;; (my-as-clean-skim-page-link (my-as-get-skim-page-link)))
  (org-mac-paste-applescript-links (my-as-clean-skim-page-link (my-as-get-skim-page-link))))
(defun my-org-mac-skim-insert-page ()
  (interactive)
  (insert (my-org-mac-skim-get-page)))
(defun my-org-move-point-to-capture ()
  (cond ((org-at-heading-p) (org-beginning-of-line))
        (t (org-previous-visible-heading 1))))
(defun my-org-ref-find-entry-in-notes (key)
  "Find or create bib note for KEY"
  (let* ((entry (bibtex-completion-get-entry key)))
    (widen)
    (goto-char (point-min))
    (unless (derived-mode-p 'org-mode)
      (error
       "Target buffer \"%s\" for jww/find-journal-tree should be in Org mode"
       (current-buffer)))
    (let* ((headlines (org-element-map
                          (org-element-parse-buffer)
                          'headline 'identity))
           (keys (mapcar
                  (lambda (hl) (org-element-property :CUSTOM_ID hl))
                  headlines)))
      ;; put new entry in notes if we don't find it.
      (if (-contains? keys key)
          (progn
            (org-open-link-from-string (format "[[#%s]]" key))
            (lambda nil
              (cond ((org-at-heading-p
                      (org-beginning-of-line))
                     (t (org-previous-visible-heading 1))))
              )
            ;; no entry found, so add one
            (goto-char (point-max))
            (insert (org-ref-reftex-format-citation
                     entry (concat "\n" org-ref-note-title-format)))
            (mapc (lambda (x)
                    (save-restriction
                      (save-excursion
                        (funcall x))))
                  org-ref-create-notes-hook)
            (org-open-link-from-string (format "[[#%s]]" key))
            (lambda nil
              (cond ((org-at-heading-p)
                     (org-beginning-of-line))
                    (t (org-previous-visible-heading 1))))
            ))
      )))
(defun my-org-move-point-to-capture-skim-annotation ()
  (let* ((keystring (my-as-get-skim-bibtex-key)))
    (my-org-ref-find-entry-in-notes keystring)
    ))
;; (add-hook 'org-capture-prepare-finalize-hook #'(lambda () (my-as-set-skim-org-link (org-id-get-create))))
(defun my-as-set-skim-org-link (id)
  (do-applescript (concat
                   "tell application \"Skim\"\n"
                   "set runstatus to \"not set\"\n"
                   "set theDoc to front document\n"
                   "try\n"
                   "    set theNote to active note of theDoc\n"
                   "end try\n"
                   "if theNote is not missing value then\n"
                   "    set newText to text of theNote\n"
                   "    set startpoint to  (offset of \"org-id:{\" in newtext)\n"
                   "    set endpoint to  (offset of \"}:org-id\" in newtext)\n"
                   "    if (startpoint is equal to endpoint) and (endpoint is equal to 0) then\n"
                   "        set newText to text of theNote & \"\norg-id:{\" & "
                   (applescript-quote-string id)
                   " & \"}:org-id\"\n"
                   "        set text of theNote to newText\n"
                   "        return \"set success\"\n"
                   "    end if\n"
                   "end if\n"
                   "end tell\n"
                   "return \"unset\"\n"
                   )))
(defun applescript-quote-string (argument)
  "Quote a string for passing as a string to AppleScript."
  (if (or (not argument) (string-equal argument ""))
      "\"\""
    ;; Quote using double quotes, but escape any existing quotes or
    ;; backslashes in the argument with backslashes.
    (let ((result "")
          (start 0)
          end)
      (save-match-data
        (if (or (null (string-match "[^\"\\]" argument))
                (< (match-end 0) (length argument)))
            (while (string-match "[\"\\]" argument start)
              (setq end (match-beginning 0)
                    result (concat result (substring argument start end-of-defun-function)
                                   "\\" (substring argument end (1+ end)))
                    start (1+ end))))
        (concat "\"" result (substring argument start) "\"")))))

;; end
(provide 'emacs-authoring)
