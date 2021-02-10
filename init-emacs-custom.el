(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(column-number-mode t)
 '(debug-on-error t)
 '(electric-pair-mode t)
 '(fill-column 79)
 '(frame-title-format
   '(:eval
     (format "%s: %s %s"
             (or
              (file-remote-p default-directory 'host)
              system-name)
             (buffer-name)
             (cond
              (buffer-file-truename
               (concat "(" buffer-file-truename ")"))
              (dired-directory
               (concat "{" dired-directory "}"))
              (t "[no file]")))) t)
 '(gc-cons-threshold 104857600)
 '(global-hl-line-mode t)
 '(indent-tabs-mode nil)
 '(menu-bar-mode t)
 '(org-indent-indentation-per-level 0 nil nil "Customized with leaf in `org' block at `c:/Users/jeremy/AppData/Roaming/.emacs.d/init.el'")
 '(org-level-color-stars-only nil nil nil "Customized with leaf in `org' block at `c:/Users/jeremy/AppData/Roaming/.emacs.d/init.el'")
 '(package-archives
   '(("org" . "https://orgmode.org/elpa/")
     ("gnu" . "https://elpa.gnu.org/packages/")
     ("melpa" . "https://melpa.org/packages/")
     ("melpa stable" . "https://stable.melpa.org/packages/")))
 '(package-selected-packages
   '(htmlize poporg org-brain org-mind-map org-generate ob-async org-web-tools zenburn-theme magit-gitflow link-hint leaf-tree leaf-keywords hydra git-link flx f el-get counsel blackout avy-menu))
 '(scroll-bar-mode t)
 '(show-paren-mode t)
 '(tool-bar-mode t)
 '(truncate-lines t)
 '(user-full-name "Jeremy Piffret")
 '(user-login-name "jpiffret" t)
 '(user-mail-address "j.piffret@gmail.com"))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
