;; extracted from init.el : byte-compilation complain that wisi is not
;; here, even inside a 'when nil'

(use-package wisi
  :straight (:host github :repo "emacsmirror/wisi")
  )

(use-package ada-mode
  :straight (:host github :repo "emacsmirror/ada-mode")
  :after wisi fill-column-indicator
  :config
  (setq ada-parser 'elisp)
  (setq fci-rule-column 78)
  ;; (ada-case-read-all-exceptions)

  (defun ada-before-save ()
    (when (or (eq major-mode 'ada-mode) (eq major-mode 'gpr-mode))
      (ada-case-adjust-buffer)
      (ada-reset-parser)
      (indent-buffer)))

  (add-hook 'before-save-hook 'ada-before-save)
  (add-hook 'ada-mode-hook (lambda () (electric-pair-mode)))

  ;; source : https://emacs.stackexchange.com/questions/13078/use-hippie-expand-to-complete-ruby-symbols-without-prefix
  (defun hippie-expand-ada-symbols (orig-fun &rest args)
    (if (eq major-mode 'ada-mode)
        (let ((table (make-syntax-table ada-mode-syntax-table)))
          (modify-syntax-entry ?. "_" table)
          (with-syntax-table table (apply orig-fun args)))
      (apply orig-fun args)))

  (advice-add 'hippie-expand :around #'hippie-expand-ada-symbols)
  )
