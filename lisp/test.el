
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

(defun greet()
    (interactive)
    (message "hello"))

(defadvice greet
    (around arount-greet activate)
  ad-do-it
  (setq ad-return-value (concat ad-return-value "++++++++")))

(setq my-list (cl-loop for i from 1 to 10 if (= (% i 2) 0) collect i))

(setq days [0 19 20 23 34])
(aref days 5)
;; 登录充值
;; 广告投放
;; 20+ 人 ，后端 10+人，
(defun solar-to-lunar (year month day)
  "将阳历日期转换为农历日期。"
  (interactive "nYear: \nnMonth: \nnDay: ")
  (let* ((year-data (solar-year-data year))
         (leap-month (cadr year-data))
         (days-in-months (caddr year-data))
         (lunar-month 1)
         (lunar-day day)
         (i 0))
    (while (< i month)
      (setq lunar-day (+ lunar-day (nth i days-in-months)))
      (setq i (1+ i)))
    (setq lunar-month (1+ i))
    (if (and leap-month (> lunar-month leap-month))
        (setq lunar-month (1+ lunar-month)))
    (list year lunar-month lunar-day)))

(defun solar-year-data (year)
  "获取指定年份的农历数据。"
  (let* ((year-data lunar-calendar-data)
         (index (- year 1900)))
    (nth index year-data)))

(setq lunar-calendar-data
      [
       ;; 农历每年的闰月信息，0 表示没有闰月
       6 0 6 0 5 0 6 0 6 0 5 0 6 0 6 0 5 0 6 0
       6 0 5 0 6 0 6 0 5 0 6 0 6 0 5 0 6 0 6 0
       ;; 每年 12 个月的天数，0 表示 29 天，1 表示 30 天
       [1 0 1 1 0 1 1 0 1 1 0 1 1 0 1 1 0 1 1 0
        1 1 0 1 1 0 1 1 0 1 1 0 1 1 0 1 1 0 1 1
        0 1 1 0 1 1 0 1 1 0 1 1 0 1 1 0 1 1 0 1
        1 0 1 1 0 1 1 0 1 1 0 1 1 0 1 1 0 1 1 0
        1 1 0 1 1 0 1 1 0 1 1 0 1 1 0 1 1 0 1 1]
       ])

(let ((lunar (solar-to-lunar 2000 9 11)))
  (message "农历日期：%d年%d月%d日"
           (nth 0 lunar) (nth 1 lunar) (nth 2 lunar)))
(defun solar-to-lunar (year month day)
  "将阳历日期转换为农历日期。"
  (interactive "nYear: \nnMonth: \nnDay: ")
  (let* ((solar-date (encode-time 0 0 0 day month year))
         (lunar-date (calendar-chinese-from-absolute (calendar-absolute-from-gregorian (list month day year)))))
    (list (calendar-chinese-year lunar-date)
          (calendar-chinese-month lunar-date)
          (calendar-chinese-day lunar-date))))

(calendar-chinese-year (list 78 17 8 14))
(setq test-date (encode-time (list 0 0 0 11 9 2000)))
(type)

(calendar-absolute-from-gregorian (list 9 11 2000))
(let ((lunar (solar-to-lunar 2000 9 11)))
  (message "农历日期：%d年%d月%d日"
           (nth 0 lunar) (nth 1 lunar) (nth 2 lunar)))


