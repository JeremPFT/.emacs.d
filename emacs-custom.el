(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(org-directory "~/workspace/org")
 '(safe-local-eval-forms
   '((add-hook 'write-file-hooks 'time-stamp)
     (add-hook 'write-file-functions 'time-stamp)
     (add-hook 'before-save-hook 'time-stamp nil t)
     (add-hook 'before-save-hook 'delete-trailing-whitespace nil t)))
 '(safe-local-variable-values
   '((checkdoc-minor-mode . 1)
     (eval when
           (and
            (buffer-file-name)
            (not
             (file-directory-p
              (buffer-file-name)))
            (string-match-p "^[^.]"
                            (buffer-file-name)))
           (unless
               (featurep 'package-build)
             (let
                 ((load-path
                   (cons "../package-build" load-path)))
               (require 'package-build)))
           (unless
               (derived-mode-p 'emacs-lisp-mode)
             (emacs-lisp-mode))
           (package-build-minor-mode)
           (setq-local flycheck-checkers nil)
           (set
            (make-local-variable 'package-build-working-dir)
            (expand-file-name "../working/"))
           (set
            (make-local-variable 'package-build-archive-dir)
            (expand-file-name "../packages/"))
           (set
            (make-local-variable 'package-build-recipes-dir)
            default-directory))
     (csv-separators ";")
     (eval progn "README.org: evaluate all blocks without confirmation:"
           (setq org-confirm-babel-evaluate nil))
     (eval setq org-confirm-babel-evaluate nil)
     (eval progn
           (setq ada-build-make-cmd "gprbuild ${gpr_file} -XBUILD_TYPE=debug")
           (setq ada-build-run-cmd "export BUILD_TYPE=debug && cd ~/workspace/ada_utils/bin && ./run")
           (setq ada-build-prompt-prj 'prompt))
     (eval add-hook 'before-save-hook
           (lambda nil
             (org-babel-ref-resolve "add-local-pwd-to-copy-paste"))
           nil t)
     (org-tags-column . -80)
     (eval add-hook 'before-save-hook
           (lambda nil
             (org-babel-ref-resolve "local-code"))
           nil t)
     (eval progn
           (org-babel-goto-named-src-block "local-code")
           (org-babel-execute-src-block))
     (eval progn
           (org-babel-goto-named-src-block "local-code")
           (org-babel-execute-src-block)
           (outline-hide-sublevels 1))
     (eval progn
           (setq ada-build-make-cmd "gprbuild ${gpr_file} -XBUILD_TYPE=debug")
           (setq ada-build-run-cmd "set BUILD_TYPE=DEBUG && cd ~/workspace/ada_test_architectures/bin && ./run")
           (setq ada-build-prompt-prj 'prompt))
     (eval progn
           (org-babel-tangle)
           (load-file "output/datasys-1.el"))))
 '(tab-width 2))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
