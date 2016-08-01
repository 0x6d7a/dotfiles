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
;;    company-mode
    window-numbering
    smart-mode-line
    smex
    markdown-mode
;;    exec-path-from-shell-copy
    smartparens
    helm
    multiple-cursors
    expand-region
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
;; (load-theme 'misterioso t)
;; (load-theme 'zenburn t)
;; (load-theme 'ujelly t)
;; (load-theme 'solarized t)
;; (load-theme 'monokai t)
(load-theme 'spolsky t)
;; (require 'color-theme-sanityinc-tomorrow)
(global-set-key (kbd "<f5>") 'redraw-display)
(setq visible-bell nil)
;; (setq ring-bell-function 'ignore)
(setq ring-bell-function (lambda()
                           (invert-face 'mode-line)
                           (run-with-timer 0.1 nil 'invert-face 'mode-line)))
(tool-bar-mode -1)
(menu-bar-mode -1)
(scroll-bar-mode -1)
(set-face-attribute 'default nil :height 160)
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

;; ACE JUMP
(require 'ace-jump-mode)
(define-key global-map (kbd "C-c u") 'ace-jump-word-mode)
(define-key global-map (kbd "C-c C-u") 'ace-jump-char-mode)
(define-key global-map (kbd "C-c C-c C-u") 'ace-jump-line-mode)

;; AUTO-COMPLETE
(global-auto-complete-mode t)

;; AUTOPAIR
;; (autopair-global-mode t)

;; AC-JS2
(add-hook 'js2-mode-hook 'ac-js2-mode)
(setq ac-js2-evaluate-calls t)


;; COMPANY
(add-hook 'after-init-hook 'global-company-mode)

;; ELPY
(require 'elpy)
(when (require 'flycheck nil t)
  (setq elpy-modules (delq 'elpy-module-flymake elpy-modules))
  (add-hook 'elpy-mode-hook 'flycheck-mode))
(elpy-enable)
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

;; Flymake
(require 'flymake)

;; HELM
(require 'helm)
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
(global-set-key (kbd "C-x m") 'helm-M-x)
(global-set-key (kbd "M-y") 'helm-show-kill-ring)
(global-set-key (kbd "C-x C-f") 'helm-find-files)

;; LINENUM RELATIVE
(require 'linum-relative)
(linum-on)

;; JS2-MODE
(require 'js2-mode)
(add-to-list 'auto-mode-alist '("\\.js\\'" . js2-mode))
(add-to-list 'interpreter-mode-alist '("node" . js2-mode))


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
;; Standard key bindings
(global-set-key "\C-cl" 'org-store-link)
(global-set-key "\C-ca" 'org-agenda)
(global-set-key "\C-cb" 'org-iswitchb)

;; MARKDOWN PREVIEW EWW
;; (require 'markdown-preview-eww)
;; MARKDOWN MODE
(autoload 'markdown-mode "markdown-mode"
  "Major mode for editing Markdown files" t)
(add-to-list 'auto-mode-alist '("\\.markdown\\'" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.md\\'" . markdown-mode-hook))

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
(global-set-key (kbd "C-t") 'neotree-toggle)

;; NODEJS-REPL
(require 'nodejs-repl)

;; SKEWER MODE
(add-hook 'html-mode-hook 'skewer-mode)
(add-hook 'js2-mode-hook 'skewer-mode)
(add-hook 'css-mode-hook 'skewer-mode)

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
(add-hook 'js-mode-hook #'smartparens-stric-mode)
(add-hook 'python-mode-hook #'smartparens-stric-mode)
(add-hook 'c-mode-hook #'smartparens-mode)
(add-hook 'markdown-mode-hook #'smartparens-mode)
(add-hook 'emacs-lisp-mode-hook #'smartparens-mode)
(sp-local-pair 'js2-mode "{" nil :post-handlers '((my-create-newline-and-enter-sexp "RET")))

(defun my-create-newline-and-enter-sexp (&rest_ignored)
  (newline)
  (indent-according-to-mode)
  (forward-line -1)
  (indent-according-to-mode))


;; SMEX
(global-set-key (kbd "M-x") 'smex)
(global-set-key (kbd "M-X") 'smex-major-mode-commands)
(global-set-key (kbd "C-c C-c M-x") 'execute-extended-command) ;; This is the old M-x

;; TERN
;; (autoload 'tern-mode "tern.el" nil t)
;; (eval-after-load 'tern
;;    '(progn
;;       (require 'tern-auto-complete)
;;       (tern-ac-setup)))
;; (add-hook 'js-mode-hook (lambda () (tern-mode t)))

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

;; WINNER MODE
(winner-mode 1)

;; YASNIPPET
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
 '(org-hide-emphasis-markers t)
 '(org-modules
   (quote
    (org-bbdb org-bibtex org-docview org-gnus org-habit org-info org-irc org-mhe org-rmail org-w3m))))

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
