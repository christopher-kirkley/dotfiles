;; GTD CONFIG

(global-set-key "\C-ca" 'org-agenda)
(global-set-key "\C-cc" 'org-capture)
(global-set-key "\C-cl" 'org-store-link)

(setq org-deadline-warning-days 5)



;; ================== TODOS ========================

;; trying out sequential projects

;; This is one way of using
;; by enforcing dependencies, prevents making something done
;; when previous entries are not done
;; but not really what i'm looking for
;; (setq org-enforce-todo-dependencies t)
;; C-c C-x o (org-toggle-ordered-property)

(defun add-sequential-project-property ()
  "Make sequential project property to the current item."
  (interactive)
  (org-set-property "TRIGGER" "chain-siblings(NEXT)"))

(add-hook 'org-capture-before-finalize-hook 'add-sequential_project_property)

;; ================== CAPTURE & PROCESS ========================

(setq org-capture-templates '(("t" "Todo [inbox]" entry
			       (file+headline "~/Documents/gtd/inbox.org" "Tasks")
			       "* TODO %i%?")
			      ("T" "Tickler" entry
			       (file+headline "~/Documents/gtd/tickler.org" "Tickler")
			       "* %i%? \n %U")))

;; start capture in insert mode
(use-package evil-org
  :hook (org-capture-mode . evil-insert-state))

;; set tags
(setq org-tag-alist '(("@errand" . ?e) ("@office" . ?o)))

(setq org-todo-keywords '((sequence "TODO(t)" "NEXT(n)" "WAITING(w)" "|" "DONE(d)")))

(setq org-todo-keyword-faces
      (quote (("TODO" :foreground "red" :weight bold)
	      ("NEXT" :foreground "cornflower blue" :weight bold)
	      ("WAITING" :foreground "orange" :weight bold)
	      ("DONE" :foreground "dark green" :weight bold))))

;; ================== AGENDA ========================

(setq org-agenda-files (append '(
			 "~/Documents/gtd/inbox.org"
			 "~/Documents/gtd/royaltyapp.org"
			 "~/Documents/gtd/main.org"
			 "~/Documents/gtd/sahelsounds.org"
			 "~/Documents/gtd/someday.org"
			 "~/Documents/gtd/tickler.org")
			 (file-expand-wildcards "~/Documents/gtd/recordproj/*.org")))

(setq org-agenda-custom-commands
      '(("d" "Dashboard"
	 ((agenda "" ((org-agenda-span 7))) ;; limits to seven days
	  (todo "NEXT"
                ((org-agenda-overriding-header "Next Tasks")))))
	 ;;((org-agenda-compact-blocks t)))
        ("w" todo "WAITING" nil)
	("n" todo "NEXT" nil)
	("o" tags "@office" nil)
      ))

(setq org-agenda-start-day "d")         ;; set start date
(setq org-agenda-span 7)                ;; set length of agenda
(setq org-agenda-start-on-weekday nil)  ;; set start day of week


;; ================== REFILING  ========================

(setq org-refile-targets (quote (
				 (org-agenda-files :maxlevel . 1)
				;; ("archive.org" :maxlevel . 1)
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


;; ================== STARTUP OPTIONS ========================

(setq inhibit-startup-screen t)
;;(org-agenda nil "f")
;;(delete-other-windows)

(setq default-directory "~/Documents/gtd/")



;; ================== OTHER ========================

(setq org-agenda-start-with-log-mode t)
(setq org-log-done 'time)
(setq org-log-into-drawer t)

;; save after refiling
(advice-add 'org-refile :after 'org-save-all-org-buffers)


;; AARON BIEBER MODE
(add-hook 'org-agenda-mode-hook (lambda ()
				  (define-key org-agenda-mode-map "j" 'org-agenda-next-item)
				  (define-key org-agenda-mode-map "k" 'org-agenda-previous-item)))

(defun air-org-agenda-next-header ()
  "Jump to the next header in an agenda series."
  (interactive)
  (air--org-agenda-goto-header))

(defun air-org-agenda-previous-header ()
  "Jump to the previous header in an agenda series."
  (interactive)
  (air--org-agenda-goto-header t))

(defun air--org-agenda-goto-header (&optional backwards)
  "Find the next agenda series header forwards or BACKWARDS."
  (let ((pos (save-excursion
               (goto-char (if backwards
                              (line-beginning-position)
                            (line-end-position)))
               (let* ((find-func (if backwards
                                     'previous-single-property-change
                                   'next-single-property-change))
                      (end-func (if backwards
                                    'max
                                  'min))
                      (all-pos-raw (list (funcall find-func (point) 'org-agenda-structural-header)
                                         (funcall find-func (point) 'org-agenda-date-header)))
                      (all-pos (cl-remove-if-not 'numberp all-pos-raw))
                      (prop-pos (if all-pos (apply end-func all-pos) nil)))
                 prop-pos))))
    (if pos (goto-char pos))
    (if backwards (goto-char (line-beginning-position)))))
