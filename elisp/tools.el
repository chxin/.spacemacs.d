;; ===== autocompletion mode
(setq auto-completion-enable-sort-by-usage t
      auto-completion-enable-snippets-in-popup t)
(global-company-mode t)
(setq company-global-modes (list 'c-mode 'c++-mode 'BSDmakefile-mode 'makefile-mode 'Verilog-mode))
;; ===== leetcode mode
(setq-default leetcode-prefer-language "cpp")
(setq-default leetcode-prefer-sql "mysql")
;; ===== translate
(setq-default google-translate-default-source-language "en")
(setq-default google-translate-default-target-language "zh-cn")
(setq-default google-translate-translation-directions-alist '(("en" . "zh-cn")("zh-cn" . "en")))
(setq-default google-translate--tkk-url "http://translate.google.cn")
(setq-default google-translate-base-url "http://translate.google.cn/translate_a/single")
(setq-default google-translate-listen-url "http://translate.google.cn/translate_tts")
(setq-default google-translate-output-destination 'echo-area)
(setq-default google-translate-pop-up-buffer-set-focus t)
(setq-default go-translate-base-url "http://translate.google.cn")
(setq-default go-translate-local-language "zh-CN")
(setq-default go-translate-target-language "en")
;; ===== elfeed mode
(require 'elfeed-org)
(elfeed-org)
;; (setq elfeed-enable-web-interface t)
(setq rmh-elfeed-org-files (list
                            "~/Documents/Garage/orgible/elfeed.org"
                            ))
;; ===== dired mode
(setq ls-lisp-use-insert-directory-program t)      ;; use external ls
(when (eq system-type 'darwin) (setq insert-directory-program "/usr/local/bin/gls"))
;; ===== email mu4e mode
(setq mu4e-account-alist t
      mu4e-enable-notifications t)
(if (equal system-type 'gnu/linux)
    (setq mu4e-installation-path "/usr/share/emacs/site-lisp/mu4e")
  (setq mu4e-installation-path "/usr/local/Cellar/mu/1.2.0_1/share/emacs/site-lisp/mu/mu4e"))
(setq mu4e-attachment-dir "~/Downloads")
(require 'org-mu4e)
(require 'org-mime)
(setq org-mu4e-convert-to-html t)
;; === html mail
(defun my-htmlize-and-send ()
  "When in an org-mu4e-compose-org-mode message, htmlize and send it."
  (interactive)
  (when (member 'org~mu4e-mime-switch-headers-or-body post-command-hook)
   (org-mime-htmlize)
   ;; (org-mu4e-compose-org-mode)
   ;; (mu4e-compose-mode)
   (message-send-and-exit)))
;; multiaccount
;; (require 'mu4e-context)
;; (setq stmpmail-stream-type 'starttls)
;; (setq mu4e-contexts
;;       `( ,(make-mu4e-context
;;            :name "163"
;;            :enter-func (lambda () (mu4e-message "Entering 163 context"))
;;            :leave-func (lambda () (mu4e-message "Leaving 163 context"))
;;            ;; we match based on the contact-fields of the message
;;            :match-func (lambda (msg)
;;                          (when msg
;;                            (mu4e-message-contact-field-matches msg :to "chengxinhust163.com")))
;;            :vars '( ( user-mail-address	    . "chengxinhust@163.com"  )
;;                     ( user-full-name	    . "Xin Cheng" )
;;                     ( smtpmail-smtp-server  . "smtp.163.com")
;;                     ( smtpmail-smtp-service  . "465")
;;                     ( mu4e-compose-signature .
;;                                              (concat
;;                                               "Xin Cheng\n"
;;                                               "HUST, China\n"))))
;;          ,(make-mu4e-context
;;            :name "hust"
;;            :enter-func (lambda () (mu4e-message "Switch to the hust context"))
;;            ;; no leave-func
;;            ;; we match based on the maildir of the message
;;            ;; this matches maildir /Arkham and its sub-directories
;;            :match-func (lambda (msg)
;;                          (when msg
;;                            (string-match-p "^/CHxin" (mu4e-message-field msg :maildir))))
;;            :vars '( ( user-mail-address	     . "chengxin@hust.edu.cn" )
;;                     ( user-full-name	     . "Xin Cheng" )
;;                     ( smtpmail-smtp-server  . "mail.hust.edu.cn")
;;                     ( smtpmail-smtp-service  . "25")
;;                     ( mu4e-compose-signature  .
;;                                               (concat
;;                                                "Xin Cheng\n"
;;                                                "HUST, China\n"))))))
;; mu4e email account list
(require 'smtpmail)
(setq mu4e-account-alist
      '(
        ;; ("outlook"
        ;;  ;; under each account, set the account-specific variables you want.
        ;;  (mu4e-sent-messages-behavior sent)
        ;;  (mu4e-sent-folder "/outlook/.sent-mail")
        ;;  (mu4e-drafts-folder "/outlook/.drafts")
        ;;  (user-mail-address "chengxinhust@outlook.com")
        ;;  (user-full-name "chxin"))
        ("college"
         (mu4e-sent-messages-behavior sent)
         (mu4e-sent-folder "/college/.sent-items")
         (mu4e-drafts-folder "/college/.drafts")
         (user-mail-address "chengxin@hust.edu.cn")
         (user-full-name "xin cheng")
         (smtpmail-smtp-server "mail.hust.edu.cn")
         (smtpmail-default-smtp-server "mail.hust.edu.cn")
         (message-send-mail-function message-smtpmail-send-it)
         (smtpmail-smtp-service 25)
         )
        ("163"
         (mu4e-sent-messages-behavior sent)
         (mu4e-sent-folder "/163/.sent-items")
         (mu4e-drafts-folder "/163/.drafts")
         (user-mail-address "chengxinhust@163.com")
         (user-full-name "xin cheng")
         (smtpmail-smtp-server "smtp.163.com")
         (smtpmail-default-smtp-server "smtp.163.com")
         (message-send-mail-function smtpmail-send-it)
         (smtpmail-smtp-service 25)
         )
        ))
(mu4e/mail-account-reset)
;; set up some common mu4e variables
(setq mu4e-maildir "~/.mail"
      mu4e-trash-folder "/.mail/.trash"
      mu4e-refile-folder "/.mail/.archive"
      mu4e-get-mail-command "offlineimap"
      mu4e-update-interval 3600
      mu4e-compose-signature-auto-include t
      mu4e-view-show-images t
      mu4e-view-show-addresses t)
;; mail directory shortcuts
(setq mu4e-maildir-shortcuts
      '(
        ;; ("/outlook/inbox" . ?w
        ("/163/inbox" . ?1)
        ("/college/inbox" . ?c)))
;; bookmarks
(setq mu4e-bookmarks
      `(("flag:unread and not flag:trashed" "unread messages" ?u)
        ("date:today..now" "today's messages" ?t)
        ("date:7d..now" "last 7 days" ?w)
        ("mime:image/*" "messages with images" ?p)
        (,(mapconcat 'identity
                     (mapcar
                      (lambda (maildir)
                        (concat "maildir:" (car maildir)))
                      mu4e-maildir-shortcuts) " or ")
         "all inboxes" ?i)))
;; os notifications
(setq mu4e-enable-notifications t)
(with-eval-after-load 'mu4e-alert
  ;; enable desktop notifications
  (mu4e-alert-set-default-style 'notifications)) ; for linux
  ;; (mu4e-alert-set-default-style 'libnotify))  ; alternative for linux
  ;; (mu4e-alert-set-default-style 'notifier))   ; for mac osx (through the terminal notifier app)
;; (mu4e-alert-set-default-style 'growl))      ; alternative for mac osx
(setq mu4e-enable-mode-line t)
;; ===== eww
;; minimal rendering by default
(setq shr-inhibit-images t)
(setq shr-use-fonts nil)
;; toggle image display
(defun eww-toggle-images ()
  "toggle whether images are loaded and reload the current page fro cache."
  (interactive)
  (setq shr-inhibit-images (not shr-inhibit-images))
  (eww-reload t)
  (message "images are now %s"
           (if shr-inhibit-images "off" "on")))
(setq browse-url-browser-function 'eww-browse-url)
;; ===== shell mode
(setq shell-default-shell 'term
      shell-default-height 30
      shell-default-position 'bottom)
;; ===== fonts
;; https://github.com/jixiuf/vmacs/blob/master/conf/custom-file.el
;; 如果配置好了， 下面20个汉字与40个英文字母应该等长
;; here are 20 hanzi and 40 english chars, see if they are the same width
;; aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa|
;; 你你你你你你你你你你你你你你你你你你你你|
;; ,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,|
;; 。。。。。。。。。。。。。。。。。。。。|
;; 1111111111111111111111111111111111111111|
;; 東東東東東東東東東東東東東東東東東東東東|
;; ここここここここここここここここここここ|
;; ｺｺｺｺｺｺｺｺｺｺｺｺｺｺｺｺｺｺｺｺｺｺｺｺｺｺｺｺｺｺｺｺｺｺｺｺｺｺｺｺ|
;; 까까까까까까까까까까까까까까까까까까까까|
(defun create-frame-font-mac ()  ;; mac emacs
  (set-face-attribute
   'default nil :font "Menlo 19")
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
(defun create-frame-font-linux ()  ;; linux emacs
  (set-face-attribute
   'default nil :font "Source Code Pro 24")
  ;; Chinese Font
  (dolist (charset '( han symbol cjk-misc bopomofo))
    (set-fontset-font (frame-parameter nil 'font)
                      charset
                      (font-spec :family "AR PL UKai CN" :size 30)))
  (set-fontset-font (frame-parameter nil 'font)
                    'kana
                    (font-spec :family "MS Mincho" :size 17))
  (set-fontset-font (frame-parameter nil 'font)
                    'hangul
                    (font-spec :family "Ubuntu Mono" :size 17)))
(when (and (equal system-type 'gnu/linux) (equal window-system 'x))
  (add-hook 'after-init-hook (create-frame-font-linux)))
(defun create-frame-font-w32 ()  ;; windows emacs
  (set-face-attribute
   'default nil :font "Courier New 10")
  ;; Chinese Font
  (dolist (charset '( han symbol cjk-misc bopomofo))
    (set-fontset-font (frame-parameter nil 'font)
                      charset
                      (font-spec :family "新宋体" :size 16)))
  (set-fontset-font (frame-parameter nil 'font)
                    'kana
                    (font-spec :family "MS Mincho" :size 17))
  (set-fontset-font (frame-parameter nil 'font)
                    'hangul
                    (font-spec :family "GulimChe" :size 17)))
(when (and (equal system-type 'windows-nt) (window-system))
  (add-hook 'after-init-hook (create-frame-font-w32)))
(defun emacs-daemon-after-make-frame-hook(&optional f) ; emacsclient
  ;; (when (fboundp 'tool-bar-mode) (tool-bar-mode -1))
  ;; (when (fboundp 'scroll-bar-mode) (scroll-bar-mode -1))
  ;; (when (fboundp 'menu-bar-mode) (menu-bar-mode -1))
  (with-selected-frame f
    (when (window-system)
      (when (equal system-type 'darwin) (create-frame-font-mac))
      (when (equal system-type 'gnu/linux) (create-frame-font-linux))
      (when (equal system-type 'windows-nt) (create-frame-font-w32))
      ;; (set-frame-position f 160 80)
      ;; (set-frame-size f 140 50)
      ;; (set-frame-parameter f 'alpha 85)
      ;; (raise-frame)
      )))
(add-hook 'after-make-frame-functions 'emacs-daemon-after-make-frame-hook)
;; ===== appointments notifications
(require 'appt)
(appt-activate t)                     ;; active appointments notifications
(setq appt-display-format 'echo)    ;; message display
(setq appt-audible t)
(setq appt-display-mode-line t)       ;; display time on mode line
(setq appt-message-warning-time '5)   ;; display notifications 5 minutes before
(setq appt-display-duration '30)
(setq org-agenda-include-diary t)
(setq appt-time-msg-list nil)
(org-agenda-to-appt)                  ;; add event to appt, or press 'r' on agenda to add event
(defadvice  org-agenda-redo (after org-agenda-redo-add-appts)
  "Pressing `r' on the agenda will also add appointments."
  (progn
    (setq appt-time-msg-list nil)
    (org-agenda-to-appt)))
(ad-activate 'org-agenda-redo)
;; ===== yassnippet
(setq yas-snippet-dirs
      '("~/Documents/Garage/orgible/snippets/"                 ;; personal snippets
        ))
;; ===== buffer
;; http://camdez.com/blog/2013/11/14/emacs-show-buffer-file-name/
(defun chxin/show-and-copy-buffer-filename ()
  "Show the full path to the current file in the minibuffer and copy to clipboard."
  (interactive)
  (let ((file-name (buffer-file-name)))
    (if file-name
        (progn
          (message file-name)
          (kill-new file-name))
      (error "Buffer not visiting a file"))))
;; ===== password
(require 'ps-ccrypt "ps-ccrypt.el")
(defun random-alphanum ()
  (let* ((charset "abcdefghijklmnopqrstuvwxyz0123456789")
         (x (random 36)))
    (char-to-string (elt charset x))))
(defun create-password ()
  (let ((value ""))
    (dotimes (number 16 value)
      (setq value (concat value (random-alphanum))))))
(defun get-or-create-password ()
  (setq password (read-string "Password: "))
  (if (string= password "")
      (create-password)
    password))
(add-to-list 'org-capture-templates
             '("s" "Passwords" entry (file "~/Documents/Garage/orgible/oxrign/passwords.org.cpt")
               "* %U - %^{title} %^G\n\n  - NAME: %^{User Name}\n  - PASSWORDS: %(get-or-create-password)"
               :empty-lines 1 :kill-buffer t))
;; ===== Bill
(defun get-year-and-month ()
  (list (format-time-string "%Y") (format-time-string "%m")))
(defun find-month-tree ()
  (let* ((path (get-year-and-month))
         (level 1)
         end)
    (unless (derived-mode-p 'org-mode)
      (error "Target buffer \"%s\" should be in Org mode" (current-buffer)))
    (goto-char (point-min))
    (dolist (heading path)
      (let ((re (format org-complex-heading-regexp-format
                        (regexp-quote heading)))
            (cnt 0))
        (if (re-search-forward re end t)
            (goto-char (point-at-bol))
          (progn
            (or (bolp) (insert "\n"))
            (if (/= (point) (point-min)) (org-end-of-subtree t t))
            (insert (make-string level ?*) " " heading "\n"))))
      (setq level (1+ level))
      (setq end (save-excursion (org-end-of-subtree t t))))
    (org-end-of-subtree)))
(add-to-list 'org-capture-templates
             '("l" "Billing" plain
               (file+function "~/Documents/Garage/orgible/inbox.org" find-month-tree)
               " | %U | %^{Type} | %^{Detailed} | %^{money} |" :kill-buffer t))
;; ===== smart input source
;; add "sis" to dotspacemacs-additional-packages
;; use "macism" to get the name of inut-method
(if (equal system-type 'gnu/linux)
    ;; (sis-ism-lazyman-config "1" "2" 'fcitx)
    (sis-ism-lazyman-config nil "pyim" 'native)
  (sis-ism-lazyman-config
   "com.apple.keylayout.ABC"
   "com.apple.inputmethod.SCIM.Shuangpin"))
(sis-global-cursor-color-mode t)
(sis-global-respect-mode t)
;; (sis-global-follow-context-mode t)
(sis-global-inline-mode t)
;; === chinese input method
;; (global-set-key (kbd "\C-\\") nil)
;; (setenv "LC_CTYPE" "zh_CN.UTF-8")
(require 'pyim-basedict)
(pyim-basedict-enable)
(setq pyim-default-scheme 'microsoft-shuangpin)
(setq pyim-page-tooltip 'posframe)
(setq pyim-page-length 5)
(define-key pyim-mode-map "." 'pyim-page-next-page)
(define-key pyim-mode-map "," 'pyim-page-previous-page)
(pyim-isearch-mode 1)
;; ===== emacs application framework
(when (equal system-type 'gnu/linux) (require 'eaf))

;; end
(provide 'tools)
