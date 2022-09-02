;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets. It is optional.
(setq user-full-name "Mushi"
      user-mail-address "goodhelper007@outlook.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom:
;;
;; - `doom-font' -- the primary font to use
;; - `doom-variable-pitch-font' -- a non-monospace font (where applicable)
;; - `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;; - `doom-unicode-font' -- for unicode glyphs
;; - `doom-serif-font' -- for the `fixed-pitch-serif' face

;; Clock
(after! doom-modeline
  (setq display-time-string-forms
        '((propertize (concat " 🕘 " 24-hours ":" minutes))))
  (display-time-mode 1)) ; Enable time in the mode-line

;; Battery
(after! doom-modeline
  (let ((battery-str (battery)))
     (unless (or (equal "Battery status not available" battery-str)
                 (string-match-p (regexp-quote "unknown") battery-str)
                 (string-match-p (regexp-quote "N/A") battery-str))
      (display-battery-mode 1))))

;; Mode line customization
(after! doom-modeline
  (setq doom-modeline-major-mode-icon t
        doom-modeline-major-mode-color-icon t
        doom-modeline-buffer-state-icon t))

;; Frame sizing
(add-to-list 'default-frame-alist '(width . 150))
(add-to-list 'default-frame-alist '(height . 50))

;; Display fill column
;; (setq fill-column 120)

;; See 'C-h v doom-font' for documentation and more examples of what they
;; accept. For example:
;;
(setq doom-font (font-spec :family "Sarasa Mono SC Nerd" :size 18)
      ;; doom-variable-pitch-font (font-spec :family "Fira Sans" :size 13)
      )
;;
;; If you or Emacs can't find your font, use 'M-x describe-font' to look them
;; up, `M-x eval-region' to execute elisp code, and 'M-x doom/reload-font' to
;; refresh your font settings. If Emacs still can't find your font, it likely
;; wasn't installed correctly. Font issues are rarely Doom issues!

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'modus-vivendi)

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(require 'org)
(setq org-clock-sound "~/MEGA/org/clock.wav")
(setq org-directory "~/MEGA/org/")


;; Whenever you reconfigure a package, make sure to wrap your config in an
;; `after!' block, otherwise Doom's defaults may override your settings. E.g.
;;
;;   (after! PACKAGE
;;     (setq x y))
;;

;; Company
(after! company
  (setq company-idle-delay 0.5))
(setq-default history-length 1000)
(setq-default prescient-history-length 1000)

;; The exceptions to this rule:
;;
;;   - Setting file/directory variables (like `org-directory')
;;   - Setting variables which explicitly tell you to set them before their
;;     package is loaded (see 'C-h v VARIABLE' to look up their documentation).
;;   - Setting doom variables (which start with 'doom-' or '+').
;;
;; Here are some additional functions/macros that will help you configure Doom.
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
;; Alternatively, use `C-h o' to look up a symbol (functions, variables, faces,
;; etc).
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.

;; Pyim
;; (use-package)

;; Org-download
(use-package! org-download
  :ensure t
  :init
  (setq-default org-download-method 'directory)
  :config
  (setq-default org-download-image-dir "./img")
  (setq-default org-download-heading-lvl 'nil)
  )

;; Editorconfig
(use-package! editorconfig
  :ensure t
  :config
  (editorconfig-mode 1))
