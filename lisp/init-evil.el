(use-package evil
  :ensure t
  :init
  (setq evil-want-keybinding nil) ;;取消一些其它mode下的绑定键
  (setq evil-want-C-u-scroll t) ;; C-u 用于滚动
  (evil-mode)
  ;; https://emacs.stackexchange.com/questions/46371/how-can-i-get-ret-to-follow-org-mode-links-when-using-evil-mode
  (with-eval-after-load 'evil-maps
    (define-key evil-motion-state-map (kbd "RET") nil)) ;;在org-mode下按回车可以返回链接
  )

(define-key evil-normal-state-map (kbd "[ SPC") (lambda () (interactive) (evil-insert-newline-above) (forward-line)))


(define-key evil-normal-state-map (kbd "] SPC") (lambda () (interactive) (evil-insert-newline-below) (forward-line -1)))

;; install undo-tree hello
(use-package undo-tree
  :diminish
  :init
  (global-undo-tree-mode 1)
  (setq undo-tree-auto-save-history nil)
  (evil-set-undo-system 'undo-tree)) ;; evil-undo 使用undo-tree


(use-package evil-surround
  :ensure t
  :init
  (global-evil-surround-mode t))

;; 注释
(use-package evil-nerd-commenter
  :init
  (define-key evil-normal-state-map (kbd ";") 'evilnc-comment-or-uncomment-lines)
  (define-key evil-visual-state-map (kbd ";") 'evilnc-comment-or-uncomment-lines)
 )

;; 和f 查找有关
(use-package evil-snipe
  :ensure t
  :diminish
  :init
  (evil-snipe-mode +1)
  (evil-snipe-override-mode +1))



(use-package general
  :init
  (with-eval-after-load 'evil
    (general-add-hook 'after-init-hook
		      (lambda (&rest _)
			(when-let ((messages-buffer (get-buffer "*Messages*")))
			  (with-current-buffer messages-buffer
			    (evil-normalize-keymaps))))
		      nil
		      nil
		      t))


  (general-create-definer global-definer
    :keymaps 'override
    :states '(insert emacs normal hybrid motion visual operator)
    :prefix "SPC"
    :non-normal-prefix "C-SPC")

  (defmacro +general-global-menu! (name infix-key &rest body)
    "Create a definer named +general-global-NAME wrapping global-definer.
Create prefix map: +general-global-NAME. Prefix bindings in BODY with INFIX-KEY."
    (declare (indent 2))
    `(progn
       (general-create-definer ,(intern (concat "+general-global-" name))
	 :wrapping global-definer
	 :prefix-map ',(intern (concat "+general-global-" name "-map"))
	 :infix ,infix-key
	 :wk-full-keys nil
	 "" '(:ignore t :which-key ,name))
       (,(intern (concat "+general-global-" name))
	,@body)))

  (general-create-definer global-leader
    :keymaps 'override
    :states '(emacs normal hybrid motion visual operator)
    :prefix ","
    "" '(:ignore t :which-key (lambda (arg) `(,(cadr (split-string (car arg) " ")) . ,(replace-regexp-in-string "-mode$" "" (symbol-name major-mode)))))))

(use-package general
  :init
  (global-definer
    "!" 'shell-command
    ";" 'execute-extended-command
    "SPC" 'project-find-file
    "'" 'vertico-repeat
    "v" 'er/expand-region
    "+" 'text-scale-increase
    "-" 'text-scale-decrease
    "u" 'universal-argument
    "hf" 'describe-function
    "hc" 'zilongshanren/clearn-highlight
    "hv" 'describe-variable
    "hk" 'describe-key
    "/" '(my/search-project-for-symbol-at-point :which-key "项目中搜索")
    "RET" 'bookmark-jump
    )

  (+general-global-menu! "search" "s"
    "b" 'my/search-for-symbol-at-point
    "h" 'mqd/highlight-at-point
    "c" 'mqd/clearn-highlight)

  (+general-global-menu! "agenda" "a"
    "a" 'my/org-agenda-list)

  (+general-global-menu! "export" "e"
    "i" '(my/org-current-entry-to-mac-calendar :which-key "org-to-icalender")
    "m" '(org-hugo-export-to-md :which-key "org-to-hugo-markdown"))

  (+general-global-menu! "file" "f"
    "p" 'open-init-file
    "f" 'find-file
    "y" '(my/copy-current-buffer-file-path :which-key "copy-file-path")
    "d" '(my/copy-current-directory-to-clipboard :which-key "copy-dir-path")
    "c" 'org-download-clipboard)

  (+general-global-menu! "buffer" "b"
    "s" 'my/search-for-symbol-at-point
    "d" 'kill-current-buffer
    "b" '(consult-buffer :which-key "consult buffer")
    "B" 'switch-to-buffer
    "p" 'previous-buffer
    "R" 'rename-buffer
    "M" '((lambda () (interactive) (switch-to-buffer "*Messages*"))
	  :which-key "messages-buffer")
    "n" 'next-buffer
    "i" 'ibuffer
    "f" 'my-open-current-directory
    "k" 'kill-buffer
    "y" 'copy-buffer-name
    "K" 'kill-other-buffers
    "m" 'bookmark-set))


(+general-global-menu! "window" "w"
  "d" '(delete-window :which-key "关闭窗口")
  "/" '(split-window-right :which-key "右分屏")
  "-" '(split-window-below :which-key "下分屏")
  "h" '(evil-window-left :which-key "左移")
  "j" '(evil-window-down :which-key "下移")
  "k" '(evil-window-up :which-key "上移")
  "l" '(evil-window-right :which-key "右移")
  "H" '(buf-move-left :which-key "界面左移")
  "J" '(buf-move-down :which-key "界面下移")
  "K" '(buf-move-up :which-key "界面上移")
  "L" '(buf-move-right :which-key "界面右移")
  "x" 'resize-window
  "u" 'winner-undo
  "r" 'winner-redo
  "o" 'delete-other-windows
  "=" 'balance-windows-area)

(+general-global-menu! "layout" "l"
  "l" 'tab-bar-switch-to-next-tab
  "h" 'tab-bar-switch-to-prev-tab
  "L" 'tabspaces-restore-session
  "p" 'tabspaces-open-or-create-project-and-workspace
  "f" 'tabspaces-project-switch-project-open-file
  "s" 'tabspaces-save-session
  "B" 'tabspaces-switch-buffer-and-tab
  "b" 'tabspaces-switch-to-buffer
  "R" 'tab-rename
  "TAB" 'tab-bar-switch-to-recent-tab
  "r" 'tabspaces-remove-current-buffer
  "k" 'tabspaces-close-workspace)

(+general-global-menu! "project" "p"
  "p" '(tabspaces-open-or-create-project-and-workspace :which-key "open-project")
  "d" '(tabspaces-remove-current-buffer :which-key "remove-buffer")
  "s" 'tabspaces-save-session
  "R" 'tab-rename
  "k" 'tabspaces-close-workspace)

(+general-global-menu! "open" "o"
  "p" 'treemacs
  "t" 'my/open-eshell-at-bottom)

(+general-global-menu! "translate" "t"
  "t" 'google-translate-at-point
  "T" 'google-translate-at-point-reverse
  "w" 'google-translate-query-translate
  "W" 'google-translate-query-translate)

;; 选中单词，R，批量操作所有相同单词
(use-package iedit
  :ensure t
  :init
  (setq iedit-toggle-key-default nil)
  :config
  (define-key iedit-mode-keymap (kbd "M-h") 'iedit-restrict-function)
  (define-key iedit-mode-keymap (kbd "M-i") 'iedit-restrict-current-line))

;; 选中单词，R，批量操作所有相同单词
(use-package evil-multiedit
  :ensure t
  :commands (evil-multiedit-default-keybinds)
  :init
  (evil-multiedit-default-keybinds))


(use-package expand-region
  :config
  (defadvice er/prepare-for-more-expansions-internal
      (around helm-ag/prepare-for-more-expansions-internal activate)
    ad-do-it
    (let ((new-msg (concat (car ad-return-value)
			   ", H to highlight in buffers"
			   ", / to search in project, "
			   "e iedit mode in functions"
			   "f to search in files, "
			   "b to search in opened buffers"))
	  (new-bindings (cdr ad-return-value)))
      (cl-pushnew
       '("H" (lambda ()
	       (interactive)
	       (call-interactively
		'mqd/highlight-at-point)))
       new-bindings)
      (cl-pushnew
       '("/" (lambda ()
	       (interactive)
	       (call-interactively
		'my/search-project-for-symbol-at-point)))
       new-bindings)
      (cl-pushnew
       '("e" (lambda ()
	       (interactive)
	       (call-interactively
		'evil-multiedit-match-all)))
       new-bindings)
      (cl-pushnew
       '("f" (lambda ()
	       (interactive)
	       (call-interactively
		'find-file)))
       new-bindings)
      (cl-pushnew
       '("b" (lambda ()
	       (interactive)
	       (call-interactively
		'my/search-for-symbol-at-point)))
       new-bindings)
      (cl-pushnew
       '("t" (lambda ()
	       (interactive)
	       (call-interactively
		'google-translate-at-point)))
       new-bindings)
      (cl-pushnew
       '("T" (lambda ()
	       (interactive)
	       (call-interactively
		'google-translate-at-point-reverse)))
       new-bindings)
      (setq ad-return-value (cons new-msg new-bindings)))))


(provide 'init-evil)



