;; 快速打开配置文件
(defun open-init-file()
  (interactive)
  (find-file "~/.emacs.d/init.el"))

;; TODO 
(defun embark-export-write ()
  "Export the current vertico results to a writable buffer if possible.
Supports exporting consult-grep to wgrep, file to wdeired, and consult-location to occur-edit"
  (interactive)
  (require 'embark)
  (require 'wgrep)
  (pcase-let ((`(,type . ,candidates)
               (run-hook-with-args-until-success 'embark-candidate-collectors)))
    (pcase type
      ('consult-grep (let ((embark-after-export-hook #'wgrep-change-to-wgrep-mode))
                       (embark-export)))
      ('file (let ((embark-after-export-hook #'wdired-change-to-wdired-mode))
               (embark-export)))
      ('consult-location (let ((embark-after-export-hook #'occur-edit-mode))
                           (embark-export)))
      (x (user-error "embark category %S doesn't support writable export" x)))))


;; 第六天
(defun consult-directory-externally (file)
  "Open FILE externally using the default application of the system."
  (interactive "fOpen externally: ")
  (if (and (eq system-type 'windows-nt)
	   (fboundp 'w32-shell-execute))
      (shell-command-to-string (encode-coding-string (replace-regexp-in-string "/" "\\\\"
									       (format "explorer.exe %s" (file-name-directory (expand-file-name file)))) 'gbk))
    (call-process (pcase system-type
		    ('darwin "open")
		    ('cygwin "cygstart")
		    (_ "xdg-open"))
		  nil 0 nil
		  (file-name-directory (expand-file-name file)))))


(defun my-open-current-directory()
  ;;open current directory
  (interactive)
  (consult-directory-externally default-directory))

(defun my/copy-current-buffer-file-path ()
  "Copy the full path of the file associated with the current buffer to the clipboard."
  (interactive)
  (if (buffer-file-name)
      (let ((path (file-truename (buffer-file-name))))
        (progn
          (kill-new path)
          (message (format "File path copied to clipboard: %s" path))))
    (error "Buffer is not visiting a file.")))

(defun my/copy-current-directory-to-clipboard ()
  "Copy the current directory to the clipboard."
  (interactive)
  (let ((current-directory default-directory))
    (with-temp-buffer
      (insert current-directory)
      (clipboard-kill-region (point-min) (point-max)))
    (message "Current directory copied to clipboard: %s" current-directory)))


(provide 'init-funcs)
