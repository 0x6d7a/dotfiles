;; PACKAGE INITIALIZATION
(require 'package)
(add-to-list 'package-archives '("melpa" . "http://melpa.milkbox.net/packages/") t)
(add-to-list 'package-archives '("melpa-stable" . "http://stable.melpa.org/packages/") t)
(add-to-list 'load-path "~/.emacs.d/plugin/")
(add-to-list 'load-path "~/.emacs.d/lisp/")
(package-initialize)

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(defvar myPackages
  '(better-defaults
	elpy ;; Add elpy package
	flycheck ;; Add flycheck package
    magit
    neotree
    yasnippet
    company
    window-numbering
    smart-mode-line
    smex
    markdown-mode
;;    exec-path-from-shell-copy
    smartparens
    helm
    sublime-themes
    multiple-cursors
    expand-region
    helm-company
    helm-swoop
    ace-jump-mode
    expand-region
	material-theme))

(mapc #'(lambda (package)
		  (unless (package-installed-p package)
			(package-install package)))
	  myPackages)


;; BASIC CUSTOMIZATION
(setq inhibit-splash-screen t)
(setq inhibit-startup-buffer-menu)
;; theme
(load-theme 'spolsky t)
(global-set-key (kbd "C-<f5>") 'redraw-display)
(setq visible-bell nil)
(setq ring-bell-function (lambda()
                         (invert-face 'mode-line)
                         (run-with-timer 0.1 nil 'invert-face 'mode-line)))
(tool-bar-mode -1)
(menu-bar-mode -1)
(scroll-bar-mode -1)
(set-face-attribute 'default nil :height 125)
(display-time-mode)
(global-linum-mode t) ;; Display line number
(define-key global-map (kbd "M-g") 'goto-line) ;; Modify goto line key
(global-hl-line-mode t) ;; Highlight current line
(column-number-mode 1) ;; Show column number
(setq-default tab-width 4) ;; Tap size
(set-keyboard-coding-system nil) ;; Meta key problem in Mac
(setq mac-option-key-is-meta nil
      mac-command-key-is-meta t
      mac-command-modifier 'meta
      mac-option-modifier 'none)
(global-visual-line-mode 1)
(toggle-truncate-lines 1)
(setq c-default-style "k&r" c-basic-offset 4)
(global-set-key (kbd "M-S-<left>") 'shrink-window-horizontally)
(global-set-key (kbd "M-S-<right>") 'enlarge-window-horizontally)
(global-set-key (kbd "M-S-<down>") 'shrink-window)
(global-set-key (kbd "M-S-<up>") 'enlarge-window)
(setq temporary-file-directory "~/temp/")
(setq backup-directory-alist `((".*" . ,temporary-file-directory)))
(setq auto-save-file-name-transforms `((".*" ,temporary-file-directory t)))
(nyan-mode t)
(setq gdb-many-windows t
      gdb-show-main t)

(global-set-key (kbd "M-`") 'other-frame)
(global-set-key (kbd "<f5>") (lambda()
                                  (interactive)
                                  (setq-local compilation-read-command nil)
                                  (call-interactively 'compile)))

;; ACE JUMP
(require 'ace-jump-mode)
(define-key global-map (kbd "C-c u") 'ace-jump-word-mode)
(define-key global-map (kbd "C-c C-u") 'ace-jump-char-mode)
(define-key global-map (kbd "C-c C-c C-u") 'ace-jump-line-mode)

;; CLEAN-AINDENT
(require 'clean-aindent-mode)
(clean-aindent-mode 1)

;; COMPANY
(add-hook 'after-init-hook 'global-company-mode)

;; ELPY
(require 'elpy)
(when (require 'flycheck nil t)
  (setq elpy-modules (delq 'elpy-module-flymake elpy-modules))
  (add-hook 'elpy-mode-hook 'flycheck-mode))
(elpy-enable)
(setq exec-path-from-shell-arguments '("-l"))
(exec-path-from-shell-copy-env "PATH")
(elpy-use-ipython)

;; EMMET
(require 'emmet-mode)
(add-hook 'html-mode-hook 'emmet-mode)
(add-hook 'css-mode-hook 'emmet-mode)


;; EXPAND-REGION
(require 'expand-region)
(global-set-key (kbd "C-=") 'er/expand-region)

;; EVIL
(require 'evil)
(defun toggle-evil-mode ()
  (interactive)
  (if (bound-and-true-p evil-local-mode)
      (progn
        (evil-local-mode (or -1 1))
        (undo-tree-mode (or -1 1))
        (set-variable 'cursor-type 'bar)
        )
    (progn
      (evil-local-mode (or 1 1))
      (set-variable 'cursor-type 'box)
      )
    )
  )
(global-set-key (kbd "M-u") 'toggle-evil-mode)
(evil-mode t)

;; FUNCTION ARGS
(require 'function-args)
(fa-config-default)

;; HELM
(require 'helm)
(require 'helm-company)
(require 'helm-config)
(require 'helm-swoop)
(global-set-key (kbd "M-i") 'helm-swoop)
(global-set-key (kbd "M-I") 'helm-swoop-back-to-last-point)
(global-set-key (kbd "C-c M-i") 'helm-multi-swoop)
(global-set-key (kbd "C-c M-I") 'helm-multi-swoop-all)
(setq helm-multi-swoop-edit-save t)
(define-key helm-map (kbd "<tab>") 'helm-execute-persistent-action)

(global-set-key (kbd "C-x b") 'helm-buffers-list)
(global-set-key (kbd "C-x r b") 'helm-bookmarks)
(global-set-key (kbd "M-x") 'helm-M-x)
(global-set-key (kbd "M-y") 'helm-show-kill-ring)
(global-set-key (kbd "C-x C-f") 'helm-find-files)

(eval-after-load 'company
  '(progn
     (define-key company-mode-map (kbd "C-;") 'helm-company)
     (define-key company-active-map (kbd "C-;") 'helm-company)))


;; LINENUM RELATIVE
(require 'linum-relative)
(linum-on)

;; JS2-MODE
(require 'js2-mode)
(add-to-list 'auto-mode-alist '("\\.js\\'" . js2-mode))
(add-to-list 'interpreter-mode-alist '("node" . js2-mode))


;; KEY-CHORD
;; (require 'key-chord)
;; (key-chord-mode 1)
;; (key-chord-define-global "" (kbd "<escape>"))

;; ORG
(add-to-list 'auto-mode-alist '("\\.\\(org\\|org_archive\\|txt\\)$" . org-mode))
(require 'org)
(org-babel-do-load-languages
 'org-babel-load-languages
 '(
   (sh . t)
   (python . t)
   (R . t)
   (ruby . t)
   (perl . t)
   (C . t))
 )
(setq org-directory "~/Dropbox/Org")
(setq org-default-notes-file (concat org-directory "/notes.org"))
(setq org-log-done 'time)
(setq org-export-coding-system 'utf-8)
(setq org-latex-inputenc-alist '(("utf8" . "utf8x")))
;; Standard key bindings
(global-set-key "\C-cl" 'org-store-link)
(global-set-key "\C-ca" 'org-agenda)
(global-set-key "\C-cb" 'org-switchb)
(global-set-key "\C-cc" 'org-capture)
(global-set-key (kbd "C-c o")
                (lambda () (interactive) (find-file "~/Dropbox/Org/gtd.org")))
(global-set-key (kbd "C-c m")
                (lambda () (interactive) (find-file "~/Documents/Markdown/scratches.md")))
;; Org capture templates
(setq org-capture-templates
      (quote (("t" "Tasks" entry
               (file+headline "~/Dropbox/Org/refiles.org" "Inbox")
               "* TODO %^{Task}\nDEADLINE: %^t\n%?\n")
              ("T" "Quick Tasks" entry
               (file+headline "~/Dropbox/Org/refiles.org" "Inbox")
               "* TODO %^{Task}\n%t\n"
               :immediate-finish t)
              ("n" "Notes" entry
               (file+headline "~/Dropbox/Org/refiles.org" "Notes")
               "* %^{Note} \n%U\n%?")
              ("N" "Quick Notes" item
               (file+headline "~/Dropbox/Org/refiles.org" "Quick Notes"))
              ("j" "Journals" plain
               (file+datetree "~/Dropbox/Personal/journals.org")
               "**** %U %^{Title}\n%?"
               :unnarrowed t)
              )))

(require 'org-bullets)
(add-hook 'org-mode-hook (lambda () (org-bullets-mode 1)))


;; CC-MODE
;; (require 'cc-mode)
;; (define-key c-mode-map [(tab)] 'company-complete)
;; (define-key c++-mode-map [(tab)] 'company-complete)


;; MARKDOWN MODE
(autoload 'markdown-mode "markdown-mode"
  "Major mode for editing Markdown files" t)
(add-to-list 'auto-mode-alist '("\\.markdown\\'" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.md\\'" . markdown-mode))

;; MAGIT
(global-set-key (kbd "C-x g") 'magit-status)

;; MULTIPLE CURSORS
(require 'multiple-cursors)
(global-set-key (kbd "C-S-c C-S-c") 'mc/edit-lines)
(global-set-key (kbd "C-}") 'mc/mark-next-like-this)
(global-set-key (kbd "C-{") 'mc/mark-previous-like-this)
(global-set-key (kbd "C-c C-{") 'mc/mark-all-like-this)

;; NEOTREE
(require 'neotree)
(global-set-key (kbd "<f8>") 'neotree-toggle)

;; (require 'powerline)
;; (powerline-center-theme)

;; SMART MODE LINE
;; (require 'smart-mode-line)
;; (setq powerline-arrow-shape 'curve)
;; (setq powerline-default-separator-dir '(right . left))
;; (setq sml/theme 'powerline)
;; (setq sml/mode-width 0)
;; (setq sml/name-width 20)
;; (setq sml/no-confirm-load-theme t)
;; (sml/setup)

(require 'init-powerline)

;; SMARTPARENS
(require 'smartparens-config)
(add-hook 'html-mode-hook #'smartparens-mode)
(add-hook 'js-mode-hook #'smartparens-mode)
(add-hook 'python-mode-hook #'smartparens-mode)
(add-hook 'c-mode-hook #'smartparens-mode)
(add-hook 'markdown-mode-hook #'smartparens-mode)
(add-hook 'emacs-lisp-mode-hook #'smartparens-mode)
(sp-local-pair 'js2-mode "{" nil :post-handlers '((my-create-newline-and-enter-sexp "RET")))
(sp-with-modes '(c-mode c++-mode)
  (sp-local-pair "{" nil :post-handlers '(("||\n[i]" "RET")))
  (sp-local-pair "/*" "*/" :post-handlers '((" | " "SPC")
                                            ("* ||\n[i]" "RET"))))

(defun my-create-newline-and-enter-sexp (&rest_ignored)
  (newline)
  (indent-according-to-mode)
  (forward-line -1)
  (indent-according-to-mode))




;; SMEX
(global-set-key (kbd "C-x m") 'smex)
(global-set-key (kbd "M-X") 'smex-major-mode-commands)
(global-set-key (kbd "C-c C-c M-x") 'execute-extended-command) ;; This is the old M-x

;; UNDO-TREE
(global-set-key (kbd "M-/") 'undo-tree-visualize)

;; WEB MODE
(require 'web-mode)
(add-to-list 'auto-mode-alist '("\\.phtml\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.tpl\\.php\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.[agj]sp\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.as[cp]x\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.erb\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.mustache\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.djhtml\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.html\\'" . web-mode))
(setq web-mode-enable-current-column-highlight t)
(setq web-mode-enable-current-element-highlight t)

;; WINDOW NUMBERING
(window-numbering-mode 1)

;; WINNER
(winner-mode 1)

;; YASNIPPET
(setq yas-snippet-dirs
      '("~/.emacs.d/snippets"
        "~/.emacs.d/elpa/yasnippet-20160801.1142/snippets"
        ))
(require 'yasnippet)
(yas-global-mode 1)
(add-hook 'term-mode-hook (lambda()
                            (setq yas-dont-activate t)))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-faces-vector
   [default bold shadow italic underline bold bold-italic bold])
 '(ansi-color-names-vector
   (vector "#4d4d4c" "#c82829" "#718c00" "#eab700" "#4271ae" "#8959a8" "#3e999f" "#d6d6d6"))
 '(custom-safe-themes
   (quote
    ("0c29db826418061b40564e3351194a3d4a125d182c6ee5178c237a7364f0ff12" default)))
 '(fci-rule-color "#d6d6d6")
 '(markdown-enable-math t)
 '(org-agenda-files
   (quote
    ("~/Dropbox/Org/gtd.org" "~/Dropbox/Org/refiles.org")))
 '(org-hide-emphasis-markers t)
 '(org-hide-leading-stars t)
 '(org-modules
   (quote
    (org-bbdb org-bibtex org-docview org-gnus org-habit org-info org-irc org-mhe org-rmail org-w3m)))
 '(org-refile-targets (quote ((org-agenda-files :maxlevel . 6))))
 '(org-todo-keywords (quote ((sequence "TODO" "DOING" "DONE" "CANCLED")))))

;;; sRGB doesn't blend with Powerline's pixmap colors, but is only
;;; used in OS X. Disable sRGB before setting up Powerline.
(when (memq window-system '(mac ns))
  (setq ns-use-srgb-colorspace nil))

(provide 'init)
;;; init.el ends here
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(powerline-evil-normal-face ((t (:inherit powerline-evil-base-face :background "chartreuse3"))))
 '(term ((t (:foreground "ivory1"))))
 '(term-color-black ((t (:foreground "gray80"))))
 '(term-color-cyan ((t (:foreground "cyan2"))))
 '(term-color-green ((t (:foreground "OliveDrab3"))))
 '(term-color-yellow ((t (:foreground "gold1")))))
