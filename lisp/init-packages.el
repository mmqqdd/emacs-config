(require 'package)
;;(setq package-archives '(("melpa" . "http://elpa.zilongshanren.com/melpa/")))
;;(add-to-list 'package-archives '("gnu" . "https://elpa.gnu.org/packages/") t)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)

;;防止反复调用 package-refresh-contents 会影响加载速度
(when (not package-archive-contents)
  (package-refresh-contents))

(unless (package-installed-p 'use-package)
	(package-refresh-contents)
	(package-install 'use-package))

(require 'use-package-ensure)
(setq use-package-always-ensure t)

(use-package restart-emacs
  :ensure t)



(provide 'init-packages)
