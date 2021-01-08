(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(safe-local-variable-values
   '((eval progn
           (setq ada-build-make-cmd "gprbuild ${gpr_file} -XBUILD_TYPE=debug")
           (setq ada-build-run-cmd "set BUILD_TYPE=DEBUG && cd ~/workspace/ada_test_architectures/bin && ./run")
           (setq ada-build-prompt-prj 'prompt))
     (eval progn
           (org-babel-tangle)
           (load-file "output/datasys-1.el")))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
