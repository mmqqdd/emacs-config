
(server-mode 1)
(electric-pair-mode t)

(show-paren-mode t)

(setq make-backup-files nil)

(require 'recentf)
(recentf-mode 1)
(setq recentf-max-menu-item 10)


;;(delete-selection-mode t)


;; Encodeing
;; UTF-8 as the default coding system

(when (fboundp 'set-charset-priority)
  (set-charset-priority 'unicode))

(set-language-environment 'chinese-gbk)
(prefer-coding-system 'utf-8-auto)

(provide 'init-basic)
