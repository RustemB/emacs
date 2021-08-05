;;; init.el --- Rustem B.'s Emacs config file.           -*- lexical-binding: t; -*-

;;; Commentary:

;;; Code:

(setq custom-file (expand-file-name "custom.el" user-emacs-directory))


(setq ring-bell-function #'ignore)
(setq inhibit-startup-screen t)
(setq initial-scratch-message nil)
(blink-cursor-mode -1)
(scroll-bar-mode -1)
(tool-bar-mode -1)
(menu-bar-mode -1)
(line-number-mode)
(column-number-mode)

(show-paren-mode t)
(setq show-paren-style 'expression)

(set-frame-font "monospace")
(set-face-attribute 'default nil :height 180)

(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(use-package srcery-theme
  :ensure t
  :config
  (load-theme 'srcery t))

(use-package lsp-mode
  :ensure t)

(use-package magit
  :ensure t)

(use-package highlight-defined
  :ensure t
  :hook (emacs-lisp-mode . highlight-defined-mode))

(use-package elcord
  :ensure t
  :init (elcord-mode)
  :config (setq elcord-editor-icon "emacs_material_icon"))

;;; init.el ends here
