;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-


;; =============
;; ==== 1 基本设置
;; =============

;; ====
;; ==== 1.1 个人信息
;; ====
(setq user-full-name "Mushi"
      user-mail-address "goodhlper005@gmail.com")

;; ====
;; ==== 1.2 更佳的默认设置
;; ====

;; 1.2.1 简单设置
(setq-default
 delete-by-moving-to-trash t
 window-combination-resize t
 x-stretch-cursor t)
(setq undo-limit 80000000
      evil-want-fine-undo t
      auto-save-default t
      truncate-string-ellipsis "..."
      password-cache-expiry nil
      scroll-margin 2)
(display-time-mode 1)
;; (unless (string-match-p "^Power N/A" (battery))
;;   (display-battery-mode 1))
(global-subword-mode 1)

;; 1.2.2 默认打开的界面尺寸
(add-to-list 'default-frame-alist '(height . 50))
(add-to-list 'default-frame-alist '(width . 80))

;; 1.2.3 使用自定义文件.custom.el
(setq-default custom-file (expand-file-name ".custom.el" doom-private-dir))
(when (file-exists-p custom-file)
  (load custom-file))

;; 1.2.4 窗口
(setq evil-vsplit-window-right t
      evil-split-window-below t)
(defadvice! prompt-for-buffer (&rest _)
  :after '(evil-window-split evil-window-vsplit)
  (consult-buffer))
