;;; packages.el --- xinstool layer packages file for Spacemacs.
;;
;; Copyright (c) 2012-2020 Sylvain Benner & Contributors
;;
;; Author: xin <xin@CHxin>
;; URL: https://github.com/syl20bnr/spacemacs
;;
;; This file is not part of GNU Emacs.
;;
;;; License: GPLv3
(defconst xinstool-packages
  '(
    (sdcv
     :location (recipe
                :fetcher github
                :repo "manateelazycat/sdcv"))
    posframe
    (company-english-helper
     :location (recipe
                :fetcher github
                :repo "manateelazycat/company-english-helper"))
    (insert-translated-name
     :location (recipe
                :fetcher github
                :repo "manateelazycat/insert-translated-name"))
    sis
    org-mind-map
    magit-todos
    org-projectile
    pangu-spacing
    (advance-words-count
     :location (recipe
                :fetcher github
                :repo "LdBeth/advance-words-count.el"))
    zotxt
    )
  )
(defun xinstool/init-sdcv ()
  (use-package sdcv
    :config
    (progn
      (setq sdcv-say-word-p t)
      (setq sdcv-dictionary-data-dir (file-truename "/Users/xin/.stardict/dic"))
      (setq sdcv-dictionary-simple-list
            '(
              "朗道汉英字典 5.0"
              "朗道英汉字典 5.0"
              "懒虫简明英汉词典"
              "懒虫简明汉英词典"
              ))
      (setq sdcv-dictionary-complete-list
            '(
              "牛津现代英汉双解词典"
              "CEDICT 汉英辞典"
              "懒虫简明汉英词典"
              "懒虫简明英汉词典"
              "朗道汉英字典 5.0"
              "朗道英汉字典 5.0"
              ))
      )
    )
  )
(defun xinstool/post-init-posframe ())
(defun xinstool/init-company-english-helper ()
  (use-package company-english-helper))
(defun xinstool/init-insert-translated-name ()
  (use-package insert-translated-name))
(defun xinstool/init-org-mind-map ())
(defun xinstool/init-magit-todos ())
(defun xinstool/post-init-org-projectile ()
  (use-package org-projectile
    :config
    (with-eval-after-load 'org
      (mapcar '(lambda (file)
                 (when (file-exists-p file)
                   (push file org-agenda-files)))
              (org-projectile-todo-files)))))
;; add "sis" to dotspacemacs-additional-packages
;; use "macism" to get the name of inut-method
(defun xinstool/init-sis ()
  (use-package sis
    :config
    (progn
      (if (equal system-type 'gnu/linux)
          ;; (sis-ism-lazyman-config "1" "2" 'fcitx)
          (sis-ism-lazyman-config nil "pyim" 'native)
        (sis-ism-lazyman-config
         "com.apple.keylayout.ABC"
	       ;; "com.apple.inputmethod.SCIM.ITABC"
         "com.apple.inputmethod.SCIM.Shuangpin"
         ))
      (setq sis-inline-tighten-head-rule 'all)
      (setq sis-inline-tighten-tail-rule 'all)
      (sis-global-cursor-color-mode t)
      (sis-global-respect-mode t)
      (sis-global-context-mode t)
      (sis-global-inline-mode t)
      )))
(defun xinstool/init-pangu-spacing ()
  (use-package pangu-spacing
    :defer t
    :init (progn (global-pangu-spacing-mode 1)
                 (spacemacs|hide-lighter pangu-spacing-mode)
                 (setq-default pangu-spacing-real-insert-separtor t)
                 ;; Always insert `real' space in org-mode.
                 (add-hook 'org-mode-hook
                           '(lambda ()
                              (set (make-local-variable 'pangu-spacing-real-insert-separtor) t))))))
(defun xinstool/init-advance-words-count() )
(defun xinstool/init-zotxt() )
;;; packages.el ends here
