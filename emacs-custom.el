(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ConTeXt-Mark-version "IV" t)
 '(ansi-color-faces-vector
   [default default default italic underline success warning error])
 '(ansi-color-names-vector
   ["#242424" "#e5786d" "#95e454" "#cae682" "#8ac6f2" "#333366" "#ccaa8f" "#f6f3e8"])
 '(auto-revert-interval 3)
 '(backup-by-copying t)
 '(backup-directory-alist (quote (("." . "~/.emacs.d/backup"))))
 '(before-save-hook
   (quote
    (ada-before-save straight-register-file-modification delete-trailing-whitespace)))
 '(bmkp-bmenu-state-file "~/.emacs.d/emacs-bookmarks/.bmk-bmenu-state.el")
 '(bmkp-last-as-first-bookmark-file "~/.emacs.d/emacs-bookmarks/bmk.emacs")
 '(bookmark-default-file "~/.emacs.d/emacs-bookmarks/bmk.emacs")
 '(custom-enabled-themes (quote (tsdh-dark)))
 '(indent-tabs-mode nil)
 '(org-id-link-to-org-use-id (quote create-if-interactive-and-no-custom-id))
 '(python-fill-docstring-style (quote symmetric))
 '(recentf-auto-cleanup (quote never))
 '(recentf-mode nil)
 '(safe-local-variable-values
   (quote
    ((eval load "~/workspace/ada_test_architectures/src/.emacs_prj_settings/utils-test")
     (eval load "~/workspace/ada_test_architectures/src/.emacs_prj_settings/ata-repository-test")
     (eval load "~/workspace/ada_test_architectures/src/.emacs_prj_settings/ata-model-service-test")
     (eval load "~/workspace/ada_test_architectures/src/.emacs_prj_settings/ata-model-object-test")
     (eval load "~/workspace/ada_test_architectures/src/.emacs_prj_settings/ata-application-service-test")
     (eval load "~/workspace/ada_test_architectures/src/.emacs_prj_settings/ata-application-object-test")
     (eval load "~/workspace/ada_test_architectures/src/.emacs_prj_settings/ata-application-object")
     (eval load "~/workspace/ada_test_architectures/src/.emacs_prj_settings/ata-model-service")
     (eval load "~/workspace/ada_test_architectures/src/.emacs_prj_settings/ata-repository")
     (eval load "~/workspace/ada_test_architectures/src/.emacs_prj_settings/ata-model-object")
     (eval load "~/workspace/ada_test_architectures/src/.emacs_prj_settings/run")))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:inherit nil :stipple nil :background "#050000" :foreground "#bbe0f0" :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight normal :height 120 :width normal :foundry "outline" :family "Courier New")))))
