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


(use-package treesit-auto
  :demand t
  :config
  (setq treesit-auto-install 'prompt)
  (global-treesit-auto-mode))

(evil-define-key 'normal global-map (kbd "g r") 'xref-find-references)
(evil-define-key 'normal global-map (kbd "g d") 'xref-find-definitions)


;; (use-package yasnippet
;;   :ensure t
;;   :hook ((prog-mode . yas-minor-mode)
;; 	 (org-mode . yas-minor-mode))
;;   :init
;;   :config
;;   (progn
;;     (setq hippie-expand-try-functions-list
;; 	  '(yas/hippie-try-expand
;; 	    try-complete-file-name-partially
;; 	    try-expand-all-abbrevs
;; 	    try-expand-dabbrev
;; 	    try-expand-dabbrev-all-buffers
;; 	    try-expand-dabbrev-from-kill
;; 	    try-complete-lisp-symbol-partially
;; 	    try-complete-lisp-symbol))))

;; (use-package yasnippet-snippets
;;   :ensure t
;;   :after yasnippet)


(provide 'init-programming)
