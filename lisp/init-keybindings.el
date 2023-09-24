(global-set-key (kbd "s-a") 'mark-whole-buffer) ;;对应Windows上面的Ctrl-a 全选
(global-set-key (kbd "s-c") 'kill-ring-save) ;;对应Windows上面的Ctrl-c 复制
(global-set-key (kbd "s-s") 'save-buffer) ;; 对应Windows上面的Ctrl-s 保存
(global-set-key (kbd "s-v") 'yank) ;对应Windows上面的Ctrl-v 粘贴
(global-set-key (kbd "s-z") 'undo) ;对应Windows上面的Ctrol-z 撤销
(global-set-key (kbd "s-x") 'execute-extended-command) ;对应Windows上面的Ctrol-x 剪切


(define-key company-active-map (kbd "C-j") 'company-select-next)
(define-key company-active-map (kbd "C-k") 'company-select-previous)


;; eval-after-load 'embark 表示embark加载之后，再执行以下命令
(eval-after-load 'embark
  '(define-key embark-file-map (kbd "E") #'consult-directory-externally))

(global-set-key (kbd "C-;") 'embark-act)


(global-set-key (kbd "C-s") 'consult-line)
(global-set-key (kbd "M-s-i") 'consult-imenu)


(define-key minibuffer-local-map (kbd "C-c C-e") 'embark-export-write)


(define-key company-active-map (kbd "C-j") 'company-select-next)
(define-key company-active-map (kbd "C-k") 'company-select-previous)

(global-set-key (kbd "<f2>") 'open-init-file)

(provide 'init-keybindings)
