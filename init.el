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
;; theme
;; (load-theme 'misterioso t)
(load-theme 'zenburn t)
;; (load-theme 'ujelly t)
;; (load-theme 'solarized t)
;; (load-theme 'monokai t)
;; (require 'color-theme-sanityinc-tomorrow)
(global-set-key (kbd "<f5>") 'redraw-display)
(setq ring-bell-function 'ignore);
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

;; AUTO-COMPLETE
(global-auto-complete-mode t)

;; AUTOPAIR
;; (autopair-global-mode t)

;; AC-JS2
(add-hook 'js2-mode-hook 'ac-js2-mode)
(setq ac-js2-evaluate-calls t)


;; COMPANY
(add-hook 'after-init-hook 'global-company-mode)
;; (add-to-list 'company-backends 'company-tern)

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

;; JS2-MODE
(require 'js2-mode)
(add-to-list 'auto-mode-alist '("\\.js\\'" . js2-mode))
(add-to-list 'interpreter-mode-alist '("node" . js2-mode))


;; ORG
(require 'org)
(add-to-list 'auto-mode-alist '("\\.org$" . org-mode))
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


;; MARKDOWN PREVIEW EWW
(require 'markdown-preview-eww)

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
(add-hook 'js-mode-hook #'smartparens-stric-mode)
(add-hook 'python-mode-hook #'smartparens-stric-mode)
(add-hook 'c-mode-hook #'smartparens-mode)
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


(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-faces-vector
   [default bold shadow italic underline bold bold-italic bold])
 '(ansi-color-names-vector
   (vector "#4d4d4c" "#c82829" "#718c00" "#eab700" "#4271ae" "#8959a8" "#3e999f" "#ffffff"))
 '(compilation-message-face (quote default))
;;  '(custom-enabled-themes (quote (sanityinc-tomorrow-night)))
;;  '(custom-safe-themes
;;    (quote
;;     ("bcc6775934c9adf5f3bd1f428326ce0dcd34d743a92df48c128e6438b815b44f" "40f6a7af0dfad67c0d4df2a1dd86175436d79fc69ea61614d668a635c2cd94ab" "1b8d67b43ff1723960eb5e0cba512a2c7a2ad544ddb2533a90101fd1852b426e" "c5b920660bf92b790b0173791880085a994bd61ff1fdd11cc766915c642aace5" "628278136f88aa1a151bb2d6c8a86bf2b7631fbea5f0f76cba2a0079cd910f7d" "82d2cac368ccdec2fcc7573f24c3f79654b78bf133096f9b40c20d97ec1d8016" "8db4b03b9ae654d4a57804286eb3e332725c84d7cdab38463cb6b97d5762ad26" "f9805a89d4309ca29b68c4a6b3d8f13f7931603e59b881515a27535d6ffa1a6e" "06f0b439b62164c6f8f84fdda32b62fb50b6d00e8b01c2208e55543a6337433a" "bb08c73af94ee74453c90422485b29e5643b73b05e8de029a6909af6a3fb3f58" "a802c77b818597cc90e10d56e5b66945c57776f036482a033866f5f506257bca" default)))
 ;;
 '(fci-rule-color "#d6d6d6")
 '(highlight-changes-colors (quote ("#FD5FF0" "#AE81FF")))
 '(highlight-tail-colors
   (quote
    (("#49483E" . 0)
     ("#679A01" . 20)
     ("#4BBEAE" . 30)
     ("#1DB4D0" . 50)
     ("#9A8F21" . 60)
     ("#A75B00" . 70)
     ("#F309DF" . 85)
     ("#49483E" . 100))))
 '(magit-diff-use-overlays nil)
 '(nrepl-message-colors
   (quote
    ("#CC9393" "#DFAF8F" "#F0DFAF" "#7F9F7F" "#BFEBBF" "#93E0E3" "#94BFF3" "#DC8CC3")))
 '(pos-tip-background-color "#A6E22E")
 '(pos-tip-foreground-color "#272822")
 '(sml/mode-width
   (if
       (eq
        (powerline-current-separator)
        (quote arrow))
       (quote right)
     (quote full)))
 '(sml/pos-id-separator
   (quote
    (""
     (:propertize " " face powerline-active1)
     (:eval
      (propertize " "
                  (quote display)
                  (funcall
                   (intern
                    (format "powerline-%s-%s"
                            (powerline-current-separator)
                            (car powerline-default-separator-dir)))
                   (quote powerline-active1)
                   (quote powerline-active2))))
     (:propertize " " face powerline-active2))))
 '(sml/pos-minor-modes-separator
   (quote
    (""
     (:propertize " " face powerline-active1)
     (:eval
      (propertize " "
                  (quote display)
                  (funcall
                   (intern
                    (format "powerline-%s-%s"
                            (powerline-current-separator)
                            (cdr powerline-default-separator-dir)))
                   (quote powerline-active1)
                   (quote sml/global))))
     (:propertize " " face sml/global))))
 '(sml/pre-id-separator
   (quote
    (""
     (:propertize " " face sml/global)
     (:eval
      (propertize " "
                  (quote display)
                  (funcall
                   (intern
                    (format "powerline-%s-%s"
                            (powerline-current-separator)
                            (car powerline-default-separator-dir)))
                   (quote sml/global)
                   (quote powerline-active1))))
     (:propertize " " face powerline-active1))))
 '(sml/pre-minor-modes-separator
   (quote
    (""
     (:propertize " " face powerline-active2)
     (:eval
      (propertize " "
                  (quote display)
                  (funcall
                   (intern
                    (format "powerline-%s-%s"
                            (powerline-current-separator)
                            (cdr powerline-default-separator-dir)))
                   (quote powerline-active2)
                   (quote powerline-active1))))
     (:propertize " " face powerline-active1))))
 '(sml/pre-modes-separator (propertize " " (quote face) (quote sml/modes)))
 '(vc-annotate-background nil)
 '(vc-annotate-color-map
   (quote
    ((20 . "#c82829")
     (40 . "#f5871f")
     (60 . "#eab700")
     (80 . "#718c00")
     (100 . "#3e999f")
     (120 . "#4271ae")
     (140 . "#8959a8")
     (160 . "#c82829")
     (180 . "#f5871f")
     (200 . "#eab700")
     (220 . "#718c00")
     (240 . "#3e999f")
     (260 . "#4271ae")
     (280 . "#8959a8")
     (300 . "#c82829")
     (320 . "#f5871f")
     (340 . "#eab700")
     (360 . "#718c00"))))
 '(vc-annotate-very-old-color nil)
 '(weechat-color-list
   (unspecified "#272822" "#49483E" "#F70057" "#F92672" "#86C30D" "#A6E22E" "#BEB244" "#E6DB74" "#40CAE4" "#66D9EF" "#FB35EA" "#FD5FF0" "#74DBCD" "#A1EFE4" "#F8F8F2" "#F8F8F0")))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
