(global-set-key (kbd "s-a") 'mark-whole-buffer) ;;对应Windows上面的Ctrl-a 全选
(global-set-key (kbd "s-c") 'kill-ring-save) ;;对应Windows上面的Ctrl-c 复制
(global-set-key (kbd "s-s") 'save-buffer) ;; 对应Windows上面的Ctrl-s 保存
(global-set-key (kbd "s-v") 'yank) ;对应Windows上面的Ctrl-v 粘贴
(global-set-key (kbd "s-z") 'undo) ;对应Windows上面的Ctrol-z 撤销
(global-set-key (kbd "s-x") 'execute-extended-command) ;对应Windows上面的Ctrol-x 剪切


;; eval-after-load 'embark 表示embark加载之后，再执行以下命令
;(eval-after-load 'embark
;  '(define-key embark-file-map (kbd "E") #'consult-directory-externally))

;(global-set-key (kbd "C-;") 'embark-act)


;(global-set-key (kbd "C-s") 'consult-line)
;(global-set-key (kbd "M-s-i") 'consult-imenu)		 	


(define-key minibuffer-local-map (kbd "C-c C-e") 'embark-export)
;(add-hook 'embark-collect-mode-hook #'consult-preview-at-point-mode)




(global-set-key (kbd "<f2>") 'open-init-file)


(global-set-key (kbd "C-c p f") 'project-find-file)
(global-set-key (kbd "C-c p s") 'consult-ripgrep)


(provide 'init-keybindings)
