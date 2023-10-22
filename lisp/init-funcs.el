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

(defun my/open-eshell-at-bottom ()
  (interactive)
  (let* (
         ;; 获取当前目录名称作为项目名称，如果没有打开的文件，则使用 "default"
         (project-name (if buffer-file-name
                           (file-name-nondirectory
                            (directory-file-name
                             (file-name-directory buffer-file-name)))
                         "default"))
         ;; 根据项目名称创建或获取 eshell buffer
         (eshell-buffer (get-buffer-create (concat "*eshell-" project-name "*")))
         ;; 计算新窗口的高度为 frame 高度的 40%
         (window-height (round (* (frame-height) 0.4)))
         ;; 在 frame 的底部创建一个新窗口
         (target-window (split-window (frame-root-window) (- window-height) 'below)))
    ;; 选择新创建的窗口
    (select-window target-window)
    ;; 在新窗口中显示对应项目的 eshell buffer
    (set-window-buffer target-window eshell-buffer)
    ;; 切换到新创建的 buffer
    (switch-to-buffer eshell-buffer)
    ;; evil 进入插入模式
    (when (bound-and-true-p evil-mode)
      (evil-insert-state)
      (end-of-line))
    ;; 如果 eshell 未启动，则启动 eshell
    (unless (eq major-mode 'eshell-mode)
      (eshell-mode))))

(goto-char (point-at-bol))

;; let 语句用于设置一个临时的环境，在这个环境中 inhibit-read-only 被设置为 t 以允许修改只读的 buffer（eshell buffer 通常是只读的）。
;; erase-buffer 函数用于清空当前 buffer 的所有内容。
;; eshell-send-input 用于在清空 buffer 后发送一个新的 prompt。
(defun my/eshell-clear-buffer ()
  "Clear the current eshell buffer."
  (interactive)
  (let ((inhibit-read-only t))
    (erase-buffer)
    (eshell-send-input)))

(add-hook 'eshell-mode-hook
          (lambda ()
            (local-set-key (kbd "C-l") 'my/eshell-clear-buffer)))

(add-hook 'chatgpt-shell-mode-hook
          (lambda ()
            (local-set-key (kbd "C-l") 'my/eshell-clear-buffer)))

(defun eshell-exit ()
  "Override the `eshell-life-is-too-much' to close the window when `exit' is called."
  (ignore-errors
    (kill-buffer)
    (delete-window)))
(advice-add 'eshell-life-is-too-much :override #'eshell-exit)

(defun my/org-agenda-list ()
  (interactive)
  ;; 判断是否有多个窗口
  (if (> (length (window-list)) 1)
      ;; 如果有多个窗口
      (progn
        ;; 判断当前窗口是否在左侧
        (if (< (+ (window-pixel-left) (window-pixel-width))(- (frame-pixel-width) 10))
            (other-window 1)  ; 切换到右侧窗口
          nil)) ; 在当前窗口中打开
    ;; 如果只有一个窗口
    (split-window-right) ; 在右侧新建窗口
    (other-window 1)) ; 切换到新建的窗口
  (org-agenda-list)) ; 打开Agenda视图

(defun my/org-entries-to-mac-calendar ()
  (interactive)
  (let ((entries '())
        (script-file "/tmp/org-to-calendar.applescript"))
    (org-map-entries
     (lambda ()
       (let* ((heading (org-get-heading t t t t))
              (tags (org-get-tags))
              (scheduled (org-entry-get nil "SCHEDULED"))
              (timestamp (when scheduled
                           (org-parse-time-string scheduled))))
         (when timestamp
           (push (list (apply 'encode-time (org-parse-time-string scheduled))
                       heading
                       tags)
                 entries))))
     nil nil) ; 仅扫描当前 org 文件
    (with-temp-file script-file
      (dolist (entry entries)
        (let* ((time (car entry))
               (title (replace-regexp-in-string "\\* \\|TODO\\|DONE" "" (nth 1 entry)))
               (tags (mapconcat 'identity (nth 2 entry) ", "))
               (year (string-to-number (format-time-string "%Y" time)))
               (month (string-to-number (format-time-string "%m" time)))
               (day (string-to-number (format-time-string "%d" time)))
               (hour (string-to-number (format-time-string "%H" time)))
               (minute (string-to-number (format-time-string "%M" time)))
               (applescript-code (format "
tell application \"Calendar\"
    tell calendar \"My Calendar\"
        set myevent to make new event with properties {summary:\"%s\", start date:date \"%d-%02d-%02d %02d:%02d:00\", end date:date \"%d-%02d-%02d %02d:%02d:00\", description:\"Tags: %s\"}
    end tell
end tell"
                                         title
                                         year month day hour minute
                                         year month day (if (= hour 23) 0 (1+ hour)) (if (= hour 23) minute minute)
                                         tags)))
          (insert applescript-code "\n"))))
    (shell-command (format "osascript %s" script-file))))

(setq my-calendar-name "笔试面试")
(defun my/org-current-entry-to-mac-calendar ()
  (interactive)
  (let ((calendar-name my-calendar-name)  ;; 将日历名称设置为变量
        (script-file "/tmp/org-to-calendar.applescript"))
    (save-excursion
      (org-back-to-heading t)
      (let* ((heading (org-get-heading t t t t))
             (tags (org-get-tags))
             (scheduled (org-entry-get nil "SCHEDULED"))
             (timestamp (when scheduled
                          (org-parse-time-string scheduled))))
        (if timestamp
            (progn
              (with-temp-file script-file
                (let* ((time (apply 'encode-time timestamp))
                       (title (replace-regexp-in-string "\\* \\|TODO\\|DONE" "" heading))
                       (tags (mapconcat 'identity tags ", "))
                       (year (string-to-number (format-time-string "%Y" time)))
                       (month (string-to-number (format-time-string "%m" time)))
                       (day (string-to-number (format-time-string "%d" time)))
                       (hour (string-to-number (format-time-string "%H" time)))
                       (minute (string-to-number (format-time-string "%M" time)))
                       (applescript-code (format "
tell application \"Calendar\"
    tell calendar \"%s\"
        set myevent to make new event with properties {summary:\"%s\", start date:date \"%d-%02d-%02d %02d:%02d:00\", end date:date \"%d-%02d-%02d %02d:%02d:00\", description:\"Tags: %s\"}
    end tell
end tell"
                                                 calendar-name  ;; 使用变量
                                                 title
                                                 year month day hour minute
                                                 year month day (if (= hour 23) 0 (1+ hour)) (if (= hour 23) minute minute)
                                                 tags)))
                  (insert applescript-code "\n")))
              (shell-command (format "osascript %s" script-file))
              (message "Event added to calendar."))
          (message "The current line does not have a scheduled timestamp or is not a heading."))))))


(defun mqd/agenda-schedule-today ()
  "Schedule the current TODO to today."
  (interactive)
  (let ((today (format-time-string "%Y-%m-%d")))
    (org-agenda-schedule nil today)))


(provide 'init-funcs)
