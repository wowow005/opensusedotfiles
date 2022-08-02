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
;; (package! emacs-everywhere :recipe (:local-repo "lisp/emacs-everywhere"))
;; (unpin! emacs-everywhere)

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
;; (package! screenshot :recipe (:local-repo "lisp/screenshot"))

;; 2.3.15 Etrace
(package! etrace :recipe (:host github :repo "aspiers/etrace"))

;; 2.3.16 YAsnippet
;; (package! yasnippet)

;; 2.3.17 String inflection
(package! string-inflection :pin "fd7926ac17293e9124b31f706a4e8f38f6a9b855")

;; 2.3.18 benchmark
(package! benchmark-init)

;; ====
;; ==== 2.4 Visuals 视觉效果
;; ====

;; 2.4.1 Info colours
(package! info-colors :pin "47ee73cc19b1049eef32c9f3e264ea7ef2aaf8a5")
(package! org-elp)
(package! editorconfig)
(package! yasnippet-snippets)
(package! beacon)

;; 2.4.2 Modus themes 我用的一款主题
(package! modus-themes :pin "392ebb115b07f8052d512ec847619387d109edd6")

;; 2.4.3 Theme magic 终端的主题
;; (package! theme-magic :pin "844c4311bd26ebafd4b6a1d72ddcc65d87f074e3")

;; 2.4.6 Keycast 按键显示工具
;; (package! keycast :pin "72d9add8ba16e0cae8cfcff7fc050fa75e493b4e")


;; 2.4.7 Screencast

;; 2.4.8 Mixed pitch
;; From :ui zen

;; 2.4.12 Page-break 处理翻页符
(package! page-break-lines :recipe (:host github :repo "purcell/page-break-lines"))

;; ====
;; ==== 2.5 Frivolities 一些娱乐的安装包
;; ====

;; 2.5.1 xkcd 一个漫画包
;; 我不需要

;; 2.5.2 Selectric 打字时发声
;; 没人喜欢听老打字机的噪声...
;; (package! selectric-mode :pin "1840de71f7414b7cd6ce425747c8e26a413233aa")

;; 2.5.3 Wttrin

;; 2.5.4 Spray 闪现文字工具
(package! spray :pin "74d9dcfa2e8b38f96a43de9ab0eb13364300cb46")

;; 2.5.5 Elcord 在 discord 中展示使用 emacs 状态
(package! elcord :pin "eb4ae2e7e03a5fc26b054ba2fa9a1d308e239c76")

;; =============
;; ==== 3 应用程序
;; =============

;; ====
;; ==== 3.1 看电子书
;; ====
;; 我不觉得这是个好主意 ...

;; ====
;; ==== 3.2 Emacs 中的计算器
;; ====

;; 3.2.2 计算 Tex 公式 CalcTeX
(package! calctex :recipe (:host github :repo "johnbcoughlin/calctex"
                           :files ("*.el" "calctex/*.el" "calctex-contrib/*.el" "org-calctex/*.el" "vendor"))
  :pin "67a2e76847a9ea9eff1f8e4eb37607f84b380ebb")

;; ====
;; ==== $3.3 IRC
;; ====


;; ====
;; ==== 3.4 新闻订阅 RSS
;; ====

;; ====
;; ==== 3.5 字典
;; ====

;; ====
;; ==== 3.6 电子邮件
;; ====


;; =============
;; ==== 4 语言配置
;; =============

;; ====
;; ==== 4.1 基本配置
;; ====

;; ====
;; ==== 4.2 纯文本文件
;; ====


;; ====
;; ==== 4.3 Org
;; ====

;; 4.3.1 系统配置
;; $4.3.1.1 Mime Types
;; $4.3.1.2 Git Diffs

;; 4.3.2 安装包

;; $4.3.2.1 Org 本身

;; 4.3.2.2 视觉效果
;; 4.3.2.2.1 表格
(package! org-pretty-table
  :recipe (:host github :repo "Fuco1/org-pretty-table") :pin
  "87772a9469d91770f87bfa788580fca69b9e697a")
;; 4.3.2.2.2 Emphasis markers 标记可见
(package! org-appear :recipe (:host github :repo "awth13/org-appear")
  :pin "148aa124901ae598f69320e3dcada6325cdc2cf0")
;; 4.3.2.2.3 标题结构
(package! org-ol-tree :recipe (:host github :repo "Townk/org-ol-tree")
  :pin "207c748aa5fea8626be619e8c55bdb1c16118c25")

;; 4.3.2.3 额外功能
;; 4.3.2.3.1 Org 引用
(package! org-ref :pin "3ca9beb744621f007d932deb8a4197467012c23a")
;; 4.3.2.3.2 Julia 支持
;; (package! ob-julia :recipe (:local-repo "lisp/ob-julia" :files ("*.el" "julia")))
;; 4.3.2.3.3 HTTP 请求
;; (package! ob-http :pin "b1428ea2a63bcb510e7382a1bf5fe82b19c104a7")
;; 4.3.2.3.4 Transclusion
;; (package! org-transclusion :recipe (:host github :repo "nobiot/org-transclusion")
;;   :pin "8cbbade1e3237200c2140741f39ff60176e703e7")
;; 4.3.2.3.5 Heading graph
;; (package! org-graph-view :recipe (:host github :repo "alphapapa/org-graph-view") :pin "13314338d70d2c19511efccc491bed3ca0758170")
;; 4.3.2.3.6 Cooking recipes
;; (package! org-chef :pin "a97232b4706869ecae16a1352487a99bc3cf97af")
;; 4.3.2.3.7 Improting with Pandoc
(package! org-pandoc-import
  :recipe (:host github
           :repo "tecosaur/org-pandoc-import"
           :files ("*.el" "filters" "preprocessors")))
;; 4.3.2.3.8 文件比较
;; (package! orgdiff :recipe (:local-repo "lisp/orgdiff"))

;; 4.3.3 表现
;; 4.3.3. Super Agenda
;; (package! org-super-agenda :pin "3108bc3f725818f0e868520d2c243abe9acbef4e")

;; 4.3.3.4 Capture
(package! doct
  :recipe (:host github :repo "progfolio/doct")
  :pin "67fc46c8a68989b932bce879fbaa62c6a2456a1f")

;; org-fragtog
(package! org-fragtog)

;; org-reveal
;; (package! ox-reveal)

;; sqlformat
;; (package! sqlformat)
