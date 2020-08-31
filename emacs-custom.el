(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(backup-by-copying t)
 '(backup-directory-alist (quote (("." . "~/.emacs.d/backup"))))
 '(bmkp-last-as-first-bookmark-file
   "c:/Users/jpiffret/AppData/Roaming/.emacs.d/emacs-bookmarks/bmk.emacs")
 '(safe-local-variable-values
   (quote
    ((eval progn
	   (org-babel-tangle)
	   (when
	       (y-or-n-p "load init.el? ")
	     (load
	      (concat user-emacs-directory "init.el"))))))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
