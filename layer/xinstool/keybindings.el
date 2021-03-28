;; Labels the app as sdcv so it doesn't appear as "prefix" in the menu
(spacemacs/declare-prefix "x s" "sdcv")

;; The remaining useful keybindings to using sdcv
(spacemacs/set-leader-keys
  "x s q" 'sdcv-search-input+
  "x s s" 'sdcv-search-pointer+
  "x s i" 'insert-translated-name-insert
  "x s r" 'insert-translated-name-replace
  "x s t" 'toggle-company-english-helper
  )
