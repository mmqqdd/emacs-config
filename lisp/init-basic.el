
(server-mode 1)
(electric-pair-mode t)

(show-paren-mode t)

(setq make-backup-files nil)

(require 'recentf)
(recentf-mode 1)
(setq recentf-max-menu-item 10)


;; 自动刷新文件
(global-auto-revert-mode 1)
;;(delete-selection-mode t)

;; 关闭自动保存
(setq auto-save-default nil)

;; 关闭错误提示音
(setq ring-bell-function 'ignore)

(fset 'yes-or-no-p 'y-or-n-p)

;; 记住历史操作
(use-package savehist
  :ensure nil
  :hook (after-init . savehist-mode)
  :init (setq enable-recursive-minibuffers t ; Allow commands in minibuffers
	      history-length 1000
	      savehist-additional-variables '(mark-ring
					      global-mark-ring
					      search-ring
					      regexp-search-ring
					      extended-command-history)
	      savehist-autosave-interval 300)
  )

(use-package saveplace
  :ensure nil
  :hook (after-init . save-place-mode))


;; Encodeing
;; UTF-8 as the default coding system

;;(when (fboundp 'set-charset-priority)
;;  (set-charset-priority 'unicode))

;;(set-language-environment 'chinese-gbk)
;;(prefer-coding-system 'utf-8-auto)

(provide 'init-basic)
