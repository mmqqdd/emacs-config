(use-package eglot
  :ensure t  ; 确保 eglot 已经安装
  :hook (((c-mode c++-mode) . eglot-ensure)  ; 在 c-mode 和 c++-mode 下自动启动 eglot
         (eglot--managed-mode . (lambda () (setq tab-width 4))))  ; 设置 tab-width 为 4
  :config
  (add-to-list 'eglot-server-programs '((c++-mode c++-ts-mode c-mode c-ts-mode) "ccls")))  ; 添加 ccls 作为 c 和 c++ 的 LSP 服务器

(use-package go-mode
  :ensure t
  :mode ("\\.go\\'" . go-mode)
  :config
  ;; 这里可以添加你需要的其他配置
  )

(use-package quickrun
  :ensure t
  :commands (quickrun)
  :init
  (quickrun-add-command "c++/c1z"
    '((:command . "g++-13")
      (:exec . ("%c -std=c++1z %o -o %e %s"
		"%e %a"))
      (:remove . ("%e")))
    :default "c++"))


(use-package treesit-auto
  :demand t
  :config
  (setq treesit-auto-install 'prompt)
  (global-treesit-auto-mode))

(evil-define-key 'normal global-map (kbd "g r") 'xref-find-references)
(evil-define-key 'normal global-map (kbd "g d") 'xref-find-definitions)


(use-package yasnippet
  :ensure t
  :hook ((prog-mode . yas-minor-mode)
	 (org-mode . yas-minor-mode))
  :init
  :config
  (progn
    (setq hippie-expand-try-functions-list
	  '(yas/hippie-try-expand
	    try-complete-file-name-partiall
	    try-expand-all-abbrevs
	    try-expand-dabbrev
	    try-expand-dabbrev-all-buffers
	    try-expand-dabbrev-from-kill
	    try-complete-lisp-symbol-partially
	    try-complete-lisp-symbol))))

(use-package yasnippet-snippets
  :ensure t
  :after yasnippet)

(evil-define-key 'normal global-map (kbd "g f") 'yas-expand)

(use-package lua-mode
  :ensure t   ; 确保 lua-mode 被安装
  :config
  (setq lua-indent-level 2) ; 设置 Lua 的缩进级别为2
  :mode ("\\.lua\\'" . lua-mode)) ; 设置 Lua 模式自动加载对于.lua 文件

(setq tab-width 4)

(provide 'init-programming)
