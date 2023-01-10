;;; package --- summary
(setq package-archives '(("gnu"   . "http://mirrors.tuna.tsinghua.edu.cn/elpa/gnu/")
                         ("melpa" . "http://mirrors.tuna.tsinghua.edu.cn/elpa/melpa/")))

;; Minimize garbage collection during startup
(setq gc-cons-threshold most-positive-fixnum)

;; Lower threshold back to 8 MiB (default is 800kB)
(add-hook 'emacs-startup-hook
          (lambda ()
            (setq gc-cons-threshold (expt 2 23))))

;; increase the amount of data which to read once to 64kB
(setq read-process-output-max (expt 2 16))

(package-initialize) ;; You might already have this line
;;; basic
(defconst *spell-check-support-enabled* nil)
;;; Commentary:
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(add-to-list 'default-frame-alist t)
 '(column-number-mode t)
 '(custom-enabled-themes '(monokai))
 '(custom-safe-themes
   '("78e6be576f4a526d212d5f9a8798e5706990216e9be10174e3f3b015b8662e27" "d9646b131c4aa37f01f909fbdd5a9099389518eb68f25277ed19ba99adeb7279" "f3ab34b145c3b2a0f3a570ddff8fabb92dafc7679ac19444c31058ac305275e1" "a2cde79e4cc8dc9a03e7d9a42fabf8928720d420034b66aecc5b665bbf05d4e9" default))
 '(electric-indent-mode t)
 '(indent-tabs-mode nil)
 '(inhibit-startup-screen t)
 '(js-indent-level 2)
 '(package-selected-packages
   '(compat go-mode lsp-origami origami monokai-theme counsel bazel company-lua lua-mode rustic protobuf-mode flycheck lsp-ui company yasnippet lsp-mode evil use-package which-key)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:weight normal :height 96 :width normal :foundry "SRC" :family "Hack")))))

;;; Commantary:
(eval-when-compile
  (require 'use-package))

;;; Code:
(setq-default indent-tabs-mode nil)
(setq backup-directory-alist
      `((".*" . ,temporary-file-directory)))
(setq auto-save-file-name-transforms
      `((".*" ,temporary-file-directory t)))

(use-package monokai-theme
  :ensure t)

(use-package evil
 :ensure t
 :demand t
 :bind (:map evil-motion-state-map (("C-u" . evil-scroll-up)))
 :config (evil-mode 1))

(use-package counsel
  :init
  (setq ivy-use-virtual-buffers t)
  (setq ivy-count-format "%d/%d ")
  :bind ("M-x" . counsel-M-x)
  :config (ivy-mode 1))

(use-package flycheck
 :config (global-flycheck-mode))

(use-package which-key
 :config (which-key-mode 1))

(use-package yasnippet
  :hook (prog-mode . yas-minor-mode-on))

(use-package lsp-mode
  :custom (setq rustic-lsp-server 'rust-analyzer)
  :init (setq lsp-clients-clangd-args '("--header-insertion-decorators=0" "--enable-config"))
  :init (setq lsp-keymap-prefix "C-c l")
  :hook (
   (go-mode . lsp-deferred)
   (js-mode . lsp-deferred)
   (lsp-mode . lsp-enable-which-key-integration))
  :commands (lsp lsp-deferred)
  :bind (:map lsp-mode-map (("<tab>" . lsp-execute-code-action))))

(use-package origami)
(use-package lsp-origami
  :hook (lsp-mode . lsp-origami-try-enable))

(use-package lsp-ui
  :commands lsp-ui-mode)

(use-package lsp-ivy
  :commands lsp-ivy-workspace-symbol)

(use-package which-key
  :config
  (which-key-mode))

(use-package rustic
  :ensure
  :config
  (setq rustic-format-on-save t))

(provide 'init)
;;; init.el ends here
