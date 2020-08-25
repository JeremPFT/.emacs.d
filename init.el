;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;; encoding
;;;; see https://www.emacswiki.org/emacs/ChangingEncodings
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; utf-8-unix
;; windows-1252

(setq utf-translate-cjk-mode nil) ; disable CJK coding/encoding (Chinese/Japanese/Korean characters)
(set-keyboard-coding-system 'utf-8-unix) ; For old Carbon emacs on OS X only
(setq locale-coding-system 'windows-1252)
(set-default-coding-systems 'utf-8-unix)
(prefer-coding-system 'utf-8-unix)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;; custom
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(setq custom-file (expand-file-name "emacs-custom.el" user-emacs-directory))
(load custom-file)

(byte-recompile-directory (expand-file-name "lisp" user-emacs-directory) 0)

(setq system-time-locale "C")
;; ensure org timestamp is in english format

(defconst ingenico-computer-name "FR0WSC3NRYM2")
(defconst home-computer-name "DESKTOP-5R08DIM")
(defconst ingenico-computer-p (string= (system-name) ingenico-computer-name))
(defconst home-computer-p (string= (system-name) home-computer-name))

(defconst windows-p (eq system-type 'windows-nt))
(defconst linux-p (eq system-type 'gnu/linux))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;; straight
;;;; (package manager)
;;;; https://github.com/raxod502/straight.el
;;;; https://github.crookster.org/switching-to-straight.el-from-emacs-26-builtin-package.el/
;;;;
;;;; TODO see hydra integration
;;;; https://github.com/abo-abo/hydra/wiki/straight.el
;;;;
;;;; see example
;;;; https://emacs.nasy.moe/
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(require 'package)
(add-to-list 'package-archives
             '("melpa" . "https://melpa.org/packages"))
(add-to-list 'package-archives
             '("MELPA Stable" . "https://stable.melpa.org/packages") t)

(unless package--initialized (package-initialize t))

(setq straight-profiles
      '((nil . "default.el")
        ;; Packages which are pinned to a specific commit.
        (pinned . "pinned.el")))

(defvar bootstrap-version)
(let ((bootstrap-file
       (expand-file-name "straight/repos/straight.el/bootstrap.el" user-emacs-directory))
      (bootstrap-version 5))
  (unless (file-exists-p bootstrap-file)
    (with-current-buffer
        (url-retrieve-synchronously
         "https://raw.githubusercontent.com/raxod502/straight.el/develop/install.el"
         'silent 'inhibit-cookies)
      (goto-char (point-max))
      (eval-print-last-sexp)))
  (load bootstrap-file nil 'nomessage))

(require 'straight-x)
(autoload #'straight-x-pull-all "straight-x")
(autoload #'straight-x-freeze-versions "straight-x")

(straight-use-package 'use-package)
;; https://github.com/jwiegley/use-package

(setq straight-use-package-by-default t)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;; packages
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(use-package use-package-ensure-system-package)

(use-package key-chord)

(use-package use-package-chords)

(use-package diminish
  ;;
  ;; only works with minor mode
  ;;
  ;; see http://emacs-fu.blogspot.com/2010/05/cleaning-up-mode-line.html
  :config
  (defun diminish-emacs-lisp-mode() (setq mode-name "elisp"))
  (add-hook 'emacs-lisp-mode-hook 'diminish-emacs-lisp-mode)
  )

(use-package delight)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;; hydra
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(use-package hydra
  ;; bindings keys
  ;; https://github.com/abo-abo/hydra
  )

(use-package use-package-hydra
  ;; https://gitlab.com/to1ne/use-package-hydra
  :after use-package hydra
  )

(use-package major-mode-hydra
  :after hydra
  :bind
  ("<f2>" . major-mode-hydra)
  )

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;; undo-tree
;;;; https://github.com/apchamberlain/undo-tree.el
;;;; https://www.emacswiki.org/emacs/UndoTree
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(use-package undo-tree
  :straight
  (:host github :repo "emacsorphanage/undo-tree" :branch "master"))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;; org-mode
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defconst local-packages-dir
  (file-name-as-directory (concat user-emacs-directory "local-packages")))

(load-file (concat local-packages-dir "org-config.el"))

(load-file (concat local-packages-dir "git-config.el"))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;; yasnippet
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(use-package yasnippet
  ;; https://github.com/joaotavora/yasnippet
  ;; http://joaotavora.github.io/yasnippet/
  :config
  (yas-global-mode 1)
  )

(use-package fill-column-indicator
  :config
  (defun set-fci-to-80 ()
    (setq fci-rule-column 80))
  (add-hook 'prog-mode-hook 'fci-mode)
  (add-hook 'prog-mode-hook 'set-fci-to-80)
  (add-hook 'ada-mode-hook 'fci-mode)
  )

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;; latex
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(use-package auctex
  ;; https://www.gnu.org/software/auctex/
  :defer t
  :ensure t
  )

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;; TODO to sort
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(use-package wisi
  :straight (:host github :repo "emacsmirror/wisi")
  )

(require 'imenu)

(use-package ada-mode
  :straight (:host github :repo "emacsmirror/ada-mode")
  :after wisi fill-column-indicator
  :config
  (setq ada-parser 'elisp)
  (setq fci-rule-column 78)
  (ada-case-read-all-exceptions)

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

(let ((straight-current-profile 'pinned))
  (add-to-list 'straight-x-pinned-packages
               '("ada-mode" . "c56045a140816f76abfd43aa8351a18fe56a8d15"))
  (add-to-list 'straight-x-pinned-packages
               '("wisi" . "83ca0c16350ff4e79ff5172abcc5a2a78c755530")))

(use-package flycheck
  :after elpy
  )

(use-package elpy
  ;; Python env. From https://realpython.com/emacs-the-best-python-editor/
  :config
  (elpy-enable) ;; config: "M-x elpy-config"
  (add-hook 'python-mode-hook (lambda () (electric-pair-mode)))
  (when (require 'flycheck nil t)
    (setq elpy-modules (delq 'elpy-module-flymake elpy-modules))
    (add-hook 'elpy-mode-hook 'flycheck-mode))
  )

;; TODO Enable Flycheck. Integrate in use-package

(use-package fic-mode
  ;; highlight TODO/FIXME/...
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
  :config
  (setq deft-extensions '("org" "txt" "tex"))
  (setq deft-directory "~/workspace/org")
  )

(load-file (concat local-packages-dir "ibuffer-config.el"))

;; (use-package ls-lisp
;;   :ensure t
;;   :config
;;   (setq  ls-lisp-use-insert-directory-program nil
;;          ls-lisp-verbosity nil))

(require 'ls-lisp)
(setq  ls-lisp-use-insert-directory-program nil
       ls-lisp-verbosity nil)

(load-file (concat local-packages-dir "dired-config.el"))

(use-package neotree
  :straight
  (:host github :repo "jaypei/emacs-neotree" :branch "master")
  :config
  (setq
   neo-hidden-regexp-list (quote ("\\.pyc$" "~$" "^#.*#$" "\\.elc$"))
   neo-show-hidden-files t
   neo-theme (quote ascii)
   )
  )

(use-package treemacs
  :disabled ;; doesn't work on my personal computer ???
  :ensure t

  :defer t

  :bind-keymap
  (( "C-à" . treemacs)
   ( "C-)" . treemacs-select-window)
   ) ;; end bind-keymap
  :config

  (setq treemacs-is-never-other-window t)
  ) ;; end use-package

;; (use-package sr-speedbar)

;; (use-package sidebar
;;   :straight
;;   (:host github :repo "ebastiencs/sidebar.el" :branch "master")
;; )

;; (use-package dired-sidebar
;;   :straight
;;   (:host github :repo "jojojames/dired-sidebar" :branch "master")
;;   :ensure t
;;   :commands (dired-sidebar-toggle-sidebar)
;; )

(use-package all-the-icons
  :ensure t
  :config
  (unless (file-directory-p (concat user-emacs-directory "all-the-icons-fonts"))
    (make-directory (concat (getenv "HOME") (concat user-emacs-directory "all-the-icons-fonts")))
    (error "please run all-the-icons-install-fonts in .emacs.d/all-the-icons-fonts")
    ))

;;
;; custom dir sort
;;

;; (use-package dired-quick-sort
;;   ;; https://gitlab.com/xuhdev/dired-quick-sort
;;   :ensure t
;;   :config
;;   (add-hook 'dired-mode-hook (lambda ()
;;                                (when (eq system-type 'windows-nt)
;;                                (make-local-variable 'coding-system-for-read)
;;                                (setq coding-system-for-read 'utf-8-dos))
;;                                ) ;; end lambda
;;             ) ;; add-hook
;;   (dired-quick-sort-setup)
;;   )

(use-package immaterial-theme
  ;; dark colors. Better than default white...
  :config
  (load-theme 'immaterial t)
  )

(use-package flx
  ;; flx mode. Used with completion list
  ;; flx-isearch exists, but take a long time inside a long file
  )

(use-package ivy
  ;; completion
  ;; https://oremacs.com/swiper/#key-bindings
  ;; https://www.reddit.com/r/emacs/comments/6xc0im/ivy_counsel_swiper_company_helm_smex_and_evil/
  ;; https://www.youtube.com/user/abo5abo
  ;; https://sam217pa.github.io/2016/09/13/from-helm-to-ivy/
  :bind (:map ivy-minibuffer-map
              ("<RET>" . ivy-alt-done)
              ("C-j" . ivy-immediate-done)
              )
  :config
  (setq ivy-re-builders-alist
        '((swiper-isearch . ivy--regex-ignore-order)
          (t      . ivy--regex-fuzzy)))
  )

(use-package swiper
  ;; completion
  )

(use-package counsel
  ;; completion
  )

;; (use-package counsel-projectile
;;   :after projectile counsel
;;   :config
;;   (counsel-projectile-mode +1)
;;   )

(use-package ivy-hydra
  ;; completion
  )

(use-package ztree
  ;; https://github.com/fourier/ztree
  ;;
  ;; directory as a tree
  :bind (:map ztree-mode-map
              ("p" . ztree-previous-line)
              ("n" . ztree-next-line)
              )
  )

(use-package wgrep
  ;; editable grep results
  :straight
  (:host github :repo "mhayashi1120/Emacs-wgrep" :branch "master")
  :bind (
         :map grep-mode-map
         ("<f1>" . hydra-enter-wgrep/body)
         :map wgrep-mode-map
         ("<f1>" . hydra-wgrep/body)
         )
  :hydra (hydra-enter-wgrep
          ()
          "wgrep commands

"
          ("s" wgrep-change-to-wgrep-mode "start wgrep")
          )
  :hydra (hydra-wgrep
          ()
          "wgrep commands

"
          ("u" wgrep-remove-change "remove region changes")
          ("U" wgrep-remove-all-change "remove all changes")
          ("a" wgrep-apply-change "apply")
          ("s" wgrep-save-all-buffers "save all")
          )
  )

(use-package htmlize
  )

(use-package elpa-mirror
  :load-path "lisp/elpa-mirror/"
  )

;; TODO see if necessary (load-file (concat user-emacs-directory "lisp/bookmark-plus/bookmark+-mac.el"))
(use-package bookmark+
  ;; https://www.emacswiki.org/emacs/BookmarkPlus
  :straight
  (:host github :repo "emacsmirror/bookmark-plus" :branch "master")
  :custom
  (bmkp-bmenu-state-file (concat user-emacs-directory "emacs-bookmarks/.bmk-bmenu-state.el"))
  (bookmark-default-file (concat user-emacs-directory "emacs-bookmarks/bmk.emacs"))
  )

;; (use-package speed-type
;; )

(use-package avy
  ;; https://github.com/abo-abo/avy
  ;; like ace-jump
  :config
  (setq avy-timeout-seconds 0.3)
  (setq avy-all-windows 'all-frames)
  :bind
  (("C-M-:" . avy-goto-char-timer)
   ("C-:" . avy-goto-char-2))
  )

(use-package avy-menu
  ;; https://github.com/mrkkrp/avy-menu
  )

(use-package link-hint
  ;; https://github.com/noctuid/link-hint.el
  :bind
  ("C-c l o" . link-hint-open-link)
  ("C-c l c" . link-hint-copy-link))

(use-package benchmark-init
  :config
  ;; To disable collection of benchmark data after init is done.
  (add-hook 'after-init-hook 'benchmark-init/deactivate))

(use-package golden-ratio
  ;; https://github.com/roman/golden-ratio.el
  ;; (seen here: https://tuhdo.github.io/emacs-tutor3.html)
  :diminish golden-ratio-mode
  :config
  ;; (let ((ingenico-system-name "FR0WSC3NRYM2"))
  ;;   (unless (string= (system-name) ingenico-system-name)
  ;;     (golden-ratio-mode)
  ;;     (setq golden-ratio-auto-scale t))
  ;;   )
  )

(use-package projectile
  ;; https://github.com/bbatsov/projectile
  ;; https://projectile.readthedocs.io/en/latest/usage/
  :init
  ;; we mainly want projects defined by a few markers and we always want to take
  ;; the top-most marker. Reorder so other cases are secondary.
  (setq  projectile-project-root-files #'( ".projectile" )
         projectile-project-root-files-functions #'(projectile-root-top-down
                                                    projectile-root-top-down-recurring
                                                    projectile-root-bottom-up
                                                    projectile-root-local))
  :config
  (projectile-mode t)
  (setq projectile-enable-caching t)

  :delight '(:eval (concat " " (projectile-project-namea)))
  :bind (:map projectile-mode-map
              ("C-c p" . projectile-command-map))
  )

;; (projectile-register-project-type 'ada '(".gpr" "src")
;;                                   :project-file ".gpr"
;;                                   :compile "gprbuild"
;;                                   :src-dir "src/"
;;                                   :test-dir "src/tests/")

(major-mode-hydra-define emacs-lisp-mode nil
  ("Eval"
   (("b" eval-buffer "buffer")
    ("e" eval-defun "defun")
    ("r" eval-region "region"))
   "REPL"
   (("I" ielm "ielm"))
   "Test"
   (("t" ert "prompt")
    ("T" (ert t) "all")
    ("F" (ert :failed) "failed"))
   "Doc"
   (("d" describe-foo-at-point "thing-at-pt")
    ("f" describe-function "function")
    ("v" describe-variable "variable")
    ("i" info-lookup-symbol "info lookup"))))

(use-package comb
  ;; https://github.com/cyrus-and/comb
  ;; grep & notes
  ;;
  ;; - repository is cloned in ~/.emacs.d/lisp, the code in comb-report.el is
  ;;   changed
  ;; - use M-x re-builder to open a buffer and dynamically try a regex
  ;; - the shortkeys are not defined in all generated buffer => define a hydra
  :straight
  :straight (:host github :repo "JeremPFT/comb" :branch "master")
  :preface (unless (file-directory-p (concat user-emacs-directory "lisp/comb"))
             (error "missing comb directory"))
  )

;; (use-package popup-kill-ring
;;   :straight (:host github :repo "waymondo/popup-kill-ring" :branch "master")
;;   :config (global-set-key "\M-y" 'popup-kill-ring)
;;   )

(use-package browse-kill-ring
  :straight (:host github :repo "browse-kill-ring/browse-kill-ring" :branch "master")
  :config
  (global-set-key "\M-y" 'browse-kill-ring)
  (setq browse-kill-ring-highlight-current-entry nil)
  )
;;   :straight (:host github :repo "waymondo/popup-kill-ring" :branch "master")

(use-package doom-modeline
  :ensure t
  :config (doom-modeline-mode)
  :init
  (doom-modeline-project-detection 'projectile))

(use-package csharp-mode
  :straight (:host github :repo "josteink/csharp-mode"))

(use-package markdown-mode
  :straight (:host github :repo "jrblevin/markdown-mode"))

(use-package plantuml-mode
  :ensure t
  :config
  (setq

   plantuml-jar-path
   (concat (getenv "HOME") "workspace/plantuml.jar")

   plantuml-default-exec-mode
   'jar)
  )

;; https://github.com/milkypostman/powerline/ ;; TODO

;; (use-package md4rd
;;   ;; reddit inside emacs
;; ;;   )

;; (use-package nnreddit
;; ;;   :config
;;   (custom-set-variables '(gnus-select-method (quote (nnreddit ""))))
;;   )

;; paradox
;; ;; new *Packages* interface. Not used, I find it too heavy

;; (use-package amx
;; ;; completion
;; )

;; (use-package crm-custom
;; ;; completion
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
(add-hook 'elisp-mode-hook (lambda () (electric-pair-mode)))

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

          ;; insert space before operator
          (unless (string= operator ",")
            (unless (= (point) (line-beginning-position))
              (forward-char -1)
              (when (looking-back regexp)
                (unless (or (string= (buffer-substring-no-properties
                                      (point) (+ 2 (point))) "->")
                            (string= (buffer-substring-no-properties
                                      (point) (+ 2 (point))) "*/")
                            (string= (buffer-substring-no-properties
                                      (point) (+ 2 (point))) "++")
                            (string= (buffer-substring-no-properties
                                      (point) (+ 2 (point))) "--"))
                  (insert " ")))
              (forward-char)))

          ;; insert space after operator
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
;;;; elisp (personal, imported)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(add-to-list 'load-path (concat user-emacs-directory "lisp/openssl-cipher"))
(require 'openssl-cipher)

(add-to-list 'load-path (concat user-emacs-directory "lisp"))
(require 'ingenico-parse-log)
(defalias 'yes-or-no-p 'y-or-n-p)
(global-set-key (kbd "<f5>") 'revert-buffer)
(global-set-key (kbd "C-x C-g") 'goto-line)
(global-set-key (kbd "M-/") 'hippie-expand)

(defun indent-buffer ()
  (interactive)
  (let ((position (point)))
    (indent-region (point-min) (point-max))
    (goto-char position)))

;; following work with C-s but not with M-% ... :(

(define-key minibuffer-local-map "(" 'self-insert-command )
(define-key minibuffer-local-ns-map "(" 'self-insert-command )

;; unbind key
(define-key image-map "o" nil)

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
(global-set-key (kbd "C-x C-d") 'counsel-find-file)
(global-set-key (kbd "C-x d") 'counsel-find-file)

(global-set-key (kbd "C-s") 'isearch-forward)
(global-set-key (kbd "C-r") 'isearch-backward)

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

(use-package csv-mode
  :ensure t)

(use-package csv
  :ensure t)

(use-package calfw
  :ensure t)

(use-package page-break-lines
  :disabled ;; dependance of dashboard
  :straight (:host github :repo "purcell/page-break-lines")
  :config
  (set-fontset-font "fontset-default"
                    (cons page-break-lines-char page-break-lines-char)
                    (face-attribute 'default :family))
  )

(use-package dashboard
  :disabled ;; see if useful
  :straight (:host github :repo "emacs-dashboard/emacs-dashboard")
  :after (page-break-lines all-the-icons)
  :ensure t
  :config
  (dashboard-setup-startup-hook)
  (setq
   dashboard-center-content t
   dashboard-banner-logo-title "Emacs Dashboard"
   ;; dashboard-startup-banner nil
   dashboard-set-heading-icons t
   dashboard-set-file-icons t
   dashboard-items (quote ((recents . 5) (bookmarks . 5)))
   )
  (defun dashboard-insert-custom (list-size)
    (insert "Custom text"))
  (add-to-list 'dashboard-item-generators '(custom . dashboard-insert-custom))
  (add-to-list 'dashboard-items '(custom) t)
  )

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
;;;; hydra
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; bindings keys
;;
;; https://github.com/abo-abo/hydra
;; https://github.com/abo-abo/hydra/wiki/Org-agenda
;; https://www.reddit.com/r/emacs/comments/8of6tx/tip_how_to_be_a_beast_with_hydra/

(defhydra hydra-summary ()
  ("m" hydra-magit/body "magit" :exit t) ;; defined in local-packages/git-config.el
  ("b" hydra-bookmarks/body "bookmarks" :exit t)
  ("z" hydra-zoom/body "zoom" :exit t)
  )

(global-set-key (kbd "<f1>") 'hydra-summary/body)



(defvar org-dir (concat (file-name-as-directory (getenv "HOME"))
                        (file-name-as-directory "workspace")
                        (file-name-as-directory "org")
                        "bookmarks"))

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

(defhydra hydra-zoom ()
  "zoom"
  ("+" text-scale-increase "in")
  ("-" text-scale-decrease "out"))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;; initial buffer
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defun jp/initial-buffer()
  (interactive)
  (setq jp--buffer (get-buffer-create "*fetching.org*"))
  (set-buffer jp--buffer)
  (org-mode)
  (insert "#+NAME: output-fetch-repositories\n"
          "#+CALL: ~/workspace/org/startup.org:fetch-repositories()")
  (beginning-of-line)
  jp--buffer
  )

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;; emacs client
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; setenv EMACS_SERVER_FILE=.emacs.d/server/server

(require 'server)
(unless (server-running-p)
  (server-start))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;; tests
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; from https://github.com/abo-abo/hydra/wiki/Projectile
(defhydra hydra-projectile (:color teal
                                   :hint nil)
  "

     Find File            Search/Tags          Buffers                Cache
------------------------------------------------------------------------------------------
_s-f_: file            _a_: ag                _i_: Ibuffer           _c_: cache clear
 _ff_: file dwim       _g_: update gtags      _b_: switch to buffer  _x_: remove known project
 _fd_: file curr dir   _o_: multi-occur     _s-k_: Kill all buffers  _X_: cleanup non-existing
  _r_: recent file                                               ^^^^_z_: cache current
  _d_: dir

"
  ("a"   projectile-ag)
  ("b"   projectile-switch-to-buffer)
  ("c"   projectile-invalidate-cache)
  ("d"   projectile-find-dir)
  ("s-f" projectile-find-file)
  ("ff"  projectile-find-file-dwim)
  ("fd"  projectile-find-file-in-directory)
  ("g"   ggtags-update-tags)
  ("s-g" ggtags-update-tags)
  ("i"   projectile-ibuffer)
  ("K"   projectile-kill-buffers)
  ("s-k" projectile-kill-buffers)
  ("m"   projectile-multi-occur)
  ("o"   projectile-multi-occur)
  ("s-p" projectile-switch-project "switch project")
  ("p"   projectile-switch-project)
  ("s"   projectile-switch-project)
  ("r"   projectile-recentf)
  ("x"   projectile-remove-known-project)
  ("X"   projectile-cleanup-known-projects)
  ("z"   projectile-cache-current-file)
  ("`"   hydra-projectile-other-window/body "other window")
  ("q"   nil "cancel" :color blue))

(global-set-key (kbd "<f3>") 'hydra-projectile/body)
(put 'downcase-region 'disabled nil)

;; (require 'hide-region)
;; (require 'hide-lines)
;; (require 'fold-this)
;; TODO see origami

;; (speedbar-add-supported-extension ".ads")
;; (speedbar-add-supported-extension ".adb")

;; frame & display:
;; https://stackoverflow.com/questions/16481984/get-width-of-current-monitor-in-emacs-lisp
;; https://www.gnu.org/software/emacs/manual/html_node/emacs/Frame-Commands.html
;; https://www.gnu.org/software/emacs/manual/html_node/elisp/Parameter-Access.html
(defun jpi-full-screen ()
  (interactive)
  (cond
   (ingenico-computer-p
    (set-frame-position (selected-frame) 0 0)
    (set-frame-width (selected-frame) 188)
    (set-frame-height (selected-frame) 52))
   ;; (set-frame-position (selected-frame) -5 0)
   ;; (set-frame-width (selected-frame) 380)
   ;; (set-frame-height (selected-frame) 53))
   (home-computer-p
    (set-frame-position (selected-frame) 0 0)
    (set-frame-width (selected-frame) 188)
    (set-frame-height (selected-frame) 53)))
  ;; (cond
  ;;  ((string= (system-name) ingenico-system-name)
  ;;   (set-frame-position (selected-frame) 0 0)
  ;;   (set-frame-width (selected-frame) 188)
  ;;   (set-frame-height (selected-frame) 52))
  ;;  ;; (set-frame-position (selected-frame) -5 0)
  ;;  ;; (set-frame-width (selected-frame) 380)
  ;;  ;; (set-frame-height (selected-frame) 53))
  ;;  ((string= (system-name) home-system-name)
  ;;   (set-frame-position (selected-frame) 0 0)
  ;;   (set-frame-width (selected-frame) 188)
  ;;   (set-frame-height (selected-frame) 53)))
  )
