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
    "/" 'my/search-project-for-symbol-at-point
    )

  (+general-global-menu! "search" "s"
    "b" 'my/search-for-symbol-at-point)
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
    "K" 'kill-other-buffers))

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
		'zilongshanren/highlight-dwim)))
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
      (setq ad-return-value (cons new-msg new-bindings)))))


(provide 'init-evil)



