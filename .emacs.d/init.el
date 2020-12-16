
;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.

;; some initial clean up
(scroll-bar-mode -1)     ; Disable visible scrollbar
(tool-bar-mode -1)       ; Disable the toolbar
(tooltip-mode -1)        ; Disable tooltip
(set-fringe-mode 10)     ; Make extra space

(menu-bar-mode -1)       ; Disable menu bar

;; set visible bell
(setq visible-bell t)

;; set font
(set-face-attribute 'default nil :font "DejaVu Sans Mono" :height 110)


;; Initialize package sources
(require 'package)

(setq package-archives
             '(("melpa" . "https://melpa.org/packages/")
             ("org" . "https://orgmode.org/elpa/")
             ("elpa" . "https://elpa.gnu.org/packages/")
	     ))

(package-initialize)
(unless package-archive-contents
    (package-refresh-contents))

;; Initialize use-package on non-Linux platforms
(unless (package-installed-p 'use-package)
  (package-install 'use-package))

(require 'use-package)
(setq use-package-always-ensure t)


;; TRY IVY
(use-package ivy)
  (ivy-mode 1)

(use-package doom-modeline
  :ensure t
  :init (doom-modeline-mode 1)
  :custom ((doom-modeline-height 15)))

(use-package doom-themes)
(require 'doom-themes)

;; set theme
(load-theme 'doom-nord-light t)

(doom-themes-visual-bell-config)

;; Make ESC quite prompts
(global-set-key (kbd "<escape>") 'keyboard-escape-quit)

;; Evil Leader
(use-package evil-leader)
(require 'evil-leader)

(global-evil-leader-mode)
(evil-leader/set-leader "<SPC>")

(evil-leader/set-key
  "." 'find-file
  "b" 'switch-to-buffer
  )

(defun air-pop-to-org-agenda (&optional split)
  "Visit the org agenda, in the current window or a SPLIT."
  (interactive "P")
  (org-agenda nil "d")
  (when (not split)
    (delete-other-windows)))

(defun air-pop-to-org-capture (&optional split)
  "Visit the org capture todo, in the current window or a SPLIT."
  (interactive "P")
  (org-capture nil "t")
  (when (not split)
    (delete-other-windows)))

;; org mode keybindings
(evil-leader/set-key
  "d" 'air-pop-to-org-agenda
  "a" 'org-agenda
  "c" 'air-pop-to-org-capture
  "s" 'org-capture-finalize
  "k" 'org-capture-kill
  "w" 'org-refile
  )

;; Enable Evil
(use-package evil)
(require 'evil)
(evil-mode 1)



;; HELM
;;(require 'helm)
;;(require 'helm-config)

;;(define-key helm-map (kbd "<tab>") 'helm-execute-persistent-action)
;;(define-key helm-map (kbd "TAB") 'helm-execute-persistent-action)

;;(global-set-key (kbd "C-x C-f") 'helm-find-files)

;;(helm-mode 1)

;(setq-default helm-M-x-fuzzy-match t)

;; Make it look better

(use-package org
  :config
  (setq org-ellipsis " ↡"
	org-hide-emphasis-markers t
	))

(require 'org-bullets)
(add-hook 'org-mode-hook (lambda () (org-bullets-mode 1)))

;; GTD stuff
(load "~/gtd.el")


(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
    (evil-org evil-leader use-package org-superstar org-bullets ivy-rich helm forge evil doom-themes doom-modeline counsel command-log-mode))))

;; SET AUTOSAVE LOCATION
(setq auto-save-file-name-transforms
  `((".*" "~/.cache/emacs/" t)))
