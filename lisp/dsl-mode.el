;; a simple major mode for domain specific langage *.dsl

;; see
;; http://ergoemacs.org/emacs/elisp_syntax_coloring.html
;; http://ergoemacs.org/emacs/elisp_syntax_table.html
;; http://ergoemacs.org/emacs/elisp_comment_coloring.html
;; http://www.wilfred.me.uk/blog/2015/03/19/adding-a-new-language-to-emacs/
;; http://www.modernemacs.com/post/major-mode-part-1/
;; font lock taken from ada-mode

(defvar dsl-mode-syntax-table nil "Syntax table for `dsl-mode'.")

(setq dsl-mode-syntax-table
      (let ( (table (make-syntax-table)))
        (modify-syntax-entry ?- ". 12b" table)
        (modify-syntax-entry ?\n "> b" table)
        ;; (modify-syntax-entry ?_ "w" table)
        (modify-syntax-entry ?\" "\"" table)
        table))

(defvar dsl-comment-start "--  ")

(defvar dsl-keywords '(
                       "abstract"
                       "and"
                       "or"
                       "end"
                       "command"
                       "implementation"
                       "initialization"
                       "inout"
                       "in"
                       "is"
                       "package"
                       "operation"
                       "out"
                       "post"
                       "pre"
                       "project"
                       "query"
                       "return"
                       "value_object"
                       "vector"
                       ))

(defun dsl-font-lock-keywords ()
  (list
   (list (concat "\\<" (regexp-opt dsl-keywords t) "\\>") '(0 font-lock-keyword-face))
   ))

(defvar dsl-font-lock-defaults
  `((
     ("\"\\.\\*\\?" . font-lock-string-face)
     ( ,(regexp-opt dsl-keywords 'words) . font-lock-keyword-face)
     )))

(define-derived-mode dsl-mode text-mode "dsl"
  "major mode for editing Domain Specific Langage code."
  (setq font-lock-defaults
	'(dsl-font-lock-keywords ;; keywords
	  nil
	  t
	  ((?\_ . "w")))); treat underscore as a word component
  (setq comment-start dsl-comment-start)
)


(provide 'dsl-mode)

;;; dsl-mode.el ends here
