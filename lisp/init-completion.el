(use-package company
  :bind (:map company-active-map
	      ("C-j" . 'company-select-next)
	      ("C-k" . 'company-select-previous))
  :init
  (global-company-mode t)
  :config
  (setq company-minimum-prefix-length 2)
  (setq company-idle-delay 0))

;;modeline上显示我的所有的按键和执行的命令
;(use-package keycast
;  :init
;  (add-to-list 'global-mode-string '("" keycast-mode-line))
;  (keycast-mode-line-mode))

(use-package keycast
  :config
  (define-minor-mode keycast-mode
    "Show current command and its key binding in the mode line (fix for use with doom-mode-line)."
    :global t
    (if keycast-mode
        (add-hook 'pre-command-hook 'keycast--update t)
      (remove-hook 'pre-command-hook 'keycast--update)))
  (add-to-list 'global-mode-string '("" keycast-mode-line))
  (keycast-mode t)
  (keycast-tab-bar-mode t))


(use-package consult)

;;(package-install 'google-translate)

;; minibuf 出现选择列表
(use-package vertico
  :init
  (vertico-mode t)
  :bind (:map vertico-map
	      ("C-j" . 'vertico-next)
	      ("C-k" . 'vertico-previous)))

;; 优化vertico 支持模糊搜索
(use-package orderless
  :config
  (setq completion-styles '(orderless)))

;; 优化vertco 增加列表更多信息
(use-package marginalia
  :init
  (marginalia-mode t))

;; 增强一些奇奇怪怪的东西
(use-package embark
  :bind
  ("C-;" . 'embark-act)
  ("C-s" . 'consult-line)
  ("M-s-i" . 'consult-imenu)
  (:map embark-file-map
	("E" . 'consult-directory-externally))
  :config
  ;; 增强 C-x C-h 可以直接执行快捷键		
  (setq prefix-help-command 'embark-prefix-help-command))


(setq tab-always-indent 'complete)


(use-package embark-consult
  :bind
  (:map minibuffer-local-map ("C-c C-e" . 'embark-export)))

(use-package wgrep
  :config
  (setq wgrep-auto-save-buffer t))

(eval-after-load
    'consult
  '(eval-after-load
       'embark
     '(progn
	(require 'embark-consult)
	(add-hook
	 'embark-collect-mode-hook
	 #'consult-preview-at-point-mode))))


;; 函数签名
(eldoc-mode 1)

;;查看major mode
;;C-h m
;;(describe-mode)


;;REPL read eval print loop

;;快捷键
;;C-x C-h 查看C-x为前缀的所有快捷键

(use-package which-key :ensure t :defer t
  :hook (after-init . which-key-mode))

(provide 'init-completion)
