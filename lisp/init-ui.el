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


;; 更改显示字体大小 14pt
;; http://stackoverflow.com/questions/294664/how-to-set-the-font-size-in-emacs
(set-face-attribute 'default nil :height 140)

;;让鼠标滚动更好用
(setq mouse-wheel-scroll-amount '(1 ((shift) . 1) ((control) . nil)))
(setq mouse-wheel-progressive-speed nil)

(global-hl-line-mode 1)

(use-package doom-themes)
(load-theme 'doom-one 1)

(toggle-frame-maximized)

(add-to-list 'load-path (expand-file-name "~/.emacs.d/awesome-tab"))
(require 'awesome-tab)
(awesome-tab-mode t)


(use-package doom-modeline
  :init
  (doom-modeline-mode t))

(use-package simple-modeline
  :hook (after-init . size-indication-mode)
  :init
  (progn
    (setq column-number-mode t)
    ))


(provide 'init-ui)
