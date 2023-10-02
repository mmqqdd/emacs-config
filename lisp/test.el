
(defmacro inc (var)
  (list 'setq var (list '1+ var)))


(setq my-var 0)
(inc my-var)

(macroexpand '(inc my-var))


;; ' ` quote

`(a list of (+ 1 2) elements)

`(a list of ,(+ 1 2) elements)

(setq some-list '(2 3))

`(1 ,@some-list, 4 ,some-list)



(progn
  (use-package-ensure-elpa 'restart-emacs
			   '(t)
			   'nil)
  (defvar use-package--warning31
    #'(lambda
	(keyword err)
	(let
	    ((msg
	      (format "%s/%s: %s" 'restart-emacs keyword
		      (error-message-string err))))
	  (display-warning 'use-package msg :error))))
  (condition-case-unless-debug err
      (if
	  (not
	   (require 'restart-emacs nil t))
	  (display-warning 'use-package
			   (format "Cannot load %s" 'restart-emacs)
			   :error))
    (error
     (funcall use-package--warning31 :catch err))))

(progn
  (use-package-ensure-elpa 'restart-emacs
			   '(t)
			   'nil)
  (defvar use-package--warning32
    #'(lambda
	(keyword err)
	(let
	    ((msg
	      (format \"%s/%s: %s\" 'restart-emacs keyword
		      (error-message-string err))))
	  (display-warning 'use-package msg :error))))
  (condition-case-unless-debug err
      (if
	  (not
	   (require 'restart-emacs nil t))
	  (display-warning 'use-package
			   (format \"Cannot load %s\" 'restart-emacs)
			   :error))
    (error
     (funcall use-package--warning32 :catch err))))
