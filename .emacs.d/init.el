
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
(set-face-attribute 'default nil :font "DejaVu Sans Mono" :height 120)

;; set theme
(load-theme 'wombat)

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

(use-package command-log-mode)

;; TRY IVY
(use-package ivy)
(ivy-mode 1)

(use-package doom-modeline
  :ensure t
  :init (doom-modeline-mode 1)
  :custom ((doom-modeline-height 15)))

;; Make ESC quite prompts
(global-set-key (kbd "<escape>") 'keyboard-escape-quit)

;; Download Evil
;;(unless (package-installed-p 'evil)
;;(package-install 'evil))

;; Enable Evil
(add-to-list 'load-path "~/.emacs.d/evil")
(require 'evil)
(evil-mode 1)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
    (doom-modeline command-log-mode use-package ivy helm evil))))

;; start with agenda
;;(add-hook 'after-init-hook 'org-agenda-list)
;;(delete-other-windows)

;; Shortcut for eval-buffer


;; HELM
;;(require 'helm)
;;(require 'helm-config)

;;(define-key helm-map (kbd "<tab>") 'helm-execute-persistent-action)
;;(define-key helm-map (kbd "TAB") 'helm-execute-persistent-action)

;;(global-set-key (kbd "C-x C-f") 'helm-find-files)

;;(helm-mode 1)

;(setq-default helm-M-x-fuzzy-match t)

;; GTD stuff

(setq default-directory "~/Documents/gtd/")

(global-set-key "\C-ca" 'org-agenda)
(global-set-key "\C-cc" 'org-capture)
(global-set-key "\C-cl" 'org-store-link)

;; set tags
(setq org-tag-alist '(("@errand" . ?e) ("@office" . ?o)))

;; agenda
(setq org-agenda-files (append '(
			 "~/Documents/gtd/inbox.org"
			 "~/Documents/gtd/main.org"
			 "~/Documents/gtd/sahelsounds.org"
			 "~/Documents/gtd/someday.org"
			 "~/Documents/gtd/tickler.org")
			 (file-expand-wildcards "~/Documents/gtd/recordproj/*.org")))

(setq org-agenda-custom-commands
      '(("w" todo "WAITING" nil)
	("n" todo "NEXT" nil)
	("o" tags "@office" nil)
	("f" "forecast"
	 ((agenda "" ((org-agenda-span 3)))
	              ;; limits to three days
	  (todo "NEXT"))
	 ((org-agenda-compact-blocks t)))
      ))

(setq org-capture-templates '(("t" "Todo [inbox]" entry
			       (file+headline "~/Documents/gtd/inbox.org" "Tasks")
			       "* TODO %i%?")
			      ("T" "Tickler" entry
			       (file+headline "~/Documents/gtd/tickler.org" "Tickler")
			       "* %i%? \n %U")))

;; set the deadline to show for items due in 5 days
(setq org-deadline-warning-days 5)

;; trying things out
(setq org-agenda-start-with-log-mode t)
(setq org-log-done 'time)
(setq org-log-into-drawer t)


;; REFILING
(setq org-refile-targets (quote (
				 (org-agenda-files :maxlevel . 1)
				 )))

(setq org-refile-use-outline-path 'file)
(setq org-outline-path-complete-in-steps nil)
(setq org-refile-allow-creating-parent-nodes 'confirm)

;(setq org-refile-targets (append '(
;				   ("~/Documents/gtd/main.org" :maxlevel . 3)
;				   ("~/Documents/gtd/sahelsounds.org" :maxlevel . 3)
;				   ("~/Documents/gtd/someday.org" :maxlevel . 1)
;				   ("~/Documents/gtd/tickler.org" :maxlevel . 2))
;			 (file-expand-wildcards "~/Documents/gtd/recordproj/*.org" :maxlevel . 2)))

;; select keywords
(setq org-todo-keywords '((sequence "TODO(t)" "NEXT(n)" "WAITING(w)" "|" "DONE(d)")))

(setq org-todo-keyword-faces
      (quote (("TODO" :foreground "red" :weight bold)
	      ("NEXT" :foreground "blue" :weight bold)
	      ("WAITING" :foreground "pink" :weight bold)
	      ("DONE" :foreground "forest green" :weight bold))))

;; Generate the startup screen
(setq inhibit-startup-screen t)
;;(org-agenda nil "f")
;;(delete-other-windows)

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
