(defun awesome-tab-buffer-groups ()
  "`awesome-tab-buffer-groups' control buffers' group rules.
Group awesome-tab with mode if buffer is derived from `eshell-mode' `emacs-lisp-mode' `dired-mode' `org-mode' `magit-mode'.
All buffer name start with * will group to \"Emacs\".
Other buffer group by `awesome-tab-get-group-name' with project name."
  (list
   (cond
    ((or (string-equal "*" (substring (buffer-name) 0 1))
	 (memq major-mode '(magit-process-mode
			    magit-status-mode
			    magit-diff-mode
			    magit-log-mode
			    magit-file-mode
			    magit-blob-mode
			    magit-blame-mode)))
     "Emacs")
    ((derived-mode-p 'eshell-mode)
     "EShell")
    ((derived-mode-p 'dired-mode)
     "Dired")
    ((memq major-mode '(org-mode org-agenda-mode diary-mode))
     "OrgMode")
    ((derived-mode-p 'eaf-mode)
     "EAF")
    (t
     (awesome-tab-get-group-name (current-buffer))))))


;;;###autoload
(defun my/search-project-for-symbol-at-point ()
  (interactive)
  (if (use-region-p)
      (progn
	(consult-ripgrep (project-root (project-current))
			 (buffer-substring (region-beginning) (region-end))))
    (consult-ripgrep)))
;;;###autoload
(defun my/search-for-symbol-at-point ()
  (interactive)
  (if (use-region-p)
      (consult-line (buffer-substring (region-beginning) (region-end)))
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


(require 'eglot)
(add-to-list 'eglot-server-programs '((c++-mode c-mode) "ccls"))
(add-hook 'c-mode-hook #'eglot-ensure)
(add-hook 'c++-mode-hook #'eglot-ensure)

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






(provide 'init-tools)

