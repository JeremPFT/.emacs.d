(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(auto-revert-interval 3)
 '(ansi-color-faces-vector
   [default default default italic underline success warning error])
 '(ansi-color-names-vector
   ["#242424" "#e5786d" "#95e454" "#cae682" "#8ac6f2" "#333366" "#ccaa8f" "#f6f3e8"])
 '(backup-by-copying t)
 '(backup-directory-alist (quote (("." . "~/.emacs.d/backup"))))
 '(bmkp-bmenu-state-file "~/.emacs.d/emacs-bookmarks/.bmk-bmenu-state.el")
 '(bmkp-last-as-first-bookmark-file "~/.emacs.d/emacs-bookmarks/bmk.emacs")
 '(bookmark-default-file "~/.emacs.d/emacs-bookmarks/bmk.emacs")
 '(custom-enabled-themes (quote (tsdh-dark)))
 '(org-id-link-to-org-use-id (quote create-if-interactive-and-no-custom-id))
 '(safe-local-variable-values
   (quote
    ((eval add-hook
	   (quote after-save-hook)
	   (lambda nil
	     (org-babel-tangle)))))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:inherit nil :stipple nil :background "#050000" :foreground "#bbe0f0" :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight normal :height 120 :width normal :foundry "outline" :family "Courier New"))))
 )

