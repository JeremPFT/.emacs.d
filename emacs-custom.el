(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(safe-local-variable-values
   (quote
    ((eval progn
           (setq ada-build-make-cmd "gprbuild ${gpr_file} -XBUILD_TYPE=debug")
           (setq ada-build-run-cmd "export BUILD_TYPE=debug && cd ~/workspace/ada_test_architectures/bin && ./run")
           (setq ada-build-prompt-prj
                 (quote prompt)))
     (eval add-hook
           (quote before-save-hook)
           (lambda nil
             (org-babel-ref-resolve "add-local-pwd-to-copy-paste"))
           nil t)
     (org-tags-column . -80)
     (eval add-hook
           (quote before-save-hook)
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
           (setq ada-build-prompt-prj
                 (quote prompt)))
     (eval progn
           (org-babel-tangle)
           (load-file "output/datasys-1.el")))))
 '(tab-width 2))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
