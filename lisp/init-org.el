(require 'org-tempo) ;开启easy template

;; <取消自动补全 
(add-hook 'org-mode-hook
	  (lambda ()
	    (setq-local electric-pair-inhibit-predicate
			`(lambda (c)
			   (if (char-equal c ?\<) t
			     (,electric-pair-inhibit-predicate c))))))


(setq org-todo-keywords
      (quote ((sequence "TODO(t)" "DOING(s)" "|" "DONE(d!/!)")
	      (sequence "WAITING(w@/!)" "SOMEDAY(S)" "|" "CANCELLED(c@/!)" "MEETING(m)" "PHONE(p)"))))


(use-package org-contrib)
(require 'org-checklist)

;; 完成任务，日志记录在 LOGBOOK 中
(setq org-log-done t)
(setq org-log-into-drawer t)

;; M-x org-set-properties , 设置属性， RESET_CHECK_BOXES: t 可以重置 check boxes 

(global-set-key (kbd "C-c a") 'org-agenda)
(setq org-agenda-files '("~/workspace/gtd/findwork.org" "~/workspace/gtd/diary.org" "~/workspace/gtd/brainstorming.org"))

;; 使用 org-agenda-log-mode 还可以配合 org-agenda-log-mode-items 这个变量，
;; 我这默认值是 '(closed clock)，意思是会显示完成任务是在什么时候完成的，
;; 以及任务从什么时候开始计时并结束计时的，还有一个可选的值是 state，
;; 加上的话会显示任务在什么时候状态发生了变化（比如从 TODO 变化为 DOING)
(setq org-agenda-log-mode-items '(clock))
(setq org-agenda-log-mode-add-notes nil)
(setq org-agenda-span 'day)

(setq org-agenda-window-setup 'current-window)



;; (add-to-list 'display-buffer-alist
;;              '("\\*Agenda\\*"
;;                (display-buffer-reuse-window display-buffer-at-bottom)
;;                (reusable-frames . visible)
;;                (side . right)
;;                (window-height . 0.4)))

;; DOCT: Declarative Org Capture Templates
(use-package doct
  :ensure t
  ;;recommended: defer until calling doct
  :defer
  :commands (doct))

(setq org-capture-templates
      '(("i" "Little" entry (file+headline "~/workspace/gtd/diary.org" "LitteThings")
	 "* TODO [#C] %?\n  %i\n %U"
	 :empty-lines 1)
	("l" "LongTerm" entry (file+headline "~/workspace/gtd/diary.org" "LongTerm")
	 "* SOMEDAY [#C] %?\n  %i\n %U"
	 :empty-lines 1)
	("t" "Todo" entry (file+headline "~/workspace/gtd/diary.org" "TodoList")
	 "* TODO [#C] %?\n  %i\n %U"
	 :empty-lines 1)
	("n" "NOW" entry (file+headline "~/workspace/gtd/diary.org" "Littethings")
	 "* DOING %?\n%T" :clock-in t :clock-keep t
	 :empty-lines 1)
	("b" "BrainStorming" entry (file+headline "~/workspace/gtd/brainstorming.org" "Idea")
	 "* TODO [#C] %?\n  %i\n %U"
	 :empty-lines 1)
	))
(setq org-agenda-prefix-format
      '((agenda . " %i %-12:c%?-12t% s")
        (todo . " %i %-12:c")
        (tags . " %i %-12:c")
        (search . " %i %-12:c")))

(defun my/org-agenda-done()
  ;; 1. 退出clock 2. 状态标记为DONE
  (interactive)
  (progn
     (org-agenda-clock-out)
     (org-agenda-todo "DONE")))

(defun my/org-agenda-time-grid-spacing ()
  "Set different line spacing w.r.t. time duration."
  (save-excursion
    (let* ((background (alist-get 'background-mode (frame-parameters)))
           (background-dark-p (string= background "dark"))
           (colors (if background-dark-p
                       (list "#aa557f" "DarkGreen" "DarkSlateGray" "DarkSlateBlue")
                     (list "#F6B1C3" "#FFFF9D" "#BEEB9F" "#ADD5F7")))
           pos
           duration)
      (nconc colors colors)
      (goto-char (point-min))
      (while (setq pos (next-single-property-change (point) 'duration))
        (goto-char pos)
        (when (and (not (equal pos (point-at-eol)))
                   (setq duration (org-get-at-bol 'duration)))
          (let ((line-height (if (< duration 30) 1.0 (+ 0.5 (/ duration 60))))
                (ov (make-overlay (point-at-bol) (1+ (point-at-eol)))))
            (overlay-put ov 'face `(:background ,(car colors)
                                                :foreground
                                                ,(if background-dark-p "black" "white")))
            (setq colors (cdr colors))
            (overlay-put ov 'line-height line-height)
            (overlay-put ov 'line-spacing (1- line-height))))))))

(add-hook 'org-agenda-finalize-hook #'my/org-agenda-time-grid-spacing)
;; (setq org-capture-templates
;;       (doct '(("Parent" :keys "p"
;;                :file "~/example.org"
;;                :prepend t
;;                :template ("* %{todo-state} %^{Description}"
;;                           ":PROPERTIES:"
;;                           ":Created: %U"
;;                           ":END:"
;;                           "%?")
;;                :children (("First Child"  :keys "1"
;;                            :headline   "One"
;;                            :todo-state "TODO"
;;                            :hook (lambda () (message "\"First Child\" selected.")))
;;                           ("Second Child" :keys "2"
;;                            :headline   "Two"
;;                            :todo-state "NEXT")
;;                           ("Third Child"  :keys "3"
;;                            :headline   "Three"
;;                            :todo-state "MAYBE"))))))
;; (setq org-capture-templates
;;       (doct '(("Work" :keys "w" :file "~/org/work.org" :children
;;          ((:group "Clocked" :clock-in t :children
;;                   (("Phone Call" :keys "p" :template "* Phone call with %?")
;;                    ("Meeting"    :keys "m" :template "* Meeting with %?")))
;;           ("Browsing" :keys "b" :template "* Browsing %x"))))))

(global-set-key (kbd "C-c r") 'org-capture)

(setq org-agenda-custom-commands
      '(("c" "重要且紧急的事"
	 ((tags-todo "+PRIORITY=\"A\"")))
	("d" "Priority A and B tasks"
         ((tags-todo "+PRIORITY=\"A\"|+PRIORITY=\"B\"")))
	;; ...other commands here
	))

