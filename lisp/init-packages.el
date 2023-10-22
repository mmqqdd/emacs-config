(require 'package)
;; (setq package-archives '(("melpa" . "http://elpa.zilongshanren.com/melpa/")))
;; (setq package-archives '(("gnu" . "https://elpa.gnu.org/packages/")))
;; (add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)

(setq package-archives '(("gnu"   . "http://mirrors.tuna.tsinghua.edu.cn/elpa/gnu/")
                         ("melpa" . "http://mirrors.tuna.tsinghua.edu.cn/elpa/melpa/")))
(package-initialize)

;;防止反复调用 package-refresh-contents 会影响加载速度
(when (not package-archive-contents)
  (package-refresh-contents))

(unless (package-installed-p 'use-package)
	(package-refresh-contents)
	(package-install 'use-package))

(require 'use-package-ensure)

(setq use-package-always-ensure t)
(setq use-package-always-defer t)

(use-package restart-emacs
  :ensure t)

(use-package quelpa)

(unless (package-installed-p 'quelpa-use-package)
  (quelpa
   '(quelpa-use-package
     :fetcher git
     :url "https://github.com/quelpa/quelpa-use-package.git")))

(use-package quelpa-use-package
  :init
  (setq quelpa-use-package-inhibit-loading-quelpa t)
  :demand t)

(use-package benchmark-init
  :ensure t
  :demand t
  :config
  (add-hook 'after-init-hook 'benchmark-init/deactivate))

(provide 'init-packages)
