(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(auto-revert-interval 3)
 '(backup-by-copying t)
 '(backup-directory-alist (quote (("." . "~/.emacs.d/backup"))))
 '(bmkp-bmenu-state-file "~/.emacs.d/emacs-bookmarks/.bmk-bmenu-state.el")
 '(bmkp-last-as-first-bookmark-file "~/.emacs.d/emacs-bookmarks/bmk.emacs")
 '(bookmark-default-file "~/.emacs.d/emacs-bookmarks/bmk.emacs")
 '(c-default-style
   (quote
    ((c-mode . "ingenico")
     (c++-mode . "ingenico")
     (java-mode . "java")
     (awk-mode . "awk")
     (other . "gnu"))))
 '(org-id-link-to-org-use-id (quote create-if-interactive-and-no-custom-id))
 '(safe-local-variable-values
   (quote
    ((eval add-hook
	   (quote after-save-hook)
	   (lambda nil
	     (org-babel-tangle)))
     (eval progn
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
 '(default ((t (:inherit nil :stipple nil :background "#050000" :foreground "#bbe0f0" :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight normal :height 120 :width normal :foundry "outline" :family "Courier New"))))
 '(highlight ((t (:background "light slate gray")))))
