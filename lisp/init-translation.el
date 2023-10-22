(use-package google-translate
  :bind
  ("C-c u" . 'google-translate-at-point) 
  ("C-c U" . 'google-translate-at-point-reverse) 
  :config
(setq google-translate-default-source-language "en")
(setq google-translate-default-target-language "zh-CN"))


(with-eval-after-load 'google-translate
  (define-key evil-visual-state-map (kbd "t") 'google-translate-at-point)
  (define-key evil-visual-state-map (kbd "T") 'google-translate-at-point-reverse))



(provide 'init-translation)