(add-to-list 'org-agenda-custom-commands
	     '("r" "Daily Agenda Review"
               ((agenda "" ((org-agenda-overriding-header "今日记录")
                            (org-agenda-span 'day)
                            (org-agenda-show-log 'clockcheck)
                            (org-agenda-start-with-log-mode nil)
                            (org-agenda-log-mode-items '(closed clock))
                            (org-agenda-clockreport-mode t)
                            )))
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
     (evil-define-key 'normal org-mode-map (kbd "<tab>") 'org-cycle)))
;;(evil-define-key 'normal org-mode-map (kbd "<RET>") 'org-open-at-point)))

(add-hook 'org-agenda-mode-hook
          (lambda ()
            (define-key org-agenda-mode-map "j" 'org-agenda-next-line)
            (define-key org-agenda-mode-map "k" 'org-agenda-previous-line)
            (define-key org-agenda-mode-map "o" 'my/org-agenda-done)
            (define-key org-agenda-mode-map "h" 'evil-window-left)
	    (define-key org-agenda-mode-map "a" 'mqd/agenda-schedule-today)
	    ))


;; 链接按回车可以打开链接
(setq org-return-follows-link t)

(setq org-startup-indented t)

(use-package org-download
  :ensure t
  :demand t
  :after org
  :init
  :config
  (add-hook 'dired-mode-hook 'org-download-enable)
  (setq-default org-download-heading-lvl nil
		org-download-image-dir "./pictures"
		org-download-screenshot-method "screencapture -i %s" ;;macos
		org-download-screenshot-file (expand-file-name "screenshot.jpg" temporary-file-directory)))

;; (use-package org-download
;;     :ensure t
;;     :demand t
;;     :after org
;;     :config
;;     (add-hook 'dired-mode-hook 'org-download-enable)
;;     (defun org-download-annotate-default (link)
;;       "Annotate LINK with the time of download."
;;       (make-string 0 ?\s)

;;     (setq-default org-download-heading-lvl nil
;; 		  org-download-image-dir "./img"
;; 		  ;; org-download-screenshot-method "screencapture -i %s"

;; diary in org-agenda-view 
(setq org-agenda-include-diary t) 
(setq org-agenda-diary-file "~/Documents/OrgMode/ORG/Master/standard-diary") 
(setq diary-file "~/Documents/OrgMode/ORG/Master/standard-diary") 
;; 		  org-downlo# Coordinates 
(setq calendar-longitude +116.4) ;;long是经度, 东经 
(setq calendar-latitude +39.9) ;;lat, flat, 


;;Sunrise and Sunset 
;;日出而作 
(defun diary-sunrise () 
  (let ((dss (diary-sunrise-sunset))) 
    (with-temp-buffer 
      (insert dss) 
      (goto-char (point-min)) 
      (while (re-search-forward " ([^)]*)" nil t) 
    (replace-match "" nil nil)) 
      (goto-char (point-min)) 
      (search-forward ",") 
      (buffer-substring (point-min) (match-beginning 0))))) 
 
;; sunset 日落而息 
(defun diary-sunset () 
  (let ((dss (diary-sunrise-sunset)) 
        start end) 
    (with-temp-buffer 
      (insert dss) 
      (goto-char (point-min)) 
      (while (re-search-forward " ([^)]*)" nil t) 
        (replace-match "" nil nil)) 
      (goto-char (point-min)) 
      (search-forward ", ") 
      (setq start (match-end 0)) 
      (search-forward " at") 
      (setq end (match-beginning 0)) 
      (goto-char start) 
      (capitalize-word 1) 
      (buffer-substring start end))))
;; 中文的天干地支 
(setq calendar-chinese-celestial-stem ["甲" "乙" "丙" "丁" "戊" "己" "庚" "辛" "壬" "癸"]) 
(setq calendar-chinese-terrestrial-branch ["子" "丑" "寅" "卯" "辰" "巳" "午" "未" "申" "酉" "戌" "亥"]) 

;;设置一周从周一开始. 
(setq calendar-week-start-day 1) 

(require 'cal-china-x)
;;中美的节日. 
(setq mark-holidays-in-calendar t) 
(setq cal-china-x-important-holidays cal-china-x-chinese-holidays) 

(setq calendar-holidays 
      (append cal-china-x-important-holidays 
              cal-china-x-general-holidays 
              holiday-general-holidays 
              holiday-christian-holidays 
              ))

;; display Chinese date 
(setq org-agenda-format-date 'zeroemacs/org-agenda-format-date-aligned) 
 
(defun zeroemacs/org-agenda-format-date-aligned (date) 
  "Format a DATE string for display in the daily/weekly agenda, or timeline. 
      This function makes sure that dates are aligned for easy reading." 
  (require 'cal-iso) 
  (let* ((dayname (aref cal-china-x-days 
                        (calendar-day-of-week date))) 
         (day (cadr date)) 
         (month (car date)) 
         (year (nth 2 date)) 
         (cn-date (calendar-chinese-from-absolute (calendar-absolute-from-gregorian date))) 
         (cn-month (cl-caddr cn-date)) 
         (cn-day (cl-cadddr cn-date)) 
         (cn-month-string (concat (aref cal-china-x-month-name 
                                        (1- (floor cn-month))) 
                                  (if (integerp cn-month) 
                                      "" 
                                    "(闰月)"))) 
         (cn-day-string (aref cal-china-x-day-name 
                              (1- cn-day)))) 
    (format "%04d-%02d-%02d 周%s %s%s" year month 
            day dayname cn-month-string cn-day-string))) 

(use-package markdown-mode
  :ensure t
  :mode ("README\\.md\\'" . gfm-mode)
  :init (setq markdown-command "multimarkdown")
  :bind (:map markdown-mode-map
         ("C-c C-e" . markdown-do)))

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

  ;; 完成任务时, 将其划线勾掉
  (set-face-attribute 'org-headline-done nil :strike-through t)

(defun mqd/agenda-schedule-today ()
  "Schedule the current TODO to today."
  (interactive)
  (let ((today (format-time-string "%Y-%m-%d")))
    (org-agenda-schedule nil today)))

(with-eval-after-load 'org-agenda
  (define-key org-agenda-mode-map (kbd "a") 'agenda-schedule-today))


(provide 'init-org)

