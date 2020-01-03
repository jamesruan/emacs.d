;;; package --- summary
(setq package-archives '(("gnu"   . "http://mirrors.zju.edu.cn/elpa/gnu/")
                         ("melpa" . "http://mirrors.zju.edu.cn/elpa/melpa/")))
(package-initialize) ;; You might already have this line
;;; Commentary:
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-enabled-themes (quote (monokai)))
 '(custom-safe-themes
   (quote
    ("a2cde79e4cc8dc9a03e7d9a42fabf8928720d420034b66aecc5b665bbf05d4e9" default)))
 '(electric-indent-mode t)
 '(indent-tabs-mode nil)
 '(inhibit-startup-screen t)
 '(js-indent-level 2)
 '(package-selected-packages
   (quote
    (flycheck lsp-ui company-lsp yasnippet lsp-mode smart-tabs-mode monokai-theme molokai-theme evil ivy use-package smex))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:weight normal :height 96 :width normal :foundry "SRC" :family "Hack")))))

;;; Commantary:
(eval-when-compile
  (add-to-list 'load-path "elpa/use-package-20191126.2034")
  (require 'use-package))

;;; Code:
(setq-default indent-tabs-mode nil)

(require 'monokai-theme)
(use-package smex
 :config (smex-initialize))
(use-package evil
 :demand t
 :bind (:map evil-motion-state-map (("C-u" . evil-scroll-up)))
 :config (evil-mode 1))
(use-package ivy
 :config (ivy-mode 1))
(use-package flycheck
 :config (global-flycheck-mode))
(use-package lsp-mode
  :commands lsp
  :init (setq lsp-prefer-flymake nil)
  :hook js-mode)

;;; init ends here
