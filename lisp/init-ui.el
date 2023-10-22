;; 关闭启动页面
(setq inhibit-startup-screen t)

;; 关闭工具栏，tool-bar-mode 即为一个 Minor Mode
(tool-bar-mode -1)

;; 关闭文件滑动控件
(scroll-bar-mode -1)

;; 显示行号
(global-display-line-numbers-mode)


;; 更改光标的样式
(setq-default cursor-type 'bar)
;; (set-frame-font "Source Code Pro for Powerline 13" nil t)


(use-package all-the-icons :ensure t)
;; (set-frame-font "FiraCode Nerd Font 13" nil t)

;; 更改显示字体大小 14pt
;; http://stackoverflow.com/questions/294664/how-to-set-the-font-size-in-emacs
;; (set-face-attribute 'default nil :height 130)

;;让鼠标滚动更好用
(setq mouse-wheel-scroll-amount '(1 ((shift) . 1) ((control) . nil)))
(setq mouse-wheel-progressive-speed nil)

(global-hl-line-mode 1)

(use-package doom-themes)
(load-theme 'doom-one 1)

(toggle-frame-maximized)

(use-package doom-modeline
  :init
  (doom-modeline-mode t))

(use-package simple-modeline
  :hook (after-init . size-indication-mode)
  :init
  (progn
    (setq column-number-mode t)
    ))

(setq scroll-conservatively 100000) ;; 当光标处于最后一行，执行 next-line,不会将光标跳跃到中间
(setq scroll-margin 0)


(use-package cnfonts
  :init (cnfonts-mode 1)
  ;; 添加两个字号增大缩小的快捷键
  :bind
  (:map cnfonts-mode-map
	("C--" . cnfonts-decrease-fontsize)
	("C-=" . cnfonts-increase-fontsize)
	
	)
  :config
  ;; 当进入 cnfonts-ui-mode 时，自动切换到 Evil 的 Emacs state
  (add-hook 'cnfonts-ui-mode-hook #'evil-emacs-state))
(setq cnfonts-personal-fontnames '(;; 英文字体
				   ("FiraCode Nerd Font" "Source Code Pro for Powerline")
				   ;; 中文字体
				   ("行楷-简" "行楷-繁")
				   ))

    
(use-package nerd-icons-dired
  :hook
  (dired-mode . nerd-icons-dired-mode))

(set-fontset-font t 'symbol "Noto Color Emoji")

(use-package emojify
  :init
  (global-emojify-mode t))

(use-package buffer-move
  :ensure t)
(use-package resize-window
  :ensure t
  :init
  (defvar resize-window-dispatch-alist
    '((?j resize-window--enlarge-down " Resize - Expand down" t)
      (?k resize-window--enlarge-up " Resize - Expand up" t)
      (?h resize-window--enlarge-horizontally " Resize - horizontally" t)
      (?l resize-window--shrink-horizontally " Resize - shrink horizontally" t)
      (?r resize-window--reset-windows " Resize - reset window layout" nil)
      (?w resize-window--cycle-window-positive " Resize - cycle window" nil)
      (?W resize-window--cycle-window-negative " Resize - cycle window" nil)
      (?2 split-window-below " Split window horizontally" nil)
      (?3 split-window-right " Slit window vertically" nil)
      (?0 resize-window--delete-window " Delete window" nil)
      (?K resize-window--kill-other-windows " Kill other windows (save state)" nil)
      (?y resize-window--restore-windows " (when state) Restore window configuration" nil)
      (?? resize-window--display-menu " Resize - display menu" nil))
    "List of actions for `resize-window-dispatch-default.
Main data structure of the dispatcher with the form:
\(char function documentation match-capitals\)"))

(global-set-key (kbd "C-s-.")
                (lambda()
                  (interactive)
                  (evil-window-increase-width 10)))

(global-set-key (kbd "C-s-,")
                (lambda()
                  (interactive)
                  (evil-window-decrease-width 10)))

(global-set-key (kbd "C-s-=")
                (lambda()
                  (interactive)
                  (evil-window-increase-height 10)))

(global-set-key (kbd "C-s--")
                (lambda()
                  (interactive)
                  (evil-window-decrease-height 10)))
;; winner-mode winner-left winner-right
(use-package winner
  :ensure nil
  :commands (winner-undo winner-redo)
  :hook (after-init . winner-mode)
  :init (setq winner-boring-buffers '("*Completions*"
				      "*Compile-Log*"
				      "*inferior-lisp*"
				      "*Fuzzy Completions*"
				      "*Apropos*"
				      "*Help*"
				      "*cvs*"
				      "*Buffer List*"
				      "*Ibuffer*"
				      "*esh command on file*")))
(use-package tab-bar
  :ensure nil
  :init
  (tab-bar-mode t)
  (setq tab-bar-new-tab-choice "*scratch*") ;; buffer to show in new tabs
  (setq tab-bar-close-button-show nil)      ;; hide tab close / X button
  (setq tab-bar-show 1)                     ;; hide bar if <= 1 tabs open
  (setq tab-bar-format '(tab-bar-format-tabs tab-bar-separator))

  (custom-set-faces
   '(tab-bar ((t (:inherit mode-line))))
   '(tab-bar-tab ((t (:inherit mode-line :foreground "#998344"))))
   '(tab-bar-tab-inactive ((t (:inherit mode-line-inactive :foreground "white")))))

  
  (defvar ct/circle-numbers-alist
    '((0 . "⓪")
      (1 . "①")
      (2 . "②")
      (3 . "③")
      (4 . "④")
      (5 . "⑤")
      (6 . "⑥")
      (7 . "⑦")
      (8 . "⑧")
      (9 . "⑨"))
    "Alist of integers to strings of circled unicode numbers.")

  (defun ct/tab-bar-tab-name-format-default (tab i)
    (let ((current-p (eq (car tab) 'current-tab))
	  (tab-num (if (and tab-bar-tab-hints (< i 10))
		       (alist-get i ct/circle-numbers-alist) "")))
      (propertize
       (concat tab-num
	       " "
	       (alist-get 'name tab)
	       (or (and tab-bar-close-button-show
			(not (eq tab-bar-close-button-show
				 (if current-p 'non-selected 'selected)))
			tab-bar-close-button)
		   "")
	       " ")
       'face (funcall tab-bar-tab-face-function tab))))
  (setq tab-bar-tab-name-format-function #'ct/tab-bar-tab-name-format-default)
  (setq tab-bar-tab-hints t))
(use-package tabspaces
  ;; use this next line only if you also use straight, otherwise ignore it.
  :hook (after-init . tabspaces-mode) ;; use this only if you want the minor-mode loaded at startup.
  :commands (tabspaces-switch-or-create-workspace
	     tabspaces-open-or-create-project-and-workspace)
  :custom
  (tabspaces-use-filtered-buffers-as-default t)
  (tabspaces-default-tab "Default")
  (tabspaces-remove-to-default t)
  (tabspaces-include-buffers '("*scratch*"))
  ;; maybe slow
  ;;(tabspaces-session t)
  ;;(tabspaces-session-auto-restore t)
  :config
  ;; Filter Buffers for Consult-Buffer

  (with-eval-after-load 'consult
    ;; hide full buffer list (still available with "b" prefix)
    (consult-customize consult--source-buffer :hidden nil :default nil)
    ;; set consult-workspace buffer list
    (defvar consult--source-workspace
      (list :name "Workspace Buffers"
	    :narrow ?w
	    :history 'buffer-name-history
	    :category 'buffer
	    :state #'consult--buffer-state
	    :default t
	    :items (lambda () (consult--buffer-query
			       :predicate #'tabspaces--local-buffer-p
			       :sort 'visibility
			       :as #'buffer-name)))

      "Set workspace buffer list for consult-buffer.")
    (add-to-list 'consult-buffer-sources 'consult--source-workspace)))

(use-package treemacs
  :ensure t
  :defer t
  :init
  (with-eval-after-load 'winum
    (define-key winum-keymap (kbd "M-0") #'treemacs-select-window))
  :config
  (progn
    (setq treemacs-collapse-dirs                   (if treemacs-python-executable 3 0)
          treemacs-deferred-git-apply-delay        0.5
          treemacs-directory-name-transformer      #'identity
          treemacs-display-in-side-window          t
          treemacs-eldoc-display                   'simple
          treemacs-file-event-delay                2000
          treemacs-file-extension-regex            treemacs-last-period-regex-value
          treemacs-file-follow-delay               0.2
          treemacs-file-name-transformer           #'identity
          treemacs-follow-after-init               t
          treemacs-expand-after-init               t
          treemacs-find-workspace-method           'find-for-file-or-pick-first
          treemacs-git-command-pipe                ""
          treemacs-goto-tag-strategy               'refetch-index
          treemacs-header-scroll-indicators        '(nil . "^^^^^^")
          treemacs-hide-dot-git-directory          t
          treemacs-indentation                     2
          treemacs-indentation-string              " "
          treemacs-is-never-other-window           nil
          treemacs-max-git-entries                 5000
          treemacs-missing-project-action          'ask
          treemacs-move-forward-on-expand          nil
          treemacs-no-png-images                   nil
          treemacs-no-delete-other-windows         t
          treemacs-project-follow-cleanup          nil
          treemacs-persist-file                    (expand-file-name ".cache/treemacs-persist" user-emacs-directory)
          treemacs-position                        'left
          treemacs-read-string-input               'from-child-frame
          treemacs-recenter-distance               0.1
          treemacs-recenter-after-file-follow      nil
          treemacs-recenter-after-tag-follow       nil
          treemacs-recenter-after-project-jump     'always
          treemacs-recenter-after-project-expand   'on-distance
          treemacs-litter-directories              '("/node_modules" "/.venv" "/.cask")
          treemacs-project-follow-into-home        nil
          treemacs-show-cursor                     nil
          treemacs-show-hidden-files               t
          treemacs-silent-filewatch                nil
          treemacs-silent-refresh                  nil
          treemacs-sorting                         'alphabetic-asc
          treemacs-select-when-already-in-treemacs 'move-back
          treemacs-space-between-root-nodes        t
          treemacs-tag-follow-cleanup              t
          treemacs-tag-follow-delay                1.5
          treemacs-text-scale                      nil
          treemacs-user-mode-line-format           nil
          treemacs-user-header-line-format         nil
          treemacs-wide-toggle-width               70
          treemacs-width                           35
          treemacs-width-increment                 1
          treemacs-width-is-initially-locked       t
          treemacs-workspace-switch-cleanup        nil)

    ;; The default width and height of the icons is 22 pixels. If you are
    ;; using a Hi-DPI display, uncomment this to double the icon size.
    ;;(treemacs-resize-icons 44)

    (treemacs-follow-mode t)
    (treemacs-filewatch-mode t)
    (treemacs-fringe-indicator-mode 'always)
    (when treemacs-python-executable
      (treemacs-git-commit-diff-mode t))

    (pcase (cons (not (null (executable-find "git")))
                 (not (null treemacs-python-executable)))
      (`(t . t)
       (treemacs-git-mode 'deferred))
      (`(t . _)
       (treemacs-git-mode 'simple)))

    (treemacs-hide-gitignored-files-mode nil))
  :bind
  (:map global-map
        ("M-0"       . treemacs-select-window)
        ("C-x t 1"   . treemacs-delete-other-windows)
        ("C-x t t"   . treemacs)
        ("C-x t d"   . treemacs-select-directory)
        ("C-x t B"   . treemacs-bookmark)
        ("C-x t C-t" . treemacs-find-file)
        ("C-x t M-t" . treemacs-find-tag)))

(use-package treemacs-evil
  :after (treemacs evil)
  :ensure t)

(use-package treemacs-projectile
  :after (treemacs projectile)
  :ensure t)

;(use-package treemacs-icons-dired
;  :hook (dired-mode . treemacs-icons-dired-enable-once)
;  :ensure t)

;  :after (treemacs magit)

(use-package treemacs-persp ;;treemacs-perspective if you use perspective.el vs. persp-mode
  :after (treemacs persp-mode) ;;or perspective vs. persp-mode
  :ensure t
  :config (treemacs-set-scope-type 'Perspectives))

(use-package treemacs-tab-bar ;;treemacs-tab-bar if you use tab-bar-mode
  :after (treemacs)
  :ensure t
  :config (treemacs-set-scope-type 'Tabs))

;;set transparent effect
(global-set-key [(f2)] 'loop-alpha)
(setq alpha-list '((100 100) (95 65) (85 55) (75 45) (65 35)))
(defun loop-alpha ()
  (interactive)
  (let ((h (car alpha-list)))                ;; head value will set to
    ((lambda (a ab)
       (set-frame-parameter (selected-frame) 'alpha (list a ab))
       (add-to-list 'default-frame-alist (cons 'alpha (list a ab)))
       ) (car h) (car (cdr h)))
    (setq alpha-list (cdr (append alpha-list (list h))))
    )
)

(use-package rainbow-mode
  :ensure t  ; 自动从 package archive 安装 rainbow-mode 如果它还没有被安装
  :hook      ; 配置钩子，使得 rainbow-mode 在特定的模式下自动启用
  (prog-mode . rainbow-mode) ; 在所有编程模式下启用 rainbow-mode
  :config    ; 配置区域
  ;; 这里可以放置任何你想要的额外配置
  )

(defface org-bold
    '((t :foreground "#fefefe"
       :background "red"
       :weight bold
       :underline (:color "red" :style line :position 9)
       :overline nil))
    "Face for org-mode bold."
    :group 'org-faces )

  (setq org-emphasis-alist
        '(("*" org-bold)
          ("/" italic)
          ("_" underline)
          ("=" ;; (:background "maroon" :foreground "black")
           org-verbatim verbatim)
          ("~" ;; (:background "deep sky blue" :foreground "MidnightBlue")
           org-code verbatim)
          ("+" (:strike-through t))))

  ;; Because spacemacs had different ideas about the verbatim background
  ;; (set-face-background 'org-bold "#red")
  ;; (set-face-background 'org-verbatim "#red")



(provide 'init-ui)

