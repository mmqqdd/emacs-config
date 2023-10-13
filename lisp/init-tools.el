;;;###autoload
(defun my/search-project-for-symbol-at-point ()
  (interactive)
  (if (use-region-p)
      (progn
	(evil-exit-visual-state)
	(consult-ripgrep (project-root (project-current))
			 (buffer-substring (region-beginning) (region-end))))
    (consult-ripgrep)))
;;;###autoload
(defun my/search-for-symbol-at-point ()
  (interactive)
  (if (use-region-p)
      (progn
	(evil-exit-visual-state)
	(consult-line (buffer-substring (region-beginning) (region-end))))
    (consult-line)))

;; 在visual 模式下，根据选中内容，在 minibuffer自动生成代码
(defun zilongshanren/evil-quick-replace (beg end )
  (interactive "r")
  (when (evil-visual-state-p)
    (evil-exit-visual-state)
    (let ((selection (regexp-quote (buffer-substring-no-properties beg end))))
      (setq command-string (format "%%s /%s//g" selection))
      (minibuffer-with-setup-hook
	  (lambda () (backward-char 2))
	(evil-ex command-string)))))

(eval-after-load 'evil
  '(define-key evil-visual-state-map (kbd "C-r") 'zilongshanren/evil-quick-replace))  


(use-package symbol-overlay
  :config
  (define-key symbol-overlay-map (kbd "h") 'nil))

(use-package highlight-global
  :ensure nil
  :commands (highlight-frame-toggle)
  :quelpa (highlight-global :fetcher github :repo "glen-dai/highlight-global")
  :config
  (progn
    (setq-default highlight-faces
		  '(('hi-red-b . 0)
		    ('hi-aquamarine . 0)
		    ('hi-pink . 0)
		    ('hi-blue-b . 0)))))

;; do what i mean
(defun zilongshanren/highlight-dwim ()
  (interactive)
  (if (use-region-p)
      (progn
	(highlight-frame-toggle)
	(deactivate-mark))
    (symbol-overlay-put)))

(defun zilongshanren/clearn-highlight ()
  (interactive)
  (clear-highlight-frame)
  (symbol-overlay-remove-all))








(provide 'init-tools)

