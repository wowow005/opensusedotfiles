;; -*- no-byte-compile: t; -*-

(setq package-archives '(("gnu"   . "https://mirrors.sjtug.sjtu.edu.cn/emacs-elpa/gnu/")
                         ("melpa" . "https://mirrors.sjtug.sjtu.edu.cn/emacs-elpa/melpa/")
                         ("melpa-stable" . "https://mirrors.sjtug.sjtu.edu.cn/emacs-elpa/melpa-stable/")
                         ("org" . "https://mirrors.sjtug.sjtu.edu.cn/emacs-elpa/org/")))

;; ========================
;; ==== 2 PACKAGES 安装包设置
;; ========================

;; ====
;; ==== 2.2 便利的一些包
;; ====

;; 2.2.1 Avy

;; 2.2.2 旋转窗口布局
(package! rotate :pin "4e9ac3ff800880bd9b705794ef0f7c99d72900a6")

;; 2.2.3 Emacs Everwhere
(package! emacs-everywhere :recipe (:local-repo "lisp/emacs-everywhere"))
(unpin! emacs-everywhere)

;; ====
;; ==== 2.3 工具
;; ====

;; 2.3.2 非常大的文件
;; (package! vlf :recipe (:host github :repo "m00natic/vlfi" :files ("*.el"))
;;   :pin "cc02f2533782d6b9b628cec7e2dcf25b2d05a27c" :disable t)

;; 2.3.4 Evil
;; (package! evil-escape :disable t)

;; 2.3.13 ass 自动激活snippets
(package! aas :recipe (:host github :repo "ymarco/auto-activating-snippets")
  :pin "b1a436922ba06ab9e1a5cc222f1a4f25a7697231")

;; 2.3.14 Screenshot 截图
(package! screenshot :recipe (:local-repo "lisp/screenshot"))

;; (package! yasnippet)
(package! org-elp)
(package! editorconfig)
(package! yasnippet-snippets)
(package! beacon)


(package! etrace :recipe (:host github :repo "aspiers/etrace"))
(use-package! etrace
  :after elp)


(package! page-break-lines :recipe (:host github :repo "purcell/page-break-lines"))

(package! spray :pin "74d9dcfa2e8b38f96a43de9ab0eb13364300cb46")

(package! elcord :pin "eb4ae2e7e03a5fc26b054ba2fa9a1d308e239c76")

(package! selectric-mode :pin "1840de71f7414b7cd6ce425747c8e26a413233aa")

(package! string-inflection :pin "fd7926ac17293e9124b31f706a4e8f38f6a9b855")

(package! info-colors :pin "47ee73cc19b1049eef32c9f3e264ea7ef2aaf8a5")
(use-package! info-colors
  :commands (info-colors-fontify-node))
(add-hook 'Info-selection-hook 'info-colors-fontify-node)

(package! org-pandoc-import
  :recipe (:host github
           :repo "tecosaur/org-pandoc-import"
           :files ("*.el" "filters" "preprocessors")))

(package! modus-themes :pin "392ebb115b07f8052d512ec847619387d109edd6")

(package! theme-magic :pin "844c4311bd26ebafd4b6a1d72ddcc65d87f074e3")
(use-package! theme-magic
  :commands theme-magic-from-emacs
  :config
  (defadvice! theme-magic--auto-extract-16-doom-colors ()
    :override #'theme-magic--auto-extract-16-colors
    (list
     (face-attribute 'default :background)
     (doom-color 'error)
     (doom-color 'success)
     (doom-color 'type)
     (doom-color 'keywords)
     (doom-color 'constants)
     (doom-color 'functions)
     (face-attribute 'default :foreground)
     (face-attribute 'shadow :foreground)
     (doom-blend 'base8 'error 0.1)
     (doom-blend 'base8 'success 0.1)
     (doom-blend 'base8 'type 0.1)
     (doom-blend 'base8 'keywords 0.1)
     (doom-blend 'base8 'constants 0.1)
     (doom-blend 'base8 'functions 0.1)
     (face-attribute 'default :foreground))))

(package! keycast :pin "72d9add8ba16e0cae8cfcff7fc050fa75e493b4e")

(package! org-pretty-table
  :recipe (:host github :repo "Fuco1/org-pretty-table") :pin
  "87772a9469d91770f87bfa788580fca69b9e697a")
(use-package! org-pretty-table
  :commands (org-pretty-table-mode global-org-pretty-table-mode))

(package! org-appear :recipe (:host github :repo "awth13/org-appear")
  :pin "148aa124901ae598f69320e3dcada6325cdc2cf0")
(use-package! org-appear
  :hook (org-mode . org-appear-mode)
  :config
  (setq org-appear-autoemphasis t
        org-appear-autosubmarkers t
        org-appear-autolinks nil)
  ;; for proper first-time setup, `org-appear--set-elements'
  ;; needs to be run after other hooks have acted.
  (run-at-time nil nil #'org-appear--set-elements))

(package! org-super-agenda :pin "a5557ea4f51571ee9def3cd9a1ab1c38f1a27af7")
(use-package! org-super-agenda
  :commands org-super-agenda-mode)

(package! doct
  :recipe (:host github :repo "progfolio/doct")
  :pin "67fc46c8a68989b932bce879fbaa62c6a2456a1f")
(use-package! doct
  :commands doct)

(package! calctex :recipe (:host github :repo "johnbcoughlin/calctex"
                           :files ("*.el" "calctex/*.el" "calctex-contrib/*.el" "org-calctex/*.el" "vendor"))
  :pin "67a2e76847a9ea9eff1f8e4eb37607f84b380ebb")