(map! :map evil-window-map
      "SPC" #'rotate-layout
      ;; Navigation
      "<left>"     #'evil-window-left
      "<down>"     #'evil-window-down
      "<up>"       #'evil-window-up
      "<right>"    #'evil-window-right
      ;; Swapping windows
      "C-<left>"       #'+evil/window-move-left
      "C-<down>"       #'+evil/window-move-down
      "C-<up>"         #'+evil/window-move-up
      "C-<right>"      #'+evil/window-move-right)

;; 1.2.5 默认的缓冲区
;; (setq-default major-mode 'org-mode)

;; ====
;; ==== 1.3 Doom 的配置
;; ====
;; 1.3.1 模块
;; 见 init.el 文件

;; 1.3.2 视觉设置
;; 1.3.2.1 字体设置
(setq doom-font (font-spec :family "JetBrains Mono" :size 16)
      doom-big-font (font-spec :family "JetBrains Mono" :size 26)
      doom-variable-pitch-font (font-spec :family "Overpass" :size 16)
      doom-unicode-font (font-spec :family "JuliaMono")
      doom-serif-font (font-spec :family "IBM Plex Mono" :weight 'light))
;; 中文额外设置
(let ((font-chinese "PingFang SC"))
  (add-hook! emacs-startup :append
   (set-fontset-font t 'cjk-misc font-chinese nil 'prepend)
   (set-fontset-font t 'han font-chinese nil 'prepend)
   ;; (set-fontset-font t ?中 font-chinese nil 'prepend)
   ;; (set-fontset-font t ?言 font-chinese nil 'prepend)
   ))

;; 1.3.2.2 主题和底栏设置
(setq doom-theme 'modus-vivendi)
(remove-hook 'window-setup-hook #'doom-init-theme-h)
(add-hook 'after-init-hook #'doom-init-theme-h 'append)
(delq! t custom-theme-load-path)
;; 将底栏中红色字体换成橙色
(custom-set-faces!
  '(doom-modeline-buffer-modified :foreground "orange"))
;; 去除底栏中对 LF 和 UTF-8 的显示
(defun doom-modeline-conditional-buffer-encoding ()
  "We expect the encoding to be LF UTF-8, so only show the modeline when this is not the case"
  (setq-local doom-modeline-buffer-encoding
              (unless (and (memq (plist-get (coding-system-plist buffer-file-coding-system) :category)
                                 '(coding-category-undecided coding-category-utf-8))
                           (not (memq (coding-system-eol-type buffer-file-coding-system) '(1 2))))
                t)))
(add-hook 'after-change-major-mode-hook #'doom-modeline-conditional-buffer-encoding)

;; 1.3.2.3 杂项设置
;; 行号设置
(setq display-line-numbers-type 't)
;; 更好的默认界面名字
(setq doom-fallback-buffer-name "► Doom"
      +doom-dashboad-name "► Doom")
;; 缩进设置
(setq-default  tab-width 2) ;; 表示一个 tab 4个字符宽
(setq-default indent-tabs-mode nil) ;; nil 表示将 tab 替换成空格

;; 1.3.3 一些有用的宏

;; 1.3.4 允许 babel 进行命令行操作 - 没搞懂
;; (setq org-confirm-babel-evaluate nil)
;; (defun doom-shut-up-a (orig-fn &rest args)
;;   (quiet! (apply orig-fn args)))
;; (advice-add 'org-babel-execute-src-block :around #'doom-shut-up-a)

;; 1.3.5 Elisp REPL


;; 1.3.6 异步配置混乱 - 我对 literate 还不熟悉
;; (defvar +literate-tangle--proc nil)
;; (defvar +literate-tangle--proc-start-time nil)
;; (defadvice! +literate-tangle-async-h ()
;;   "A very simplified version of `+literate-tangle-h', but async."
;;   :override #'+literate-tangle-h
;;   (unless (getenv "__NOTANGLE")
;;     (let ((default-directory doom-private-dir))
;;       (when +literate-tangle--proc
;;         (message "Killing outdated tangle process...")
;;         (set-process-sentinel +literate-tangle--proc #'ignore)
;;         (kill-process +literate-tangle--proc)
;;         (sit-for 0.3)) ; ensure the message is seen for a bit
;;       (setq +literate-tangle--proc-start-time (float-time)
;;             +literate-tangle--proc
;;             (start-process "tangle-config"
;;                            (get-buffer-create " *tangle config*")
;;                            "emacs" "--batch" "--eval"
;;                            (format "(progn \
;; (require 'ox) \
;; (require 'ob-tangle) \
;; (setq org-confirm-babel-evaluate nil \
;;       org-inhibit-startup t \
;;       org-mode-hook nil \
;;       write-file-functions nil \
;;       before-save-hook nil \
;;       after-save-hook nil \
;;       vc-handled-backends nil \
;;       org-startup-folded nil \
;;       org-startup-indented nil) \
;; (org-babel-tangle-file \"%s\" \"%s\"))"
;;                                    +literate-config-file
;;                                    (expand-file-name (concat doom-module-config-file ".el")))))
;;       (set-process-sentinel +literate-tangle--proc #'+literate-tangle--sentinel)
;;       (run-at-time nil nil (lambda () (message "Tangling config.org"))) ; ensure shown after a save message
;;       "Tangling config.org...")))
;; (defun +literate-tangle--sentinel (process signal)
;;   (cond
;;    ((and (eq 'exit (process-status process))
;;          (= 0 (process-exit-status process)))
;;     (message "Tangled config.org sucessfully (took %.1fs)"
;;              (- (float-time) +literate-tangle--proc-start-time))
;;     (setq +literate-tangle--proc nil))
;;    ((memq (process-status process) (list 'exit 'signal))
;;     (+popup-buffer (get-buffer " *tangle config*"))
;;     (message "Failed to tangle config.org (after %.1fs)"
;;              (- (float-time) +literate-tangle--proc-start-time))
;;     (setq +literate-tangle--proc nil))))

;; (defun +literate-tangle-check-finished ()
;;   (when (and (process-live-p +literate-tangle--proc)
;;              (yes-or-no-p "Config is currently retangling, would you please wait a few seconds?"))
;;     (switch-to-buffer " *tangle config*")
;;     (signal 'quit nil)))
;; (add-hook! 'kill-emacs-hook #'+literate-tangle-check-finished)

;; 1.3.7 主面板快速操作 - 对我来说不必要, 而且不稳定
;; (defun +doom-dashboard-setup-modified-keymap ()
;;   (setq +doom-dashboard-mode-map (make-sparse-keymap))
;;   (map! :map +doom-dashboard-mode-map
;;         :desc "Find file" :ne "f" #'find-file
;;         :desc "Recent files" :ne "r" #'consult-recent-file
;;         :desc "Config dir" :ne "C" #'doom/open-private-config
;;         :desc "Open config.org" :ne "c" (cmd! (find-file (expand-file-name "config.org" doom-private-dir)))
;;         :desc "Open dotfile" :ne "." (cmd! (doom-project-find-file "~/.config/"))
;;         :desc "Notes (roam)" :ne "n" #'org-roam-node-find
;;         :desc "Switch buffer" :ne "b" #'+vertico/switch-workspace-buffer
;;         :desc "Switch buffers (all)" :ne "B" #'consult-buffer
;;         :desc "IBuffer" :ne "i" #'ibuffer
;;         :desc "Previous buffer" :ne "p" #'previous-buffer
;;         :desc "Set theme" :ne "t" #'consult-theme
;;         :desc "Quit" :ne "Q" #'save-buffers-kill-terminal
;;         :desc "Show keybindings" :ne "h" (cmd! (which-key-show-keymap '+doom-dashboard-mode-map))))
;; (add-transient-hook! #'+doom-dashboard-mode (+doom-dashboard-setup-modified-keymap))
;; (add-transient-hook! #'+doom-dashboard-mode :append (+doom-dashboard-setup-modified-keymap))
;; (add-hook! 'doom-init-ui-hook :append (+doom-dashboard-setup-modified-keymap))
;; (map! :leader :desc "Dashboard" "d" #'+doom-dashboard/open)

;; ====
;; ==== 1.4 其他设置
;; ====

;; 1.4.1 编辑互动

;; 1.4.1.1 鼠标按键 - C-o 和 C-i 足够了
;; (map! :n [mouse-8] #'better-jumper-jump-backward
;;       :n [mouse-9] #'better-jumper-jump-forward)

;; 1.4.2 窗口标题
(setq frame-title-format
      '(""
        (:eval
         (if (s-contains-p org-roam-directory (or buffer-file-name ""))
             (replace-regexp-in-string
              ".*/[0-9]*-?" "☰ "
              (subst-char-in-string ?_ ?  buffer-file-name))
           "%b"))
        (:eval
         (let ((project-name (projectile-project-name)))
           (unless (string= "-" project-name)
             (format (if (buffer-modified-p)  " ◉ %s" "  ●  %s") project-name))))))

;; $1.4.3 屏幕标志
;; 实现很复杂

;; $1.4.4 系统守护进程

;; $1.4.5 对 emacs 客户端进行包装

;; $1.4.6 提示运行安装脚本


;; ========================
;; ==== 2 PACKAGES 安装包设置
;; ========================

;; ====
;; ==== 2.2 便利的一些包
;; ====

;; 2.2.1 Avy

;; 2.2.2 旋转窗口布局 SPC w SPC
;; packag.el

;; 2.2.3 Emacs Everwhere
(use-package! emacs-everywhere
  :if (daemonp)
  :config
  (require 'spell-fu)
  (setq emacs-everywhere-major-mode-function #'org-mode
        emacs-everywhere-frame-name-format "Edit ∷ %s — %s")
  (defadvice! emacs-everywhere-raise-frame ()
    :after #'emacs-everywhere-set-frame-name
    (setq emacs-everywhere-frame-name (format emacs-everywhere-frame-name-format
                                (emacs-everywhere-app-class emacs-everywhere-current-app)
                                (truncate-string-to-width
                                 (emacs-everywhere-app-title emacs-everywhere-current-app)
                                 45 nil nil "…")))
    ;; need to wait till frame refresh happen before really set
    (run-with-timer 0.1 nil #'emacs-everywhere-raise-frame-1))
  (defun emacs-everywhere-raise-frame-1 ()
    (call-process "wmctrl" nil nil nil "-a" emacs-everywhere-frame-name)))

;; 2.2.4 Which-key
(setq which-key-idle-delay 0.5)
;; 删除过多的 evil 显示
(setq which-key-allow-multiple-replacements t)
(after! which-key
  (pushnew!
   which-key-replacement-alist
   '(("" . "\\`+?evil[-:]?\\(?:a-\\)?\\(.*\\)") . (nil . "◂\\1"))
   '(("\\`g s" . "\\`evilem--?motion-\\(.*\\)") . (nil . "◃\\1"))
   ))

;; Use editorconfig
(setq lsp-enable-indentation nil)
(setq editorconfig-mode 1)

;; ====
;; ==== 2.3 工具
;; ====

;; 2.3.1 Abbrev
(add-hook 'doom-first-buffer-hook
          (defun +abbrev-file-name ()
            (setq-default abbrev-mode t)
            (setq abbrev-file-name (expand-file-name "abbrev.el" doom-private-dir))))

;; 2.3.2 非常大的文件
(use-package! vlf-setup
  :defer-incrementally vlf-tune vlf-base vlf-write vlf-search vlf-occur vlf-follow vlf-ediff vlf)

;; 2.3.3 Eros
;; From the :tools eval module
(setq eros-eval-result-prefix "⟹ ") ; default =>

;; 2.3.4 Evil
;; 总是打开全局替换
;; 当切换输入模式时不要移动块光标
(after! evil
  (setq evil-ex-substitute-global t
        evil-move-cursor-back nil
        evil-kill-on-visual-paste nil))

;; Use YASnippet
(setq yas-triggers-in-field t)
;; (add-to-list 'load-path
;;              "~/path-to-yasnippet")
;; (setq yas-snippet-dirs '("~/.config/doom/snippets"))
;; (require 'yasnippet)

(use-package! string-inflection
  :commands (string-inflection-all-cycle
             string-inflection-toggle
             string-inflection-camelcase
             string-inflection-lower-camelcase
             string-inflection-kebab-case
             string-inflection-underscore
             string-inflection-capital-underscore
             string-inflection-upcase)
  :init
  (map! :leader :prefix ("c~" . "naming convention")
        :desc "cycle" "~" #'string-inflection-all-cycle
        :desc "toggle" "t" #'string-inflection-toggle
        :desc "CamelCase" "c" #'string-inflection-camelcase
        :desc "downCase" "d" #'string-inflection-lower-camelcase
        :desc "kebab-case" "k" #'string-inflection-kebab-case
        :desc "under_score" "_" #'string-inflection-underscore
        :desc "Upper_Score" "u" #'string-inflection-capital-underscore
        :desc "UP_CASE" "U" #'string-inflection-upcase)
  (after! evil
    (evil-define-operator evil-operator-string-inflection (beg end _type)
      "Define a new evil operator that cycles symbol casing."
      :move-point nil
      (interactive "<R>")
      (string-inflection-all-cycle)
      (setq evil-repeat-info '([?g ?~])))
    (define-key evil-normal-state-map (kbd "g~") 'evil-operator-string-inflection)))
; (yas-global-mode 1)


;; All the icons
(after! all-the-icons
  (setcdr (assoc "m" all-the-icons-extension-icon-alist)
          (cdr (assoc "matlab" all-the-icons-extension-icon-alist))))



;; Magit
;; commit message templates
(defvar +magit-project-commit-templates-alist nil
  "Alist of toplevel dirs and template strings/functions.")
(after! magit
  (defun +magit-fill-in-commit-template ()
    "Insert template from `+magit-fill-in-commit-template' if applicable."
    (when-let ((template (and (save-excursion (goto-char (point-min)) (string-match-p "\\`\\s-*$" (thing-at-point 'line)))
                              (cdr (assoc (file-name-base (directory-file-name (magit-toplevel)))
                                          +magit-project-commit-templates-alist)))))
      (goto-char (point-min))
      (insert (if (stringp template) template (funcall template)))
      (goto-char (point-min))
      (end-of-line)))
  (add-hook 'git-commit-setup-hook #'+magit-fill-in-commit-template 90))

(after! magit
  (defun +org-commit-message-template ()
    "Create a skeleton for an Org commit message based on the staged diff."
    (let (change-data last-file file-changes temp-point)
      (with-temp-buffer
        (apply #'call-process magit-git-executable
               nil t nil
               (append
                magit-git-global-arguments
                (list "diff" "--cached")))
        (goto-char (point-min))
        (while (re-search-forward "^@@\\|^\\+\\+\\+ b/" nil t)
          (if (looking-back "^\\+\\+\\+ b/" (line-beginning-position))
              (progn
                (push (list last-file file-changes) change-data)
                (setq last-file (buffer-substring-no-properties (point) (line-end-position))
                      file-changes nil))
            (setq temp-point (line-beginning-position))
            (re-search-forward "^\\+\\|^-" nil t)
            (end-of-line)
            (cond
             ((string-match-p "\\.el$" last-file)
              (when (re-search-backward "^\\(?:[+-]? *\\|@@[ +-\\d,]+@@ \\)(\\(?:cl-\\)?\\(?:defun\\|defvar\\|defmacro\\|defcustom\\)" temp-point t)
                (re-search-forward "\\(?:cl-\\)?\\(?:defun\\|defvar\\|defmacro\\|defcustom\\) " nil t)
                (add-to-list 'file-changes (buffer-substring-no-properties (point) (forward-symbol 1)))))
             ((string-match-p "\\.org$" last-file)
              (when (re-search-backward "^[+-]\\*+ \\|^@@[ +-\\d,]+@@ \\*+ " temp-point t)
                (re-search-forward "@@ \\*+ " nil t)
                (add-to-list 'file-changes (buffer-substring-no-properties (point) (line-end-position)))))))))
      (push (list last-file file-changes) change-data)
      (setq change-data (delete '(nil nil) change-data))
      (concat
       (if (= 1 (length change-data))
           (replace-regexp-in-string "^.*/\\|.[a-z]+$" "" (caar change-data))
         "?")
       ": \n\n"
       (mapconcat
        (lambda (file-changes)
          (if (cadr file-changes)
              (format "* %s (%s): "
                      (car file-changes)
                      (mapconcat #'identity (cadr file-changes) ", "))
            (format "* %s: " (car file-changes))))
        change-data
        "\n\n"))))

  (add-to-list '+magit-project-commit-templates-alist (cons "org-mode" #'+org-commit-message-template)))

;; Smerge
(defun smerge-repeatedly ()
  "Perform smerge actions again and again"
  (interactive)
  (smerge-mode 1)
  (smerge-transient))
(after! transient
  (transient-define-prefix smerge-transient ()
    [["Move"
      ("n" "next" (lambda () (interactive) (ignore-errors (smerge-next)) (smerge-repeatedly)))
      ("p" "previous" (lambda () (interactive) (ignore-errors (smerge-prev)) (smerge-repeatedly)))]
     ["Keep"
      ("b" "base" (lambda () (interactive) (ignore-errors (smerge-keep-base)) (smerge-repeatedly)))
      ("u" "upper" (lambda () (interactive) (ignore-errors (smerge-keep-upper)) (smerge-repeatedly)))
      ("l" "lower" (lambda () (interactive) (ignore-errors (smerge-keep-lower)) (smerge-repeatedly)))
      ("a" "all" (lambda () (interactive) (ignore-errors (smerge-keep-all)) (smerge-repeatedly)))
      ("RET" "current" (lambda () (interactive) (ignore-errors (smerge-keep-current)) (smerge-repeatedly)))]
     ["Diff"
      ("<" "upper/base" (lambda () (interactive) (ignore-errors (smerge-diff-base-upper)) (smerge-repeatedly)))
      ("=" "upper/lower" (lambda () (interactive) (ignore-errors (smerge-diff-upper-lower)) (smerge-repeatedly)))
      (">" "base/lower" (lambda () (interactive) (ignore-errors (smerge-diff-base-lower)) (smerge-repeatedly)))
      ("R" "refine" (lambda () (interactive) (ignore-errors (smerge-refine)) (smerge-repeatedly)))
      ("E" "ediff" (lambda () (interactive) (ignore-errors (smerge-ediff)) (smerge-repeatedly)))]
     ["Other"
      ("c" "combine" (lambda () (interactive) (ignore-errors (smerge-combine-with-next)) (smerge-repeatedly)))
      ("r" "resolve" (lambda () (interactive) (ignore-errors (smerge-resolve)) (smerge-repeatedly)))
      ("k" "kill current" (lambda () (interactive) (ignore-errors (smerge-kill-current)) (smerge-repeatedly)))
      ("q" "quit" (lambda () (interactive) (smerge-auto-leave)))]]))

;; Company
(after! company
  (setq company-idle-delay 0.5
        company-minimum-prefix-length 2)
  (setq company-show-quick-access t))
(setq-default history-length 1000)
(setq-default prescient-history-length 1000)

;; Plain text
(set-company-backend!
  '(text-mode
    markdown-mode
    gfm-mode)
  '(:seperate
    company-ispell
    company-files
    company-yasnippet))

;; ESS
(set-company-backend! 'ess-r-mode '(company-R-args company-R-objects company-dabbrev-code :separate))

;; Projectile
;; (setq projectile-ignored-projects '("~/" "/tmp" "~/.emacs.d/.local/straight/repos/"))
;; (defun projectile-ignored-project-function (filepath)
;;  "Return t if FILEPATH is within any of `projectile-ignored-projects'"
;;  (or (mapcar (lambda (p) (s-starts-with-p p filepath)) projectile-ignored-projects)))

;; TRAMP
;; prompt recognition
(after! tramp
  (setenv "SHELL" "/bin/bash")
  (setq tramp-shell-prompt-pattern "\\(?:^\\|
\\)[^]#$%>\n]*#?[]#$%>] *\\(\\[[0-9;]*[a-zA-Z] *\\)*")) ;; default + 

(after! tramp
  (appendq! tramp-remote-path
            '("~/.guix-profile/bin" "~/.guix-profile/sbin"
              "/run/current-system/profile/bin"
              "/run/current-system/profile/sbin")))

;; Doom modeline
(after! doom-modeline
  (doom-modeline-def-segment buffer-name
    "Display the current buffer's name, without any other information."
    (concat
     (doom-modeline-spc)
     (doom-modeline--buffer-name)))

  (doom-modeline-def-segment pdf-icon
    "PDF icon from all-the-icons."
    (concat
     (doom-modeline-spc)
     (doom-modeline-icon 'octicon "file-pdf" nil nil
                         :face (if (doom-modeline--active)
                                   'all-the-icons-red
                                 'mode-line-inactive)
                         :v-adjust 0.02)))

  (defun doom-modeline-update-pdf-pages ()
    "Update PDF pages."
    (setq doom-modeline--pdf-pages
          (let ((current-page-str (number-to-string (eval `(pdf-view-current-page))))
                (total-page-str (number-to-string (pdf-cache-number-of-pages))))
            (concat
             (propertize
              (concat (make-string (- (length total-page-str) (length current-page-str)) ? )
                      " P" current-page-str)
              'face 'mode-line)
             (propertize (concat "/" total-page-str) 'face 'doom-modeline-buffer-minor-mode)))))

  (doom-modeline-def-segment pdf-pages
    "Display PDF pages."
    (if (doom-modeline--active) doom-modeline--pdf-pages
      (propertize doom-modeline--pdf-pages 'face 'mode-line-inactive)))

  (doom-modeline-def-modeline 'pdf
    '(bar window-number pdf-pages pdf-icon buffer-name)
    '(misc-info matches major-mode process vcs)))

(use-package! keycast
  :commands keycast-mode
  :config
  (define-minor-mode keycast-mode
    "Show current command and its key binding in the mode line."
    :global t
    (if keycast-mode
        (progn
          (add-hook 'pre-command-hook 'keycast--update t)
          (add-to-list 'global-mode-string '("" mode-line-keycast " ")))
      (remove-hook 'pre-command-hook 'keycast--update)
      (setq global-mode-string (remove '("" mode-line-keycast " ") global-mode-string))))
  (custom-set-faces!
    '(keycast-command :inherit doom-modeline-debug
                      :height 0.9)
    '(keycast-key :inherit custom-modified
                  :height 1.1
                  :weight bold)))

;; Mixed pitch
(defvar mixed-pitch-modes '(org-mode LaTeX-mode markdown-mode gfm-mode Info-mode)
  "Modes that `mixed-pitch-mode' should be enabled in, but only after UI initialisation.")
(defun init-mixed-pitch-h ()
  "Hook `mixed-pitch-mode' into each mode in `mixed-pitch-modes'.
Also immediately enables `mixed-pitch-modes' if currently in one of the modes."
  (when (memq major-mode mixed-pitch-modes)
    (mixed-pitch-mode 1))
  (dolist (hook mixed-pitch-modes)
    (add-hook (intern (concat (symbol-name hook) "-hook")) #'mixed-pitch-mode)))
(add-hook 'doom-init-ui-hook #'init-mixed-pitch-h)

(autoload #'mixed-pitch-serif-mode "mixed-pitch"
  "Change the default face of the current buffer to a serifed variable pitch, while keeping some faces fixed pitch." t)

(after! mixed-pitch
  (defface variable-pitch-serif
    '((t (:family "serif")))
    "A variable-pitch face with serifs."
    :group 'basic-faces)
  (setq mixed-pitch-set-height t)
  (setq variable-pitch-serif-font (font-spec :family "Alegreya" :size 27))
  (set-face-attribute 'variable-pitch-serif nil :font variable-pitch-serif-font)
  (defun mixed-pitch-serif-mode (&optional arg)
    "Change the default face of the current buffer to a serifed variable pitch, while keeping some faces fixed pitch."
    (interactive)
    (let ((mixed-pitch-face 'variable-pitch-serif))
      (mixed-pitch-mode (or arg 'toggle)))))

(set-char-table-range composition-function-table ?f '(["\\(?:ff?[fijlt]\\)" 0 font-shape-gstring]))
(set-char-table-range composition-function-table ?T '(["\\(?:Th\\)" 0 font-shape-gstring]))

;; Writeroom
(setq +zen-text-scale 0.8)

(defvar +zen-serif-p t
  "Whether to use a serifed font with `mixed-pitch-mode'.")
(after! writeroom-mode
  (defvar-local +zen--original-org-indent-mode-p nil)
  (defvar-local +zen--original-mixed-pitch-mode-p nil)
  (defvar-local +zen--original-org-pretty-table-mode-p nil)
  (defun +zen-enable-mixed-pitch-mode-h ()
    "Enable `mixed-pitch-mode' when in `+zen-mixed-pitch-modes'."
    (when (apply #'derived-mode-p +zen-mixed-pitch-modes)
      (if writeroom-mode
          (progn
            (setq +zen--original-mixed-pitch-mode-p mixed-pitch-mode)
            (funcall (if +zen-serif-p #'mixed-pitch-serif-mode #'mixed-pitch-mode) 1))
        (funcall #'mixed-pitch-mode (if +zen--original-mixed-pitch-mode-p 1 -1)))))
  (pushnew! writeroom--local-variables
            'display-line-numbers
            'visual-fill-column-width
            'org-adapt-indentation
            'org-superstar-headline-bullets-list
            'org-superstar-remove-leading-stars)
  (add-hook 'writeroom-mode-enable-hook
            (defun +zen-prose-org-h ()
              "Reformat the current Org buffer appearance for prose."
              (when (eq major-mode 'org-mode)
                (setq display-line-numbers nil
                      visual-fill-column-width 60
                      org-adapt-indentation nil)
                (when (featurep 'org-superstar)
                  (setq-local org-superstar-headline-bullets-list '("🙘" "🙙" "🙚" "🙛")
                              ;; org-superstar-headline-bullets-list '("🙐" "🙑" "🙒" "🙓" "🙔" "🙕" "🙖" "🙗")
                              org-superstar-remove-leading-stars t)
                  (org-superstar-restart))
                (setq
                 +zen--original-org-indent-mode-p org-indent-mode
                 +zen--original-org-pretty-table-mode-p (bound-and-true-p org-pretty-table-mode))
                (org-indent-mode -1)
                (org-pretty-table-mode 1))))
  (add-hook 'writeroom-mode-disable-hook
            (defun +zen-nonprose-org-h ()
              "Reverse the effect of `+zen-prose-org'."
              (when (eq major-mode 'org-mode)
                (when (featurep 'org-superstar)
                  (org-superstar-restart))
                (when +zen--original-org-indent-mode-p (org-indent-mode 1))
                ;; (unless +zen--original-org-pretty-table-mode-p (org-pretty-table-mode -1))
                ))))

;; Page-break
(use-package! page-break-lines
  :commands page-break-lines-mode
  :init
  (autoload 'turn-on-page-break-lines-mode "page-break-lines")
  :config
  (setq page-break-lines-max-width fill-column)
  (map! :prefix "g"
        :desc "Prev page break" :nv "[" #'backward-page
        :desc "Next page break" :nv "]" #'forward-page))

;; Centaur Tabs
(after! centaur-tabs
  (centaur-tabs-mode -1)
  (setq centaur-tabs-height 36
        centaur-tabs-set-icons t
        centaur-tabs-modified-marker "o"
        centaur-tabs-close-button "×"
        centaur-tabs-set-bar 'above
        centaur-tabs-gray-out-icons 'buffer)
  (centaur-tabs-change-fonts "P22 Underground Book" 160))
;; (setq x-underline-at-descent-line t)

;; ===========
;; Frivolities
;; ===========

;; Selectric 打字时发声
(use-package! selectric-mode
  :commands selectric-mode)

;; Spray 在屏幕上闪现文字
(use-package! spray
  :commands spray-mode
  :config
  (setq spray-wpm 600
        spray-height 800)
  (defun spray-mode-hide-cursor ()
    "Hide or unhide the cursor as is appropriate."
    (if spray-mode
        (setq-local spray--last-evil-cursor-state evil-normal-state-cursor
                    evil-normal-state-cursor '(nil))
      (setq-local evil-normal-state-cursor spray--last-evil-cursor-state)))
  (add-hook 'spray-mode-hook #'spray-mode-hide-cursor)
  (map! :map spray-mode-map
        "<return>" #'spray-start/stop
        "f" #'spray-faster
        "s" #'spray-slower
        "t" #'spray-time
        "<right>" #'spray-forward-word
        "h" #'spray-forward-word
        "<left>" #'spray-backward-word
        "l" #'spray-backward-word
        "q" #'spray-quit))

;; Elcord 在discord上显示你正在使用 emacs
(use-package! elcord
  :commands elcord-mode
  :config
  (setq elcord-use-major-mode-as-main-icon t))

;; ============
;; Applications
;; ============
;; EBOOKS

;; CALCULATOR
;; defaults
(setq calc-angle-mode 'rad  ; radians are rad
      calc-symbolic-mode t) ; keeps expressions like \sqrt{2} irrational for as long as possible

;; Calctex
(use-package! calctex
  :commands calctex-mode
  :init
  (add-hook 'calc-mode-hook #'calctex-mode)
  :config
  (setq calctex-additional-latex-packages "
\\usepackage[usenames]{xcolor}
\\usepackage{soul}
\\usepackage{adjustbox}
\\usepackage{amsmath}
\\usepackage{amssymb}
\\usepackage{siunitx}
\\usepackage{cancel}
\\usepackage{mathtools}
\\usepackage{mathalpha}
\\usepackage{xparse}
\\usepackage{arevmath}"
        calctex-additional-latex-macros
        (concat calctex-additional-latex-macros
                "\n\\let\\evalto\\Rightarrow"))
  (defadvice! no-messaging-a (orig-fn &rest args)
    :around #'calctex-default-dispatching-render-process
    (let ((inhibit-message t) message-log-max)
      (apply orig-fn args)))
  ;; Fix hardcoded dvichop path (whyyyyyyy)
  (let ((vendor-folder (concat (file-truename doom-local-dir)
                               "straight/"
                               (format "build-%s" emacs-version)
                               "/calctex/vendor/")))
    (setq calctex-dvichop-sty (concat vendor-folder "texd/dvichop")
          calctex-dvichop-bin (concat vendor-folder "texd/dvichop")))
  (unless (file-exists-p calctex-dvichop-bin)
    (message "CalcTeX: Building dvichop binary")
    (let ((default-directory (file-name-directory calctex-dvichop-bin)))
      (call-process "make" nil nil nil))))

;; embedded calc
(map! :map calc-mode-map
      :after calc
      :localleader
      :desc "Embedded calc (toggle)" "e" #'calc-embedded)
(map! :map org-mode-map
      :after org
      :localleader
      :desc "Embedded calc (toggle)" "E" #'calc-embedded)
(map! :map latex-mode-map
      :after latex
      :localleader
      :desc "Embedded calc (toggle)" "e" #'calc-embedded)

(defvar calc-embedded-trail-window nil)
(defvar calc-embedded-calculator-window nil)

(defadvice! calc-embedded-with-side-pannel (&rest _)
  :after #'calc-do-embedded
  (when calc-embedded-trail-window
    (ignore-errors
      (delete-window calc-embedded-trail-window))
    (setq calc-embedded-trail-window nil))
  (when calc-embedded-calculator-window
    (ignore-errors
      (delete-window calc-embedded-calculator-window))
    (setq calc-embedded-calculator-window nil))
  (when (and calc-embedded-info
             (> (* (window-width) (window-height)) 1200))
    (let ((main-window (selected-window))
          (vertical-p (> (window-width) 80)))
      (select-window
       (setq calc-embedded-trail-window
             (if vertical-p
                 (split-window-horizontally (- (max 30 (/ (window-width) 3))))
               (split-window-vertically (- (max 8 (/ (window-height) 4)))))))
      (switch-to-buffer "*Calc Trail*")
      (select-window
       (setq calc-embedded-calculator-window
             (if vertical-p
                 (split-window-vertically -6)
               (split-window-horizontally (- (/ (window-width) 2))))))
      (switch-to-buffer "*Calculator*")
      (select-window main-window))))

;; NEWSFEED

;; Language Setting
;; Python
(after! lsp-python-ms
  (set-lsp-priority! 'mspyls 1))


;; Here are some additional functions/macros that could help you configure Doom:
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.

(beacon-mode 1)

(use-package! org-pandoc-import :after org)

;; ============
;; ORG-SETTING
;; ============
;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/MEGA/org")

;; org-download
(require 'org-download)

(setq-default org-download-method 'directory)
(setq-default org-download-image-dir "./img")

;; Drag-and-drop to `dired`
(add-hook 'dired-mode-hook 'org-download-enable)

;; org-src
(setq org-src-preserve-indentation t)

(define-key global-map "\C-cc" 'org-capture)

(setq org-capture-templates
      '(("t" "Todo" entry (file+headline "~/MEGA/org/task.org" "Tasks")
         "* TODO %?\n %i\n %a")
        ("j" "Journal" entry (file+datetree "~/MEGA/org/journal.org")
         "* %?\nEntered on %U\n %i\n %a")))

;; ;; org-elp
;; (require 'org-elp)
;; (setq org-elp-split-fraction 0.2)
;; (setq org-elp-buffer-name "*Equation Live*")
;; (setq org-elp-idle-time 0.5)
