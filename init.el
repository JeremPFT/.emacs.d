(setq default-directory user-emacs-directory)

(defconst normal-gc-cons-threshold (* 20 1024 1024))
(defconst init-gc-cons-threshold (* 20 1024 1024))
(setq gc-cons-threshold init-gc-cons-threshold)
(add-hook 'emacs-startup-hook
(lambda () (setq gc-cons-threshold normal-gc-cons-threshold)))

(let ((file-name-handler-alist nil)
      (readme-el "init-post.el")
      (readme-elc "init-post.elc")
      (readme-org "README.org")
      )

  (when (or (not (file-exists-p readme-el))
	    (file-newer-than-file-p readme-org readme-el))
    (require 'org)
    (require 'loadhist)
    (org-babel-tangle-file readme-org)
    (defun unload-feature-recursive (feature)
      (let* ((file (feature-file feature))
	     (dependents (delete file (copy-sequence (file-dependents file))))) 
	(when dependents
	  (mapc #'unload-feature-recursive (mapcan #'file-provides dependents)))))
    (unload-feature-recursive 'org))

  (when (or (not (file-exists-p readme-elc))
	    (file-newer-than-file-p readme-org readme-elc))
    (byte-compile-file readme-el t)))
