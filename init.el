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
   '("8dbbcb2b7ea7e7466ef575b60a92078359ac260c91fe908685b3983ab8e20e3f" "78e6be576f4a526d212d5f9a8798e5706990216e9be10174e3f3b015b8662e27" "d9646b131c4aa37f01f909fbdd5a9099389518eb68f25277ed19ba99adeb7279" "f3ab34b145c3b2a0f3a570ddff8fabb92dafc7679ac19444c31058ac305275e1" "a2cde79e4cc8dc9a03e7d9a42fabf8928720d420034b66aecc5b665bbf05d4e9" default))
 '(electric-indent-mode t)
 '(indent-tabs-mode nil)
 '(inhibit-startup-screen t)
 '(js-indent-level 2)
 '(package-selected-packages
   '(elysium markdown-mode gptel compat go-mode monokai-theme counsel rustic protobuf-mode company yasnippet evil)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

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

(use-package yasnippet
  :hook (prog-mode . yas-minor-mode-on))

(use-package rustic
  :ensure
  :config
  (setq rustic-format-on-save t))

(with-eval-after-load 'eglot
  (add-to-list 'eglot-server-programs
               '(c++-mode . ("/opt/homebrew/Cellar/llvm/19.1.3/bin/clangd" "--enable-config" "--background-index" "-j" "11"))))

(setq flymake-diagnostic-functions '(eglot-flymake-backend))
(setq flymake-fringe-indicator-position 'right-fringe)

(setq gptel-model 'deepseek-chat
      gptel-temperature	0
      gptel-backend
      (gptel-make-openai "DeepSeek"
        :host "api.deepseek.com"
        :endpoint "/chat/completions"
        :stream t
        ;;; api key in ~.autoinfo
        :key (auth-source-pick-first-password :host "api.deepseek.com")
        :models '(deepseek-chat)))

(use-package elysium)
(use-package smerge
  :ensure nil
  :hook
  (c++-mode . smerge-mode))
  

(provide 'init)
;;; init.el ends here
