;; to startup emacs using another directory on Windows, change the shortcut:
;; D:\Users\jpiffret\emacs-26.1-i686\bin\runemacs.exe --eval "(setenv \"HOME\" \"c:/Users/jeremy\")" --load d:/Users/jpiffret/AppData/Roaming/Dropbox/emacs_ingenico/.emacs.d/init.d
;;
;; comment HOME change since .emacs.d is no more shared using Dropbox
;; (let ((local-home "d:/Users/jpiffret/AppData/Roaming/Dropbox/emacs_ingenico"))
;;   (when (file-directory-p local-home)
;;     (setenv "HOME" local-home)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;; custom
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(setq custom-file "~/.emacs.d/emacs-custom.el")
(load custom-file)

(byte-recompile-directory "~/.emacs.d/lisp/" 0)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;; el-get
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; source: https://github.com/dimitri/el-get/blob/master/README.md

(add-to-list 'load-path "~/.emacs.d/el-get/el-get")

(unless (require 'el-get nil t)
  (url-retrieve
   "https://github.com/dimitri/el-get/raw/master/el-get-install.el"
   (lambda (s)
     (let (el-get-install-skip-emacswiki-recipes)
       (goto-char (point-max))
       (eval-print-last-sexp)))))

(add-to-list 'el-get-recipe-path "~/.emacs.d/el-get-jpi/recipes")

(defvar mypackages)

(setq mypackages
      (append
       '(el-get)
       (mapcar 'el-get-source-name el-get-sources)))

(el-get 'sync mypackages)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;; packages
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(require 'package)

(add-to-list 'package-archives
             '("MELPA Stable" . "https://stable.melpa.org/packages/") t)

(add-to-list 'package-archives
             '("jpi" . "~/.emacs.d/package-repo-jpi/") t)

(package-initialize)

;; (add-to-list 'load-path "~/.emacs.d/elpa/benchmark-init-20150905.938")
;; (require 'benchmark-init)
;; (add-hook 'after-init-hook 'benchmark-init/deactivate)

(unless package-archive-contents
  (package-refresh-contents))

(unless (package-installed-p 'use-package)
  (package-install 'use-package))
;; https://github.com/jwiegley/use-package
;;
;; see leaf.el too. But doesn't have a :pin keyword

(use-package use-package-ensure-system-package
  :ensure t
  )

(use-package key-chord
  :ensure t
  )

(use-package use-package-chords
  :ensure t
  )

(use-package use-package-el-get
  :ensure t
  )

(use-package hydra
  ;; bindings keys
  ;; https://github.com/abo-abo/hydra
  :pin melpa
  :ensure t
  )

(use-package use-package-hydra
  ;; https://gitlab.com/to1ne/use-package-hydra
  :ensure t
  :after use-package hydra
  )

(use-package org
  :pin gnu
  :ensure t
  :mode
  ("\\.\\(org\\|txt\\)\\'" . org-mode)
  ("\\*notes\\*" . org-mode)
  )

(use-package org-web-tools
  :ensure t
  )

(use-package ob-async
  ;; https://github.com/astahlman/ob-async
  :pin melpa
  :ensure t
  :after org
)

(use-package org-mind-map
  ;; mind map
  :ensure t
  :init (require 'ox-org)
  :config (setq org-mind-map-engine "dot")
  )

(use-package org-brain
  ;; mind map
  :ensure t
  )

(use-package yasnippet
  ;; https://github.com/joaotavora/yasnippet
  ;; http://joaotavora.github.io/yasnippet/
  :ensure t
  :config
  (yas-global-mode 1)
  )

(use-package fill-column-indicator
  :pin melpa
  :ensure t
  :config
  (defun set-fci-to-80 ()
    (setq fci-rule-column 80))
  (add-hook 'prog-mode-hook 'fci-mode)
  (add-hook 'prog-mode-hook 'set-fci-to-80)
  (add-hook 'ada-mode-hook 'fci-mode)
  )

(use-package ada-mode
  :pin jpi
  :ensure t
  :after fill-column-indicator
  :config
  (setq fci-rule-column 78)

  (defun ada-before-save ()
    (when (eq major-mode 'ada-mode)
      (ada-case-adjust-buffer)
      (indent-buffer)))
  (add-hook 'before-save-hook 'ada-before-save)
  )

(use-package wisi
  :pin jpi
  :ensure t
  )

(use-package flycheck
  :pin melpa
  :ensure t
)

(use-package magit
  ;;
  ;; TODO see magit-gitflow
  ;;
  :pin gnu
  :ensure t
  :config

  ;; speed up magit
  (when (eq system-type 'windows-nt)
    (setq exec-path (add-to-list 'exec-path "C:/Program Files/Git/cmd"))
    (setq exec-path (add-to-list 'exec-path "C:/Program Files/Git/bin"))
    (setenv "PATH" (concat "C:\\Program Files\\Git\\cmd;"
                           "C:\\Program Files\\Git\\bin;"
                           (getenv "PATH"))))

  ;; fetch my repositories
  (defun fetch_all_repositories ()
    (interactive)
    (cd (concat (getenv "HOME") "/workspace/0_fetch_all" ))
    (shell-command "fetch_all_repositories.py")
    (cd (concat (getenv "HOME") "/.emacs.d" )))

  )

(use-package fic-mode
  ;; highlight TODO/FIXME/...
  :ensure t
  :config
  (add-hook 'prog-mode-hook #'fic-mode)
  (add-hook 'ada-mode-hook #'fic-mode)
  (defun fic-view-listing ()
    "Use occur to list related FIXME keywords"
    (interactive)
    (occur "\\<\\(FIXME\\|TODO\\|BUG\\):?"))
  )

(use-package deft
  ;; Emacs mode for quickly browsing, filtering, and editing directories
  ;; of plain text notes
  ;;
  ;; https://github.com/jrblevin/deft
  ;;
  ;; http://pragmaticemacs.com/emacs/make-quick-notes-with-deft/
  ;; https://irreal.org/blog/?p=256
  ;; https://jingsi.space/post/2017/04/05/organizing-a-complex-directory-for-emacs-org-mode-and-deft/
  ;; https://jonathanchu.is/posts/setting-up-deft-mode-in-emacs-with-org-mode/
  :ensure t
  :config
  (setq deft-extensions '("org" "txt" "tex"))
  (setq deft-directory "~/workspace/org")
  )

(use-package dired-filter
  ;; TODO replace shortcuts with hydra
  :pin melpa
  :ensure t
  :after hydra
  :bind (:map dired-mode-map ("/" . hydra-dired-filter/body))
  :hydra (hydra-dired-filter
          ()
          "dired-filter

"
          ("n" dired-filter-by-name "by name" :column "filter by")
          ("r" dired-filter-by-regexp "regexp")
          ("e" dired-filter-by-extension "extension")
          ("f" dired-filter-by-file "files" :column "filter only")
          ("p" dired-filter-pop "pop last filter" :column "others")
          ("H" (package-menu-describe-package dired-filter) "Help" :column "manual")
          )
  )

(use-package immaterial-theme
  ;; dark colors. Better than default white...
  :pin melpa
  :ensure t
  :config
  (load-theme 'immaterial t)
  )

(use-package elpy
  ;; Python env. From https://realpython.com/emacs-the-best-python-editor/
  :pin melpa
  :ensure t
  )

(use-package flx
  ;; flx mode. Used with completion list
  ;; flx-isearch exists, but take a long time inside a long file
  :pin melpa
  :ensure t
  )

(use-package ivy
  ;; completion
  :pin melpa
  :ensure t
  )

(use-package swiper
  ;; completion
  :pin melpa
  :ensure t
  )

(use-package counsel
  ;; completion
  :pin melpa
  :ensure t
  )

(use-package ivy-hydra
  ;; completion
  :pin melpa
  :ensure t
  )

(use-package ztree
  ;; https://github.com/fourier/ztree
  :pin melpa
  :ensure t
  :bind (:map ztree-mode-map
         ("p" . ztree-previous-line)
         ("n" . ztree-next-line)
         )
  )

(use-package wgrep
  ;; editable grep results
  :pin melpa
  :ensure t
  :after hydra
  :bind (
         :map dired-mode-map
              ("<f3>" . hydra-wgrep/body))
  :hydra (hydra-wgrep
          ()
          "wgrep commands

"
          ("p" wgrep-change-to-wgrep-mode "start")
          ("u" wgrep-remove-change "remove region changes")
          ("U" wgrep-remove-all-change "remove all changes")
          ("a" wgrep-apply-change "apply")
          ("s" wgrep-save-all-buffers "save all")
          )
  )


(use-package speed-type
  :pin melpa
  :ensure t)

(use-package htmlize
  :pin melpa
  :ensure t
  )

(use-package avy
  ;; https://github.com/abo-abo/avy
  ;; like ace-jump
  :pin melpa
  :ensure t
  :bind ("C-:" . avy-goto-char-2)
  )

(use-package dired+
  :load-path "lisp/"
  :config
  ;; I want the same color for file name and extension
  (setq diredp-file-suffix diredp-file-name)
)

(use-package elpa-mirror
  :load-path "lisp/elpa-mirror/"
  )

(load-file "~/.emacs.d/lisp/bookmark-plus/bookmark+-mac.el")
(use-package bookmark+
  :load-path "lisp/bookmark-plus/"
  )

;; multiple-cursors ;; TODO

;; golden-ratio TODO
;; (see here: https://tuhdo.github.io/emacs-tutor3.html)

;; paradox
;; ;; new *Packages* interface. Not used, I find it too heavy

;; (use-package amx
;; ;; completion
;; :ensure t
;; )

;; (use-package crm-custom
;; ;; completion
;; :ensure t
;; )

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;; environment
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(setenv "PATH"
        (concat "C:\\Program Files (x86)\\GnuWin32\\bin;"
                (getenv "PATH")))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;; development
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(add-hook 'c-mode-hook (lambda () (setq comment-start "//"
                                        comment-end   "")))

(c-add-style "ingenico"
             '("gnu"
               (c-basic-offset . 2)     ; Guessed value
               (c-offsets-alist
                (block-close . 0)       ; Guessed value
                (brace-entry-open . 0)  ; Guessed value
                (brace-list-close . 0)  ; Guessed value
                (brace-list-intro . +)  ; Guessed value
                (brace-list-open . 0)   ; Guessed value
                (case-label . +)        ; Guessed value
                (class-close . 0)       ; Guessed value
                (class-open . 0)        ; Guessed value
                (defun-block-intro . +) ; Guessed value
                (defun-close . 0)       ; Guessed value
                (defun-open . 0)        ; Guessed value
                (do-while-closure . 0)  ; Guessed value
                (else-clause . 0)       ; Guessed value
                (inclass . +)           ; Guessed value
                (statement . 0)             ; Guessed value
                (statement-block-intro . +) ; Guessed value
                (statement-case-intro . +) ; Guessed value
                (substatement . +)      ; Guessed value
                (substatement-open . 0) ; Guessed value
                (topmost-intro . 0)     ; Guessed value
                (access-label . -)
                (annotation-top-cont . 0)
                (annotation-var-cont . +)
                (arglist-close . c-lineup-close-paren)
                (arglist-cont c-lineup-gcc-asm-reg 0)
                (arglist-cont-nonempty . c-lineup-arglist)
                (arglist-intro . c-lineup-arglist-intro-after-paren)
                (block-open . 0)
                (brace-list-entry . 0)
                (c . c-lineup-C-comments)
                (catch-clause . 0)
                (comment-intro . c-lineup-comment)
                (composition-close . 0)
                (composition-open . 0)
                (cpp-define-intro c-lineup-cpp-define +)
                (cpp-macro . -1000)
                (cpp-macro-cont . 0)
                (extern-lang-close . 0)
                (extern-lang-open . 0)
                (friend . 0)
                (func-decl-cont . +)
                (incomposition . +)
                (inexpr-class . +)
                (inexpr-statement . +)
                (inextern-lang . 0)
                (inher-cont . c-lineup-multi-inher)
                (inher-intro . +)
                (inlambda . c-lineup-inexpr-block)
                (inline-close . 0)
                (inline-open . 0)
                (inmodule . +)
                (innamespace . +)
                (knr-argdecl . 0)
                (knr-argdecl-intro . 5)
                (label . 0)
                (lambda-intro-cont . +)
                (member-init-cont . c-lineup-multi-inher)
                (member-init-intro . +)
                (module-close . 0)
                (module-open . 0)
                (namespace-close . 0)
                (namespace-open . 0)
                (objc-method-args-cont . c-lineup-ObjC-method-args)
                (objc-method-call-cont c-lineup-ObjC-method-call-colons c-lineup-ObjC-method-call +)
                (objc-method-intro .
                                   [0])
                (statement-case-open . 0)
                (statement-cont . +)
                (stream-op . c-lineup-streamop)
                (string . -1000)
                (substatement-label . 0)
                (template-args-cont c-lineup-template-args +)
                (topmost-intro-cont first c-lineup-topmost-intro-cont c-lineup-gnu-DEFUN-intro-cont))))

(add-hook 'c-mode-hook (lambda () (c-set-style "ingenico")))
(add-hook 'cc-mode-hook (lambda () (c-set-style "ingenico")))
(add-hook 'c-mode-hook (lambda () (electric-pair-mode)))
(add-hook 'cc-mode-hook (lambda () (electric-pair-mode)))

(defun insert-html-tag ()
  "to be used for Doxygen"
  (interactive)
  (let ( tag in-region region-start region-stop )
    (setq tag (read-from-minibuffer "tag? "))
    (setq in-region (region-active-p))
    (when in-region
      (setq region-start (region-beginning)
            region-stop (region-end))
      )

    (when in-region
      (goto-char region-start))
    (insert ?< tag ?>)
    (when in-region
      (goto-char (+ region-stop (string-width tag) 2)))
    (insert ?< ?/ tag ?>)
    ))

(add-hook 'c-mode-hook
          (lambda ()
            (local-set-key (kbd "C-c C-t") (quote insert-html-tag))))

(add-hook 'python-mode-hook (lambda () (electric-pair-mode)))

(elpy-enable) ;; config: "M-x elpy-config"

;; Enable Flycheck
(when (require 'flycheck nil t)
  (setq elpy-modules (delq 'elpy-module-flymake elpy-modules))
  (add-hook 'elpy-mode-hook 'flycheck-mode))

;; pretty print
;;
(defun jpi-pp()
  "pretty printer. Only when an region is selected. Only useful in C."
  (interactive)
  (let ((start (region-beginning))(stop (region-end)))
    (indent-region start stop)
    (align start stop)
    ;; (align nil nil)
    (indent-region start stop)
    (align nil nil)
    ))

(defun jpi-pp-2()
  "pretty printer space operator"
  (interactive)

  (setq start-pos (point))

  (setq group-operators '("[" "]" "(" ")" "{" "}"))
  (setq operators '("," "*" "&" "+" "-" "/" "<=" ">=" "<" ">"))

  (while group-operators
    (let (operator regexp)
      (setq operator (car group-operators)
            group-operators (cdr group-operators)
            regexp "[]A-Za-z_0-9*&<>[()+/*,\"]")

      (goto-char start-pos)

      (while (search-forward operator nil t nil)

        ;; not inside string or comment
        (unless (or (nth 3 (syntax-ppss))
                    (nth 4 (syntax-ppss)))

          (unless (= (point) (line-beginning-position))
            (forward-char -1)
            (when (looking-back regexp)
              (insert " ")))

          (forward-char 1)
          (when (looking-at regexp)
            (unless (looking-at ",")
              (insert " ")))
          ) ;; unless inside
        ) ;; while search
      ) ;; let
    ) ;; while group-operators

  (while operators
    (let (operator)
      (setq operator (car operators)
            operators (cdr operators)
            regexp "[A-Za-z_0-9]")

      (goto-char start-pos)

      (while (search-forward operator nil t nil)

        (unless (or (nth 3 (syntax-ppss))
                    (nth 4 (syntax-ppss)))

          (unless (string= operator ",")
            (unless (= (point) (line-beginning-position))
              (forward-char -1)
              (when (looking-back regexp)
                (unless (or (string= (buffer-substring-no-properties
                                      (point) (+ 2 (point))) "->")
                            (string= (buffer-substring-no-properties
                                      (point) (+ 2 (point))) "*/"))
                  (insert " ")))
              (forward-char)))

          (when (looking-at regexp)
            (unless (string= (buffer-substring-no-properties
                              (- (point) 2) (point)) "->")
              (insert " "))))
        ) ;; while search
      ) ;; let
    ) ;; while operators
  )

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;; TODO: categorize
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;
;; trying some session extensions, not so good ...  I prefere simple ibuffer and
;; it's filters
;;;;
;; (provide 'virtual-desktops)
;; seems to corrupt ibuffer
;; (require 'session)
;; (add-hook 'after-init-hook 'session-initialize)
;; (desktop-save-mode -1)
;;;;

(add-hook 'before-save-hook 'delete-trailing-whitespace)
;;;;
;; may only activate for prog-modes:
;;
;; (defun my-prog-nuke-trailing-whitespace ()
;;   (when (derived-mode-p 'prog-mode)
;;     (delete-trailing-whitespace)))
;; (add-hook 'before-save-hook 'my-prog-nuke-trailing-whitespace)
;;;;

(global-hl-line-mode 1)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;; linum
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; customize -format
;; source: https://www.emacswiki.org/emacs/LineNumbers#toc8

(unless window-system
  (add-hook 'linum-before-numbering-hook
	    (lambda ()
	      (setq-local linum-format-fmt
			  (let ((w (length (number-to-string
					    (count-lines (point-min) (point-max))))))
			    (concat "%" (number-to-string w) "d"))))))

(defun linum-format-func (line)
  (concat
   (propertize (format linum-format-fmt line) 'face 'linum)
   (propertize " " 'face 'mode-line)))

(unless window-system
  (setq linum-format 'linum-format-func))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;; magit
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;; elisp (personal, imported)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(add-to-list 'load-path "~/.emacs.d/lisp/openssl-cipher")
(require 'openssl-cipher)

(require 'ingenico-parse-log)
(defalias 'yes-or-no-p 'y-or-n-p)
(global-set-key (kbd "<f5>") 'revert-buffer)
(global-set-key (kbd "C-x C-g") 'goto-line)
(global-set-key (kbd "C-x C-b") 'ibuffer)
(global-set-key (kbd "M-/") 'hippie-expand)

(defun indent-buffer ()
  (interactive)
  (indent-region (point-min) (point-max)))

;; following work with C-s but not with M-% ... :(
(define-key minibuffer-local-map "(" 'self-insert-command )
(define-key minibuffer-local-ns-map "(" 'self-insert-command )

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;; ivy swiper counsel
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;  completion engine
;;
;;  https://github.com/abo-abo/swiper
;;  https://oremacs.com/swiper/
;;  https://truthseekers.io/lessons/how-to-use-ivy-swiper-counsel-in-emacs-for-noobs/
;;  https://www.reddit.com/r/emacs/comments/6yi6dl/most_useful_parts_of_ivycounselswiper_manual_too/
;;  https://www.reddit.com/r/emacs/comments/6xc0im/ivy_counsel_swiper_company_helm_smex_and_evil/
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(global-set-key (kbd "C-x r b") 'counsel-bookmark)
(global-set-key (kbd "C-x b") 'counsel-switch-buffer)
(global-set-key (kbd "M-x") 'counsel-M-x)
(global-set-key (kbd "C-h f") 'counsel-describe-function)
(global-set-key (kbd "C-h v") 'counsel-describe-variable)
(global-set-key (kbd "C-x C-f") 'counsel-find-file)

(global-set-key (kbd "C-s") 'isearch-forward)
(global-set-key (kbd "C-r") 'isearch-backward)

(setq ivy-re-builders-alist
      '((swiper-isearch . ivy--regex-plus)
        (t      . ivy--regex-fuzzy)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;; asn1-mode
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; warning: The old asn1-mode works. The new one doesn't.

(setq auto-mode-alist
      (cons '("\\.[Aa][Ss][Nn][1]?$" . asn1-mode) auto-mode-alist))
(autoload 'asn1-mode "asn1-mode.el"
  "Major mode for editing ASN.1 specifications." t)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;; dsl-mode
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; personal mode for my domain specific langage

(add-to-list 'auto-mode-alist '("\\.dsl\\'" . dsl-mode))

(autoload 'dsl-mode "dsl-mode.el"
  "Major mode for editing ASN.1 specifications." t)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;; calendar
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; add week number
(copy-face font-lock-constant-face 'calendar-iso-week-face)
(set-face-attribute 'calendar-iso-week-face nil
                    :height 1.0 :foreground "salmon")
;; (set-face-attribute 'calendar-iso-week-face nil
;;                     :height 0.7)
(setq calendar-intermonth-text
      '(propertize
        (format "%2d"
                (car
                 (calendar-iso-from-absolute
                  (calendar-absolute-from-gregorian (list month day year)))))
        'font-lock-face 'calendar-iso-week-face))

(copy-face 'default 'calendar-iso-week-header-face)
(set-face-attribute 'calendar-iso-week-header-face nil
                    :height 1.0 :foreground "salmon")
(setq calendar-intermonth-header
      (propertize "Wk"                  ; or e.g. "KW" in Germany
                  'font-lock-face 'calendar-iso-week-header-face))

(require 'french-holidays)
(setq calendar-holidays holiday-french-holidays)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;; org-mode
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; patched function org-translate-time from org.el
;; replaced
;;
;; (concat
;;  (if inactive "[" "<") (substring tf 1 -1)
;;  (if inactive "]" ">"))
;;
;; with
;;
;; (require 'org-collector)
;;
;; removed: default behavior is better ...
;;
;; see https://orgmode.org/manual/Capturing-column-view.html:
;;    C-c C-x i (org-insert-columns-dblock)

(global-set-key (kbd "C-c c") 'org-capture)

;; setting up org-babel for literate programming
(org-babel-do-load-languages
 'org-babel-load-languages
 '(
   (python . t)
   ;;   (sh . t)
   (C . t)
   ;; Include other languages here...
   ))
;; Syntax highlight in #+BEGIN_SRC blocks
(setq org-src-fontify-natively t)
;; Don't prompt before running code in org
(setq org-confirm-babel-evaluate nil)
;; Fix an incompatibility between the ob-async and ob-ipython packages
(progn
  (defvar ob-async-no-async-languages-alist)
  (setq ob-async-no-async-languages-alist '("ipython")))

(setq-default org-src-window-setup 'current-window)

(progn
  (defvar org-html-postamble)
  (setq org-html-postamble nil))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;; auto remove mouse pointer
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; emacs-25.3_1-x86_64/share/emacs/25.3/lisp/avoid.el
;; move mouse pointer when near the cursor
(when (display-mouse-p) (mouse-avoidance-mode 'jump))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;; enabled commands
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(put 'erase-buffer 'disabled nil)
(put 'narrow-to-region 'disabled nil)
(put 'upcase-region 'disabled nil)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;; scratch buffer
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defun unkillable-scratch-buffer ()
  (if (equal (buffer-name (current-buffer)) "*scratch*")
      (progn
        (delete-region (point-min) (point-max))
        nil)
    t))

(add-hook 'kill-buffer-query-functions 'unkillable-scratch-buffer)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;; projectile configuration
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; removed jpi (projectile-mode nil)
;; (define-key projectile-mode-map (kbd "C-c p") 'projectile-command-map)
;; (setq projectile-switch-project-action #'projectile-dired)
;; (setq projectile-enable-caching t)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;; perspeen configuration
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; removed jpi (perspeen-mode nil)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;; replace+
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; from https://www.emacswiki.org/emacs/OccurMode

(require 'replace+)
;; (define-key occur-mode-map (kbd "C-*") 'next-error)
;; (define-key occur-mode-map (kbd "C-/") 'previous-error)

(global-set-key (kbd "C-*") 'next-error)
(global-set-key (kbd "C-/") 'previous-error)

;; force to use the same window as *Occur* to show the occurence
(defadvice occur-next-error (before my-occur-next-error activate)
  (let ((win (get-buffer-window (current-buffer))))
    (if win
        (select-window win))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;; deft
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; https://github.com/jrblevin/deft


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;; hydra
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; bindings keys
;;
;; https://github.com/abo-abo/hydra
;; https://github.com/abo-abo/hydra/wiki/Org-agenda
;; https://www.reddit.com/r/emacs/comments/8of6tx/tip_how_to_be_a_beast_with_hydra/

(defhydra hydra-magit (:hint nil)
  "
_F_ fetch all _s_ status
_p_ push      _c_ commit
_d_ diff      _la_ log all
"
  ("F" fetch_all_repositories)
  ("p" magit-push)
  ("c" magit-commit)
  ("d" magit-diff)
  ("la" magit-log-all)
  ("s" magit-status)
  )

(defvar HOME (file-name-as-directory (getenv "HOME")))
(defvar org-dir (file-name-as-directory (concat HOME "workspace/org/bookmarks")))

(defhydra hydra-bookmarks ()
  ("D"  (find-file org-dir)                                      "directory" :column "my bookmarks" :exit t)
  ("bc" (find-file (concat org-dir "bookmarks-current.org.txt")) "current" :exit t)
  ("bl" (find-file (concat org-dir "bookmarks-loisirs.org.txt")) "loisir" :exit t)

  ("sv" bookmark-save "save" :column "bookmark-mode")
  ("l" bookmark-load  "load")

  ("a" bmkp-add-tags       "add" :column "tags")
  ("c" bmkp-copy-tags      "copy")
  ("p" bmkp-paste-add-tags "past")
  )

(defhydra hydra-summary ()
  ("m" hydra-magit/body "magit" :exit t)
  ("b" hydra-bookmarks/body "bookmarks" :exit t)
  ("z" hydra-zoom/body "zoom" :exit t)
  )

(global-set-key (kbd "<f1>") 'hydra-summary/body)

(add-hook 'dired-mode-hook
          (lambda ()
            (local-set-key (kbd "<f1>") (quote hydra-summary/body))))

(defhydra hydra-zoom ()
  "zoom"
  ("+" text-scale-increase "in")
  ("-" text-scale-decrease "out"))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;; emacs client
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; setenv EMACS_SERVER_FILE=.emacs.d/server/server

(server-start)
