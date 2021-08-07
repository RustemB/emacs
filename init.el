;;; init.el --- Rustem B.'s Emacs config file.       -*- lexical-binding: t; -*-

;;; Commentary:

;; This is my personal Emacs configuration.

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

(set-frame-font "monospace")
(set-face-attribute 'default nil :height 180)

(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(use-package paren
  :ensure t
  :config
  (show-paren-mode t)
  (setq show-paren-style 'expression))

(use-package srcery-theme
  :ensure t
  :config
  (load-theme 'srcery t))

(use-package lsp-mode
  :ensure t
  :init (setq lsp-keymap-prefix "C-c l")
  :hook ((python-mode . lsp)
	 (c-mode . lsp)
	 (c++-mode . lsp)
	 (prolog-mode . lsp)
	 (rust-mode . lsp)
	 (sh-mode . lsp))
  :config
  (setq lsp-rust-library-directories '("~/.config/cargo/registry/src"
				       "~/.config/rustup/toolchains"))
  (lsp-register-client
   (make-lsp-client
    :new-connection
    (lsp-stdio-connection (list "swipl"
				"-g" "use_module(library(lsp_server))."
				"-g" "lsp_server:main"
				"-t" "halt"
				"--" "stdio"))
    :major-modes '(prolog-mode)
    :priority 1
    :multi-root t
    :server-id 'prolog-ls)))

(use-package magit
  :ensure t)

(use-package highlight-defined
  :ensure t
  :hook (emacs-lisp-mode . highlight-defined-mode))

(use-package elcord
  :ensure t
  :init (elcord-mode)
  :config (setq elcord-editor-icon "emacs_material_icon"))

(use-package rust-mode
  :ensure t
  :config (setq rust-format-on-save t))

(use-package which-key
  :ensure t
  :config (which-key-mode))

;;; init.el ends here
