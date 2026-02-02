(use-package evil
  :ensure t
  :config
  (evil-mode 1)) 

(use-package evil-collection
  :after evil
  :config
  (evil-collection-init))

(load-theme 'base16-stylix t)

(push '(menu-bar-lines . 0) default-frame-alist)
(push '(tool-bar-lines . nil) default-frame-alist)
(push '(vertical-scroll-bars . nil) default-frame-alist)

(use-package vertico
  :config
  (vertico-mode))

(use-package projectile
  :config
  (projectile-mode))

(use-package general
  :config
  (general-evil-setup t)
  (general-define-key
    :states 'motion
    :prefix "SPC"
    :keymaps 'override
    "SPC" 'save-buffer
    "/ f" 'find-file
    "p" 'projectile-command-map
    "/ r" 'consult-ripgrep
    "b b" 'consult-buffer))

  (general-def 'normal
    "/" 'swiper)

(setq scroll-step 1
      scroll-margin 7
      scroll-conservatively 100000)

(use-package nix-mode)

(use-package color-identifiers-mode
  :config
  (global-color-identifiers-mode))

(use-package which-key
  :config
  (setq which-key-idle-delay 0.01)
  (which-key-mode))

(use-package highlight-thing
  :config
  (global-highlight-thing-mode))

(use-package hl-todo
  :config
  (global-hl-todo-mode))

(use-package indent-guide
  :config
  (indent-guide-global-mode))

(use-package whitespace-cleanup-mode
  :config
  (global-whitespace-cleanup-mode))

(use-package magit)
(use-package git-link)
(use-package swiper)
