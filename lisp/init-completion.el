
;;modeline上显示我的所有的按键和执行的命令
(package-install 'keycast)
(keycast-mode-line-mode t)

(package-install 'company)

;;(package-install 'google-translate)

;; minibuf 出现选择列表
(package-install 'vertico)
(vertico-mode t)

;; 优化vertico 支持模糊搜索
(package-install 'orderless)
(setq completion-styles '(orderless)) 

;; 优化vertco 增加列表更多信息
(package-install 'marginalia)
(marginalia-mode t)

;; 增强一些奇奇怪怪的东西
(package-install 'embark)
(global-set-key (kbd "C-;") 'embark-act)
(setq prefix-help-command 'embark-prefix-help-command) ;; 增强 C-x C-h 可以直接执行快捷键


(global-company-mode 1)
;; (setq company-minimum-prefix-length 3)
(setq company-idle-delay 0.3)

(setq tab-always-indent 'complete)


(package-install 'embark-consult)
(package-install 'wgrep)
(setq wgrep-auto-save-buffer t)

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


(provide 'init-completion)
