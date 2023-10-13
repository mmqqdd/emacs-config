(require 'org-tempo) ;开启easy template

;; <取消自动补全 
(add-hook 'org-mode-hook
	  (lambda ()
	    (setq-local electric-pair-inhibit-predicate
			`(lambda (c)
			   (if (char-equal c ?\<) t
			     (,electric-pair-inhibit-predicate c))))))


(setq org-todo-keywords
      (quote ((sequence "TODO(t)" "STARTED(s)" "|" "DONE(d!/!)")
	      (sequence "WAITING(w@/!)" "SOMEDAY(S)" "|" "CANCELLED(c@/!)" "MEETING(m)" "PHONE(p)"))))


(use-package org-contrib)
(require 'org-checklist)

;; 完成任务，日志记录在 LOGBOOK 中
(setq org-log-done t)
(setq org-log-into-drawer t)

;; M-x org-set-properties , 设置属性， RESET_CHECK_BOXES: t 可以重置 check boxes 

(global-set-key (kbd "C-c a") 'org-agenda)
(setq org-agenda-files '("~/workspace/gtd/diary.org" "~/workspace/gtd/brainstorming.org"))



(setq org-capture-templates
      '(("t" "Todo" entry (file+headline "~/workspace/gtd/diary.org" "TodoList")
	 "* TODO [#B] %?\n  %i\n %U"
	 :empty-lines 1)
	("b" "BrainStorming" entry (file+headline "~/workspace/gtd/brainstorming.org" "Idea")
	 "* TODO [#B] %?\n  %i\n %U"
	 :empty-lines 1)
	))

(global-set-key (kbd "C-c r") 'org-capture)

(setq org-agenda-custom-commands
      '(("c" "重要且紧急的事"
	 ((tags-todo "+PRIORITY=\"A\"")))
	;; ...other commands here
	))

(use-package ox-hugo
  :ensure t   ;Auto-install the package from Melpa
  :pin melpa  ;`package-archives' should already have ("melpa" . "https://melpa.org/packages/")
  :after ox)

(with-eval-after-load 'org-capture
  (defun org-hugo-new-subtree-post-capture-template ()
    "Returns `org-capture' template string for new Hugo post.
See `org-capture-templates' for more information."
    (let* ((title (read-from-minibuffer "Post Title: ")) ;Prompt to enter the post title
	   (fname (org-hugo-slug title)))
      (mapconcat #'identity
		 `(
		   ,(concat "* TODO " title)
		   ":PROPERTIES:"
		   ,(concat ":EXPORT_FILE_NAME: " fname)
		   ":END:"
		   "\n\n")          ;Place the cursor here finally
		 "\n")))

  (add-to-list 'org-capture-templates
	       '("h"                ;`org-capture' binding + h
		 "Hugo post"
		 entr
		 ;; It is assumed that below file is present in `org-directory'
		 ;; and that it has a "Blog Ideas" heading. It can even be a
		 ;; symlink pointing to the actual location of all-posts.org!
		 (file+headline "/Users/mengqiangding/study/blog/all-blog.org" "Blog Ideas")
			    (function org-hugo-new-subtree-post-capture-template))))

(eval-after-load 'evil
  '(progn
     (evil-define-key 'normal org-mode-map (kbd "<tab>") 'org-cycle)
     (evil-define-key 'normal org-mode-map (kbd "<RET>") 'org-open-at-point)))

(setq org-startup-indented t)

(provide 'init-org)