(defun lunar-calendar (year month day)
  "Convert a Gregorian date (YEAR, MONTH, DAY) to a Lunar date."
  (require 'cal-china)
  (let ((lunar-date (calendar-chinese-from-gregorian (list month day year))))
    (message "阳历日期：%d年%d月%d日，农历日期：%s年%s月%s日"
             year month day
             (car lunar-date) (cadr lunar-date) (caddr lunar-date))))

;; 调用示例
(lunar-calendar 2023 10 8)


(package-install 'cal-china-x)

;; 加载 cal-china-x 库
(require 'cal-china-x)

(defun convert-to-lunar-date (year month day)
  "Convert Gregorian date (YEAR, MONTH, DAY) to Lunar date."
  (let ((lunar-date (cal-china-x-gregorian-to-chinese year month day)))
    (message "阳历日期：%d年%d月%d日，农历日期：%s" year month day lunar-date)))

;; 调用示例
(convert-to-lunar-date 2023 10 8)

(defun convert-to-lunar-date (year month day)
  "Convert Gregorian date (YEAR, MONTH, DAY) to Lunar date."
  (setq lunar-months
        ["正" "二" "三" "四" "五" "六" "七" "八" "九" "十" "冬" "腊"])
  (setq lunar-days
        ["初一" "初二" "初三" "初四" "初五" "初六" "初七" "初八" "初九" "初十"
         "十一" "十二" "十三" "十四" "十五" "十六" "十七" "十八" "十九" "廿十"
         "廿一" "廿二" "廿三" "廿四" "廿五" "廿六" "廿七" "廿八" "廿九" "三十"])
  (setq lunar-month-days
        [29 30 29 30 29 30 29 30 29 30 29 30])

  (setq is-leap-year
        (if (= (% year 4) 0)
            (if (= (% year 100) 0)
                (if (= (% year 400) 0)
                    t
                  nil)
              t)
          nil))

  (setq days-to-month
        (if (and is-leap-year (= month 2))
            (+ 31 day)
          (apply '+ (mapcar 'identity (butlast lunar-month-days (- month 1))))))

  (setq lunar-day (aref lunar-days (- day 1)))
  (setq lunar-month (aref lunar-months (if (= days-to-month 0) (- month 1) (% month days-to-month))))

  (message "阳历日期：%d年%d月%d日，农历日期：%s年%s" year month day lunar-month lunar-day))

;; 调用示例
(convert-to-lunar-date 2023 10 8)

(defun my/get-current-buffer-file-path ()
  "Return the full path of the file associated with the current buffer."
  (interactive)
  (if (buffer-file-name)
      (file-truename (buffer-file-name))
    (error "Buffer is not visiting a file.")))

(message (get-current-buffer-file-path))
(let ((line-height 40)
      (ov (make-overlay (point-at-bol) (point-at-eol))))
  (overlay-put ov 'face '(:background "yellow"))
  (overlay-put ov 'line-height line-height)
  (overlay-put ov 'line-spacing (1- line-height)))

(defun toggle-do-not-disturb ()
  "Toggle MacOS Do Not Disturb mode on/off."
  (interactive)
  (let ((script "set curSetting to do shell script \"defaults -currentHost read com.apple.notificationcenterui doNotDisturb\"
if curSetting = \"0\" then
	do shell script \"defaults -currentHost write com.apple.notificationcenterui doNotDisturb -boolean true\"
else
	do shell script \"defaults -currentHost write com.apple.notificationcenterui doNotDisturb -boolean false\"
end if

do shell script \"killall NotificationCenter\""))
    (shell-command (concat "osascript -e '" script "'"))))

(defun add-org-schedule-to-calendar ()
  (interactive)
  (save-excursion
    (goto-char (point-min))
    (while (re-search-forward "SCHEDULED: <\\(.*?\\)>" nil t)
      (let ((scheduled-time (match-string 1))
            (event-title (save-excursion 
                           (outline-previous-heading)
                           (thing-at-point 'line t))))
        (shell-command 
         (concat "osascript -e '"
                 "tell application \"Calendar\"' -e '"
                 "tell calendar \"mqd学习计划\"' -e '"
                 "make new event at end with properties {summary:\""
                 (replace-regexp-in-string "\"" "\\\\\"" (replace-regexp-in-string "\n" "" event-title))
                 "\", start date:date \"" scheduled-time 
                 "\", end date:date \"" scheduled-time "\"}' -e '"
                 "end tell' -e 'end tell'"))))))
(setq )
(defun add-org-schedule-to-calendar ()
  (interactive)
  (save-excursion
    (goto-char (point-min))
    (while (re-search-forward "SCHEDULED: <\\(.*?\\)>" nil t)
      (let ((scheduled-time (match-string 1))
            (event-title (save-excursion 
                           (outline-previous-heading)
                           (thing-at-point 'line t))))
        (setq event-title (replace-regexp-in-string "^[*]+[[:space:]]+" "" event-title))
        (setq event-title (replace-regexp-in-string "[[:space:]]*TODO[[:space:]]*" "" event-title))
        (setq event-title (replace-regexp-in-string "[[:space:]]*DONE[[:space:]]*" "" event-title))
        (setq event-title (replace-regexp-in-string "[\n\r]+" "" event-title))

        (let ((tags (save-excursion
                      (outline-previous-heading)
                      (when (looking-at org-complex-heading-regexp)
                        (match-string-no-properties 5)))))

          (shell-command 
           (concat "osascript -e '"
                   "tell application \"Calendar\"' -e '"
                   "tell calendar \"mqdtest\"' -e '"
                   "make new event at end with properties {summary:\""
                   (replace-regexp-in-string "\"" "\\\\\"" event-title)
                   "\", start date:date \"" scheduled-time 
                   "\", end date:date \"" scheduled-time 
                   "\", url:\"" (or tags "") "\"}' -e '"
                   "end tell' -e 'end tell'")))))))


(defun org-entries-to-mac-calendar ()
  (interactive)
  (let (entries)
    (org-map-entries
     (lambda ()
       (let* ((heading (org-get-heading t t t t))
              (tags (org-get-tags))
              (scheduled (org-entry-get nil "SCHEDULED"))
              (timestamp (when scheduled
                           (org-parse-time-string scheduled))))
         (when timestamp
           (push (list (decode-time (nth 5 timestamp))
                       heading
                       tags)
                 entries))))
     t 'agenda)
    (dolist (entry entries)
      (let ((time (car entry))
            (title (replace-regexp-in-string "\\* \\|TODO\\|DONE" "" (nth 1 entry)))
            (tags (nth 2 entry)))
        (do-applescript
         (format "
tell application \"Calendar\"
    tell calendar \"mqdtest\"
        make new event with properties {description:\"%s\", summary:\"%s\", start date:date \"%d-%d-%d %d:%d:%d\"}
    end tell
end tell"
                 (mapconcat 'identity tags ", ")
                 title
                 (nth 5 time) (nth 4 time) (nth 3 time)
                 (nth 2 time) (nth 1 time) (nth 0 time)))))))

(defun org-entries-to-mac-calendar ()
  (interactive)
  (let (entries)
    (org-map-entries
     (lambda ()
       (let* ((heading (org-get-heading t t t t))
              (tags (org-get-tags))
              (scheduled (org-entry-get nil "SCHEDULED"))
              (timestamp (when scheduled
                           (org-parse-time-string scheduled))))
         (when timestamp
           (push (list (decode-time (nth 5 timestamp))
                       heading
                       tags)
                 entries))))
     t 'agenda)
    (dolist (entry entries)
      (let ((time (car entry))
            (title (replace-regexp-in-string "\\* \\|TODO\\|DONE" "" (nth 1 entry)))
            (tags (nth 2 entry)))
        (do-applescript
         (format "
tell application \"Calendar\"
    tell calendar \"My Calendar\"
        set myevent to make new event with properties {summary:\"%s\", start date:date \"%d-%02d-%02d %02d:%02d:00\"}
        tell myevent
            make new attendee at end of attendees with properties {name:\"tags\", address:\"%s\"}
        end tell
    end tell
end tell"
                 title
                 (nth 5 time) (nth 4 time) (nth 3 time)
                 (nth 2 time) (nth 1 time)
                 (mapconcat 'identity tags ", ")))))))

(defun org-entries-to-mac-calendar ()
  (interactive)
  (let (entries)
    (org-map-entries
     (lambda ()
       (let* ((heading (org-get-heading t t t t))
              (tags (org-get-tags))
              (scheduled (org-entry-get nil "SCHEDULED"))
              (closed (org-entry-get nil "CLOSED"))
              (timestamp (when scheduled
                           (org-parse-time-string scheduled)))
              (end-time (when closed
                          (org-parse-time-string closed))))
         (when timestamp
           (push (list (decode-time (nth 5 timestamp))
                       (decode-time (nth 5 end-time))
                       heading
                       tags)
                 entries))))
     t 'agenda)
    (dolist (entry entries)
      (let* ((start-time (car entry))
             (end-time (cadr entry))
             (title (replace-regexp-in-string "\\* \\|TODO\\|DONE" "" (nth 2 entry)))
             (tags (mapconcat 'identity (nth 3 entry) ", ")))
        (do-applescript
         (format "
tell application \"Calendar\"
    tell calendar \"mqdtest\"
        set myevent to make new event with properties {summary:\"%s\", start date:date \"%d-%02d-%02d %02d:%02d:00\", end date:date \"%d-%02d-%02d %02d:%02d:00\", description:\"%s\"}
    end tell
end tell"
                 title
                 (nth 5 start-time) (nth 4 start-time) (nth 3 start-time)
                 (nth 2 start-time) (nth 1 start-time)
                 (nth 5 end-time) (nth 4 end-time) (nth 3 end-time)
                 (nth 2 end-time) (nth 1 end-time)
                 tags))))))
(defun org-entries-to-mac-calendar ()
  (interactive)
  (let (entries)
    (org-map-entries
     (lambda ()
       (let* ((heading (org-get-heading t t t t))
              (tags (org-get-tags))
              (scheduled (org-entry-get nil "SCHEDULED"))
              (timestamp (when scheduled
                           (org-parse-time-string scheduled))))
         (when timestamp
           (push (list (decode-time (nth 5 timestamp))
                       heading
                       tags)
                 entries))))
     t 'agenda)
    (dolist (entry entries)
      (let* ((start-time (car entry))
             (title (replace-regexp-in-string "\\* \\|TODO\\|DONE" "" (nth 1 entry)))
             (tags (mapconcat 'identity (nth 2 entry) ", "))
             (year (nth 5 start-time))
             (month (nth 4 start-time))
             (day (nth 3 start-time))
             (hour (nth 2 start-time))
             (minute (nth 1 start-time)))
        (do-applescript
         (format "
tell application \"Calendar\"
    tell calendar \"mqdtest\"
        set myevent to make new event with properties {summary:\"%s\", start date:date \"%d-%02d-%02d %02d:%02d:00\", end date:date \"%d-%02d-%02d %02d:%02d:00\", description:\"Tags: %s\"}
    end tell
end tell"
                 title
                 year month day hour minute
                 year month day (if (= hour 23) 0 (1+ hour)) (if (= hour 23) minute minute)
                 tags))))))



(defun org-entries-to-mac-calendar ()
  (interactive)
  (let (entries)
    (org-map-entries
     (lambda ()
       (let* ((heading (org-get-heading t t t t))
              (tags (org-get-tags))
              (scheduled (org-entry-get nil "SCHEDULED"))
              (timestamp (when scheduled
                           (org-parse-time-string scheduled))))
         (when timestamp
           (push (list (decode-time (nth 5 timestamp))
                       heading
                       tags)
                 entries))))
     t nil) ; 修改了这里将 'agenda 改为 nil
    (dolist (entry entries)
      (let* ((start-time (car entry))
             (title (replace-regexp-in-string "\\* \\|TODO\\|DONE" "" (nth 1 entry)))
             (tags (mapconcat 'identity (nth 2 entry) ", "))
             (year (nth 5 start-time))
             (month (nth 4 start-time))
             (day (nth 3 start-time))
             (hour (nth 2 start-time))
             (minute (nth 1 start-time)))
        (do-applescript
         (format "
tell application \"Calendar\"
    tell calendar \"mqdtest\"
        set myevent to make new event with properties {summary:\"%s\", start date:date \"%d-%02d-%02d %02d:%02d:00\", end date:date \"%d-%02d-%02d %02d:%02d:00\", description:\"Tags: %s\"}
    end tell
end tell"
                 title
                 year month day hour minute
                 year month day (if (= hour 23) 0 (1+ hour)) (if (= hour 23) minute minute)
                 tags))))))
(defun org-entries-to-mac-calendar ()
  (interactive)
  (let (entries)
    (org-map-entries
     (lambda ()
       (let* ((heading (org-get-heading t t t t))
              (tags (org-get-tags))
              (scheduled (org-entry-get nil "SCHEDULED"))
              (timestamp (when scheduled
                           (org-parse-time-string scheduled))))
         (when timestamp
           (push (list (decode-time (nth 5 timestamp))
                       heading
                       tags)
                 entries))))
     t nil) 
    (with-temp-buffer
      (dolist (entry entries)
        (let* ((start-time (car entry))
               (title (replace-regexp-in-string "\\* \\|TODO\\|DONE" "" (nth 1 entry)))
               (tags (mapconcat 'identity (nth 2 entry) ", "))
               (year (nth 5 start-time))
               (month (nth 4 start-time))
               (day (nth 3 start-time))
               (hour (nth 2 start-time))
               (minute (nth 1 start-time)))
          (insert (format "
tell application \"Calendar\"
    tell calendar \"My Calendar\"
        set myevent to make new event with properties {summary:\"%s\", start date:date \"%d-%02d-%02d %02d:%02d:00\", end date:date \"%d-%02d-%02d %02d:%02d:00\", description:\"Tags: %s\"}
    end tell
end tell\n"
                          title
                          year month day hour minute
                          year month day (if (= hour 23) 0 (1+ hour)) (if (= hour 23) minute minute)
                          tags))))
      (write-file "~/Desktop/calendar-scripts.scpt"))))

(defun org-entries-to-mac-calendar ()
  (interactive)
  (let (entries)
    (org-map-entries
     (lambda ()
       (let* ((heading (org-get-heading t t t t))
              (tags (org-get-tags))
              (scheduled (org-entry-get nil "SCHEDULED"))
              (timestamp (when scheduled
                           (org-parse-time-string scheduled))))
         (when timestamp
           (push (list (decode-time (apply 'encode-time (nth 5 timestamp)))
                       heading
                       tags)
                 entries))))
     nil nil) ; 修改此行以仅扫描当前 org 文件
    (with-temp-buffer
      (dolist (entry entries)
        (let* ((start-time (car entry))
               (title (replace-regexp-in-string "\\* \\|TODO\\|DONE" "" (nth 1 entry)))
               (tags (mapconcat 'identity (nth 2 entry) ", "))
               (year (nth 5 start-time))
               (month (nth 4 start-time))
               (day (nth 3 start-time))
               (hour (nth 2 start-time))
               (minute (nth 1 start-time)))
          (insert (format "
tell application \"Calendar\"
    tell calendar \"My Calendar\"
        set myevent to make new event with properties {summary:\"%s\", start date:date \"%d-%02d-%02d %02d:%02d:00\", end date:date \"%d-%02d-%02d %02d:%02d:00\", description:\"Tags: %s\"}
    end tell
end tell\n"
                          title
                          year month day hour minute
                          year month day (if (= hour 23) 0 (1+ hour)) (if (= hour 23) minute minute)
                          tags))))
      (write-file "~/Desktop/calendar-scripts.scpt"))))

(defun org-entries-to-mac-calendar ()
  (interactive)
  (let (entries)
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
     nil nil) ; 修改此行以仅扫描当前 org 文件
    (with-temp-buffer
      (dolist (entry entries)
        (let* ((time (car entry))
               (title (replace-regexp-in-string "\\* \\|TODO\\|DONE" "" (nth 1 entry)))
               (tags (mapconcat 'identity (nth 2 entry) ", "))
               (year (string-to-number (format-time-string "%Y" time)))
               (month (string-to-number (format-time-string "%m" time)))
               (day (string-to-number (format-time-string "%d" time)))
               (hour (string-to-number (format-time-string "%H" time)))
               (minute (string-to-number (format-time-string "%M" time))))
          (insert (format "
tell application \"Calendar\"
    tell calendar \"My Calendar\"
        set myevent to make new event with properties {summary:\"%s\", start date:date \"%d-%02d-%02d %02d:%02d:00\", end date:date \"%d-%02d-%02d %02d:%02d:00\", description:\"Tags: %s\"}
    end tell
end tell\n"
                          title
                          year month day hour minute
                          year month day (if (= hour 23) 0 (1+ hour)) (if (= hour 23) minute minute)
                          tags))))
      (write-file "~/Desktop/calendar-scripts.scpt"))))
(defun org-entries-to-mac-calendar ()
  (interactive)
  (let (entries)
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
     nil nil) ; 这里已经修正以仅扫描当前 org 文件
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
        (do-applescript applescript-code)))))
(defun org-entries-to-mac-calendar ()
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
(defun org-current-entry-to-mac-calendar ()
  (interactive)
  (let ((script-file "/tmp/org-to-calendar.applescript"))
    (save-excursion
      (org-back-to-heading t)
      (let* ((heading (org-get-heading t t t t))
             (tags (org-get-tags))
             (scheduled (org-entry-get nil "SCHEDULED"))
             (timestamp (when scheduled
                          (org-parse-time-string scheduled))))
        (when timestamp
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
    tell calendar \"My Calendar\"
        set myevent to make new event with properties {summary:\"%s\", start date:date \"%d-%02d-%02d %02d:%02d:00\", end date:date \"%d-%02d-%02d %02d:%02d:00\", description:\"Tags: %s\"}
    end tell
end tell"
                                             title
                                             year month day hour minute
                                             year month day (if (= hour 23) 0 (1+ hour)) (if (= hour 23) minute minute)
                                             tags)))
              (insert applescript-code "\n")))
          (shell-command (format "osascript %s" script-file))))))
  (message "Event added to calendar if criteria met."))

(defun org-current-entry-to-mac-calendar ()
  (interactive)
  (let ((script-file "/tmp/org-to-calendar.applescript"))
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
    tell calendar \"My Calendar\"
        set myevent to make new event with properties {summary:\"%s\", start date:date \"%d-%02d-%02d %02d:%02d:00\", end date:date \"%d-%02d-%02d %02d:%02d:00\", description:\"Tags: %s\"}
    end tell
end tell"
                                                 title
                                                 year month day hour minute
                                                 year month day (if (= hour 23) 0 (1+ hour)) (if (= hour 23) minute minute)
                                                 tags)))
                  (insert applescript-code "\n")))
              (shell-command (format "osascript %s" script-file))
              (message "Event added to calendar."))
          (message "The current line does not have a scheduled timestamp or is not a heading."))))))
;; aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa|
;; 你你你你你你你你你你你你你你你你你你你你|
;; ,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,|
;; 。。。。。。。。。。。。。。。。。。。。|
;; 1111111111111111111111111111111111111111|
;; 東東東東東東東東東東東東東東東東東東東東|
;; ここここここここここここここここここここ|
;; ｺｺｺｺｺｺｺｺｺｺｺｺｺｺｺｺｺｺｺｺｺｺｺｺｺｺｺｺｺｺｺｺｺｺｺｺｺｺｺｺ|
;; 까까까까까까까까까까까까까까까까까까까까|
