
;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.

;; Set up package.el to work with MELPA
(require 'package)
(add-to-list 'package-archives
             '("melpa" . "https://melpa.org/packages/"))
(package-initialize)
(package-refresh-contents)

;; Download Evil
(unless (package-installed-p 'evil)
  (package-install 'evil))

;; Enable Evil
(require 'evil)
(evil-mode 1)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages (quote (helm evil))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;; Disable welcome screen
(setq inhibit-startup-screen t)

;; HELM
(require 'helm)
(require 'helm-config)

(helm-mode 1)

(setq-default helm-M-x-fuzzy-match t)

;; GTD stuff
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

;; REFLIING
(setq org-refile-targets (quote (
				 (org-agenda-files :maxlevel . 3)
				 )))

(setq org-refile-use-outline-path 'file)

;(setq org-refile-targets (append '(
;				   ("~/Documents/gtd/main.org" :maxlevel . 3)
;				   ("~/Documents/gtd/sahelsounds.org" :maxlevel . 3)
;				   ("~/Documents/gtd/someday.org" :maxlevel . 1)
;				   ("~/Documents/gtd/tickler.org" :maxlevel . 2))
;			 (file-expand-wildcards "~/Documents/gtd/recordproj/*.org" :maxlevel . 2)))

(setq org-todo-keywords '((sequence "TODO(t)" "WAITING(w)" "NEXT(n)" "|" "DONE(d)")))

(setq org-todo-keyword-faces
      (quote (("TODO" :foreground "red" :weight bold)
	      ("NEXT" :foreground "blue" :weight bold)
	      ("WAITING" :foreground "pink" :weight bold)
	      ("DONE" :foreground "forest green" :weight bold))))
