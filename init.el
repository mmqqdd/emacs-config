 ;; -*- lexical-binding: t -*-(add-to-list 'load-path "~/.emacs.d/lisp/")(require 'init-basic)(require 'init-packages)(require 'init-funcs)(require 'init-ui)(require 'init-completion)(require 'init-tools)(require 'init-keybindings)(require 'init-org)(setq custom-file (expand-file-name "~/.emacs.d/custom.el"))(load custom-file 'nxo-error 'no-message)