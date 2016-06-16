;; PACKAGE INITIALIZATION
(require 'package)
(add-to-list 'package-archives '("melpa" . "http://melpa.milkbox.net/packages/") t)
(add-to-list 'package-archives '("melpa-stable" . "http://stable.melpa.org/packages/") t)
(add-to-list 'load-path "~/.emacs.d/plugin/")
(package-initialize)


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
(load-theme 'misterioso t)
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
(define-key global-map (kbd "C-u") 'ace-jump-word-mode)
(define-key global-map (kbd "C-c C-u") 'ace-jump-char-mode)
(define-key global-map (kbd "C-c C-c C-u") 'ace-jump-line-mode)

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
;;(require 'evil)
;;(evil-mode 1)
;;(global-set-key (kbd "C-e") 'turn-on-evil-mode)
;;(global-set-key (kbd "C-e C-e") 'turn-off-evil-mode)

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

;; ORG
(require 'org)
(add-to-list 'auto-mode-alist '("\\.org$" . org-mode))

;; MARKDOWN PREVIEW EWW
(require 'markdown-preview-eww)

;; MAGIT
(global-set-key (kbd "C-x g") 'magit-status)

;; MULTIPLE CURSORS
(require 'multiple-cursors)
(global-set-key (kbd "C-S-c C-S-c") 'mc/edit-lines)
(global-set-key (kbd "C->") 'mc/mark-next-like-this)
(global-set-key (kbd "C-<") 'mc/mark-previous-like-this)
(global-set-key (kbd "C-c C-<") 'mc/mark-all-like-this)

;; NEOTREE
(require 'neotree)
(global-set-key (kbd "C-t") 'neotree-toggle)

;; SKEWER MODE
(add-hook 'html-mode-hook 'skewer-mode)
(add-hook 'js2-mode-hook 'skewer-mode)
(add-hook 'css-mode-hook 'skewer-mode)

;; SMART MODE LINE
(require 'smart-mode-line)
(setq powerline-arrow-shape 'curve)
(setq powerline-default-separator-dir '(right . left))
(setq sml/theme 'powerline)
(setq sml/mode-width 0)
(setq sml/name-width 20)
(setq sml/no-confirm-load-theme t)
(sml/setup)

;; SMARTPARENS
(require 'smartparens-config)
(add-hook 'html-mode-hook #'smartparens-mode)
(add-hook 'js-mode-hook #'smartparens-mode)
(add-hook 'python-mode-hook #'smartparens-mode)
(add-hook 'c-mode-hook #'smartparens-mode)
(add-hook 'emacs-lisp-mode-hook #'smartparens-mode)

;; SMEX
(global-set-key (kbd "M-x") 'smex)
(global-set-key (kbd "M-X") 'smex-major-mode-commands)
(global-set-key (kbd "C-c C-c M-x") 'execute-extended-command) ;; This is the old M-x

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


(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   (quote
	("a802c77b818597cc90e10d56e5b66945c57776f036482a033866f5f506257bca" default))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
