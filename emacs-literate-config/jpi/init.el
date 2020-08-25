(let ((file-name-handler-alist nil)
      (readme-elc "README.elc")
      (readme-org "README.org")
      (readme-org-fullname "")
      (working-directory "")
      (testing-p t)
      )

  (if testing-p
    (setq working-directory (file-name-as-directory
                             (concat
                              user-emacs-directory
                              (file-name-as-directory "emacs-literate-config")
                              (file-name-as-directory "jpi"))))
    (setq working-directory user-emacs-directory)
    )

  (setq readme-org-fullname (concat working-directory readme-org))

  ;; If config is pre-compiled, then load that
  (if (file-exists-p (concat working-directory readme-elc))
      (load-file (concat working-directory readme-elc))
    ;; Otherwise use org-babel to tangle and load the configuration
    (require 'org)
    (if testing-p
        (org-babel-tangle-file readme-org-fullname)
    (org-babel-load-file readme-org-fullname)))

)
