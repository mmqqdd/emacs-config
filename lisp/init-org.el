(require 'org-tempo) ;开启easy template
(add-hook 'org-mode-hook
	  (lambda ()
	    (setq-local electric-pair-inhibit-predicate
			`(lambda (c)
			   (if (char-equal c ?\<) t
			     (,electric-pair-inhibit-predicate c))))))



(provide 'init-org)
