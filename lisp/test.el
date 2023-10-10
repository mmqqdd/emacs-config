
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

