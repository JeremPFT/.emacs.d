(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(org-agenda-files
   (quote
    ("~/workspace/org/bookmarks/z/bookmarks-z-session.org.txt" "c:/Users/jeremy/AppData/Roaming/workspace/org/agenda/dates.org" "c:/Users/jeremy/AppData/Roaming/workspace/org/agenda/pauses.org" "~/workspace/org/reference-cards/emacs-reference-card.org" "~/.emacs.d/lisp/yasnippet/org-snippet-new-link.org" "~/.emacs.d/README.org")))
 '(safe-local-variable-values
   (quote
    ((eval let
           ((elisp-file "output/cnd-161.el"))
           (make-directory "output" t)
           (unless
               (file-exists-p elisp-file)
             (org-babel-tangle))
           (load-file elisp-file))
     (eval load "~/workspace/ada_test_architectures/src/.emacs_prj_settings/utils-test")
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
 )
