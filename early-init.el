(customize-set-variable
 'debug-on-error t)

(defun emacs-dir-file (filename)
  (expand-file-name filename user-emacs-directory))

(customize-set-variable
 'initial-buffer-choice (emacs-dir-file "init.el"))

(customize-set-variable
 'custom-file (emacs-dir-file "init-emacs-custom.el"))

;; Speed-up at startup: boost garbage collector memory
;; article: https://elmord.org/blog/?entry=20190913-emacs-gc
(defconst normal-gc-cons-threshold (* 10 1024 1024))
(defconst init-gc-cons-threshold (* 100 1024 1024))
(customize-set-variable 'gc-cons-threshold init-gc-cons-threshold)
(add-hook 'emacs-startup-hook
          (lambda () (setq gc-cons-threshold normal-gc-cons-threshold)))
