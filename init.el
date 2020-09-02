;; enter debug mode if necessary

;; [[file:~/.emacs.d/README.org::*enter%20debug%20mode%20if%20necessary][enter debug mode if necessary:1]]
(toggle-debug-on-error)
;; enter debug mode if necessary:1 ends here

;; personnal functions & shortcuts

;; [[file:~/.emacs.d/README.org::*personnal%20functions%20&%20shortcuts][personnal functions & shortcuts:1]]
;;;; default directory
(setq default-directory user-emacs-directory)
;; personnal functions & shortcuts:1 ends here

;; [[file:~/.emacs.d/README.org::*personnal%20functions%20&%20shortcuts][personnal functions & shortcuts:2]]
;;;; custom file
(setq custom-file (expand-file-name "emacs-custom.el" user-emacs-directory))
(when (file-exists-p custom-file) (load custom-file))
;; personnal functions & shortcuts:2 ends here

;; [[file:~/.emacs.d/README.org::*personnal%20functions%20&%20shortcuts][personnal functions & shortcuts:3]]
;;;; global modes
(global-auto-revert-mode)
(global-hl-line-mode)
(electric-pair-mode)
;; personnal functions & shortcuts:3 ends here

;; [[file:~/.emacs.d/README.org::*personnal%20functions%20&%20shortcuts][personnal functions & shortcuts:4]]
;;;; custom
(add-to-list 'default-frame-alist '(fullscreen . maximized))
(setq org-indent-indentation-per-level 0
      org-adapt-indentation nil)

(defun indent-buffer ()
  (interactive)
  (let ((position (point)))
    (indent-region (point-min) (point-max))
    (goto-char position)))
;; personnal functions & shortcuts:4 ends here

;; [[file:~/.emacs.d/README.org::*personnal%20functions%20&%20shortcuts][personnal functions & shortcuts:5]]
(defconst lisp-dir (file-name-as-directory (concat user-emacs-directory "lisp")))
(defalias 'yes-or-no-p 'y-or-n-p)
(global-set-key (kbd "<f5>") 'revert-buffer)
(global-set-key (kbd "C-x C-g") 'goto-line)

(defconst ingenico-computer-name "FR0WSC3NRYM2")
(defconst home-computer-name "DESKTOP-5R08DIM")
(defconst ingenico-computer-p (string= (system-name) ingenico-computer-name))
(defconst home-computer-p (string= (system-name) home-computer-name))

(defconst windows-p (eq system-type 'windows-nt))
(defconst linux-p (eq system-type 'gnu/linux))
;; personnal functions & shortcuts:5 ends here

;; Speed-up at startup: boost garbage collector memory

;; [[file:~/.emacs.d/README.org::*Speed-up%20at%20startup:%20boost%20garbage%20collector%20memory][Speed-up at startup: boost garbage collector memory:1]]
(defconst normal-gc-cons-threshold (* 20 1024 1024))
(defconst init-gc-cons-threshold (* 20 1024 1024))
(setq gc-cons-threshold init-gc-cons-threshold)
(add-hook 'emacs-startup-hook
	  (lambda () (setq gc-cons-threshold normal-gc-cons-threshold)))
;; Speed-up at startup: boost garbage collector memory:1 ends here

;; package

;; [[file:~/.emacs.d/README.org::*package][package:1]]
(require 'package)
(add-to-list 'package-archives
	     '("melpa" . "https://melpa.org/packages"))
(add-to-list 'package-archives
	     '("MELPA Stable" . "https://stable.melpa.org/packages") t)
(unless package--initialized (package-initialize t))
;; package:1 ends here

;; straight & use-package

;; [[file:~/.emacs.d/README.org::*straight%20&%20use-package][straight & use-package:1]]
(defvar bootstrap-version)
(let ((bootstrap-file
       (concat user-emacs-directory "straight/repos/straight.el/bootstrap.el"))
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
(setq straight-use-package-by-default t) ;; TODO what ?

;; (setq straight-profiles
;;       '((nil . "default.el")
;;         ;; Packages which are pinned to a specific commit.
;;         (pinned . "pinned.el")))
;; straight & use-package:1 ends here

;; use-package extensions

;; [[file:~/.emacs.d/README.org::*use-package%20extensions][use-package extensions:1]]
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

(use-package delight
  :disabled)

(use-package git-package
  :straight (:host github :repo "mnewt/git-package"))
;; use-package extensions:1 ends here

;; Hydra

;; [[file:~/.emacs.d/README.org::*Hydra][Hydra:1]]
(use-package hydra
  ;; bindings keys
  ;; https://github.com/abo-abo/hydra
  )

(use-package major-mode-hydra
  :after hydra
  :bind
  ("<f2>" . major-mode-hydra)
  )

(use-package use-package-hydra
  ;; https://gitlab.com/to1ne/use-package-hydra
  :straight
  (:host gitlab :repo "to1ne/use-package-hydra" :branch "master")
  :after use-package hydra
  )
;; Hydra:1 ends here

;; magit

;; [[file:~/.emacs.d/README.org::*magit][magit:1]]
(use-package magit
  ;;
  ;; TODO see magit-gitflow
  ;;
  ;; :pin gnu
  :after hydra
  :config

  ;; speed up magit
  (when (eq system-type 'windows-nt)
    (setq exec-path (add-to-list 'exec-path "C:/Program Files/Git/cmd"))
    (setq exec-path (add-to-list 'exec-path "C:/Program Files/Git/bin"))
    (setenv "PATH" (concat "C:\\Program Files\\Git\\cmd;"
			   "C:\\Program Files\\Git\\bin;"
			   (getenv "PATH"))))
  :hydra
  (hydra-magit (:hint nil)
	       "
  _s_ status    _c_ commit
  _P_ pull      _la_ log all
  _p_ push      _d_ diff
  "
	       ("p" magit-push :exit t)
	       ("P" magit-pull :exit t)
	       ("c" magit-commit :exit t)
	       ("d" magit-diff :exit t)
	       ("la" magit-log-all :exit t)
	       ("s" magit-status :exit t)
	       )
  )

(use-package git-link
  :straight (:host github :repo "sshaw/git-link")
  )

;; (defhydra hydra-magit (:hint nil)
;;   "
;; _s_ status    _c_ commit
;; _P_ pull      _la_ log all
;; _p_ push      _d_ diff
;; "
;;   ("p" magit-push :exit t)
;;   ("P" magit-pull :exit t)
;;   ("c" magit-commit :exit t)
;;   ("d" magit-diff :exit t)
;;   ("la" magit-log-all :exit t)
;;   ("s" magit-status :exit t)
;;   )
;; magit:1 ends here

;; Encoding

;; [[file:~/.emacs.d/README.org::*Encoding][Encoding:1]]
;; utf-8-unix
;; windows-1252

(setq utf-translate-cjk-mode nil) ; disable CJK coding/encoding (Chinese/Japanese/Korean characters)
(set-keyboard-coding-system 'utf-8-unix) ; For old Carbon emacs on OS X only
(setq locale-coding-system 'windows-1252)
(set-default-coding-systems 'utf-8-unix)
(prefer-coding-system 'utf-8-unix)

  ;;;; ensure org timestamp is in english format
(setq system-time-locale "C")
;; Encoding:1 ends here

;; yasnippet

;; [[file:~/.emacs.d/README.org::*yasnippet][yasnippet:1]]
(use-package yasnippet
  ;; https://github.com/joaotavora/yasnippet
  ;; http://joaotavora.github.io/yasnippet/
  :config
  (yas-global-mode 1)
  )
;; yasnippet:1 ends here

;; fill column 

;; [[file:~/.emacs.d/README.org::*fill%20column][fill column:1]]
(use-package fill-column-indicator
  :config
  (defun set-fci-to-80 ()
    (setq fci-rule-column 80))
  (add-hook 'prog-mode-hook 'fci-mode)
  (add-hook 'prog-mode-hook 'set-fci-to-80)
  (add-hook 'ada-mode-hook 'fci-mode)
  )
;; fill column:1 ends here

;; undo-tree


;; [[file:~/.emacs.d/README.org::*undo-tree][undo-tree:1]]
(use-package undo-tree
  :straight
  (:host github :repo "emacsorphanage/undo-tree" :branch "master"))
;; undo-tree:1 ends here

;; link-hint

;; [[file:~/.emacs.d/README.org::*link-hint][link-hint:1]]
(use-package link-hint
  :bind
  ("C-c l o" . link-hint-open-link)
  ("C-c l c" . link-hint-copy-link))
;; link-hint:1 ends here

;; moving in emacs

;; [[file:~/.emacs.d/README.org::*moving%20in%20emacs][moving in emacs:1]]
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
;; moving in emacs:1 ends here

;; browse-kill-ring

;; [[file:~/.emacs.d/README.org::*browse-kill-ring][browse-kill-ring:1]]
(use-package browse-kill-ring
  :straight (:host github :repo "browse-kill-ring/browse-kill-ring" :branch "master")
  :config
  (global-set-key "\M-y" 'browse-kill-ring)
  (setq browse-kill-ring-highlight-current-entry nil)
  )
;; browse-kill-ring:1 ends here

;; line numbering. linum

;; [[file:~/.emacs.d/README.org::*line%20numbering.%20linum][line numbering. linum:1]]
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
;; line numbering. linum:1 ends here

;; completion

;; [[file:~/.emacs.d/README.org::*completion][completion:1]]
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
;; completion:1 ends here

;; visual

;; [[file:~/.emacs.d/README.org::*visual][visual:1]]
(use-package all-the-icons
  :ensure t
  :config
  (unless (file-directory-p (concat user-emacs-directory "all-the-icons-fonts"))
    (make-directory (concat user-emacs-directory "all-the-icons-fonts"))
    (error "please run all-the-icons-install-fonts in .emacs.d/all-the-icons-fonts")
    ))

(use-package abyss-theme
  :custom-face
  (font-lock-keyword-face ((t (:foreground "light goldenrod"))))
  (font-lock-string-face ((t (:foreground "violet"))))
  )
;; visual:1 ends here

;; bookmark+

;; [[file:~/.emacs.d/README.org::*bookmark+][bookmark+:1]]
;; TODO see if necessary (load-file (concat user-emacs-directory "lisp/bookmark-plus/bookmark+-mac.el"))
(use-package bookmark+
  ;; https://www.emacswiki.org/emacs/BookmarkPlus
  :straight
  (:host github :repo "emacsmirror/bookmark-plus" :branch "master")
  :custom
  (bmkp-bmenu-state-file (concat user-emacs-directory "emacs-bookmarks/.bmk-bmenu-state.el"))
  (bookmark-default-file (concat user-emacs-directory "emacs-bookmarks/bmk.emacs"))
  )
;; bookmark+:1 ends here

;; TODO ada mode                                                         :dev:

;; [[file:~/.emacs.d/README.org::*ada%20mode][ada mode:1]]
(require 'imenu)

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
;; ada mode:1 ends here

;; python                                                                :dev:

;; [[file:~/.emacs.d/README.org::*python][python:1]]
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
;; python:1 ends here

;; fic-mode: highlight TODO/FIXME/...                                    :dev:

;; [[file:~/.emacs.d/README.org::*fic-mode:%20highlight%20TODO/FIXME/...][fic-mode: highlight TODO/FIXME/...:1]]
(use-package fic-mode
  :config
  (add-hook 'prog-mode-hook #'fic-mode)
  (add-hook 'ada-mode-hook #'fic-mode)
  (defun fic-view-listing ()
    "Use occur to list related FIXME keywords"
    (interactive)
    (occur "\\<\\(FIXME\\|TODO\\|BUG\\):?"))
  )
;; fic-mode: highlight TODO/FIXME/...:1 ends here

;; ibuffer

;; [[file:~/.emacs.d/README.org::*ibuffer][ibuffer:1]]
(use-package ibuffer
  ;; https://github.com/reinh/dotemacs/blob/master/conf/init.org#ido
  ;; https://www.emacswiki.org/emacs/IbufferMode

  :after hydra

  :bind
  ("C-x C-b" . ibuffer)

  :bind-keymap
  ("<f1>" . hydra-ibuffer-main/body)

  ;; :hook
  ;; ((lambda ()
  ;;   (ibuffer-switch-to-saved-filter-groups "default")) . ibuffer-mode)

  :init
  (add-hook 'ibuffer-mode-hook
	    (lambda ()
	      (ibuffer-auto-mode)
	      (ibuffer-switch-to-saved-filter-groups "default")))

  :config
  (progn
;;;###autoload (autoload 'ibuffer-do-sort-by-filename-or-dired "init")
    (define-ibuffer-sorter filename-or-dired
      "Sort the buffers by their pathname."
      (:description "filenames plus dired")
      (string-lessp
       (with-current-buffer (car a)
	 (or buffer-file-name
	     (if (eq major-mode 'dired-mode)
		 (expand-file-name dired-directory))
	     ;; so that all non pathnames are at the end
	     "~"))
       (with-current-buffer (car b)
	 (or buffer-file-name
	     (if (eq major-mode 'dired-mode)
		 (expand-file-name dired-directory))
	     ;; so that all non pathnames are at the end
	     "~"))))

    (define-key ibuffer-mode-map (kbd "s p")
      'ibuffer-do-sort-by-filename-or-dired)

    (setq ibuffer-show-empty-filter-groups t

	  ibuffer-saved-filter-groups
	  (quote (("default"
		   ("bbvakeystore" (name . "bbvakeystore"))
		   ("bbvamkstore" (name . "bbvamkstore"))
		   ("bbvaskstore" (name . "bbvaskstore"))
		   ("bbvatkgen" (name . "bbvatkgen"))
		   ("bbvatkexp" (name . "bbvatkexp"))
		   ("bookmarks" (name . "org/bookmarks"))
		   )))

	  ibuffer-directory-abbrev-alist
	  (quote (("~/Ingenico_Workspace/SUPTER-7682_mexique"
		   . "SUPTER-7682_mexique")
		  ("dllsch_t3_bbva_key_injection_pin_block_private"
		   . "dllsch_t3_..._private")))

	  ibuffer-default-sorting-mode (quote filename-or-dired)

	  ibuffer-formats
	  (quote
	   ((mark modified read-only locked " "
		  (name 25 25 :left :elide)
		  " "
		  (size 7 -1 :right)
		  " "
		  (mode 8 8 :left :elide)
		  " " filename-and-process)
	    (mark " "
		  (name 16 -1)
		  " " filename)))
	  ) ;; setq

    (define-ibuffer-column size-h
      (:name "Size" :inline t)
      (cond
       ((> (buffer-size) 1000000) (format "%7.1fM" (/ (buffer-size) 1000000.0)))
       ((> (buffer-size) 100000) (format "%7.0fk" (/ (buffer-size) 1000.0)))
       ((> (buffer-size) 1000) (format "%7.1fk" (/ (buffer-size) 1000.0)))
       (t (format "%8d" (buffer-size)))))
    ) ;; progn

  :hydra
  (hydra-ibuffer-main
   (:color pink :hint nil)
   "
  ^Navigation^ | ^Mark^        | ^Actions^        | ^View^
 -^----------^-+-^----^--------+-^-------^--------+-^----^-------
   _k_:    ʌ   | _m_: mark     | _D_: delete      | _g_: refresh
  _RET_: visit | _u_: unmark   | _S_: save        | _s_: sort
   _j_:    v   | _*_: specific | _a_: all actions | _/_: filter
 -^----------^-+-^----^--------+-^-------^--------+-^----^-------
 "
   ("j" ibuffer-forward-line)
   ("RET" ibuffer-visit-buffer :color blue)
   ("k" ibuffer-backward-line)

   ("m" ibuffer-mark-forward)
   ("u" ibuffer-unmark-forward)
   ("*" hydra-ibuffer-mark/body :color blue)

   ("D" ibuffer-do-delete)
   ("S" ibuffer-do-save)
   ("a" hydra-ibuffer-action/body :color blue)

   ("g" ibuffer-update)
   ("s" hydra-ibuffer-sort/body :color blue)
   ("/" hydra-ibuffer-filter/body :color blue)

   ("o" ibuffer-visit-buffer-other-window "other window" :color blue)
   ("q" quit-window "quit ibuffer" :color blue)
   ("." nil "toggle hydra" :color blue))

  (hydra-ibuffer-mark
   (:color teal
	   :columns 5
	   :after-exit (hydra-ibuffer-main/body))
   "Mark"
   ("*" ibuffer-unmark-all "unmark all")
   ("M" ibuffer-mark-by-mode "mode")
   ("m" ibuffer-mark-modified-buffers "modified")
   ("u" ibuffer-mark-unsaved-buffers "unsaved")
   ("s" ibuffer-mark-special-buffers "special")
   ("r" ibuffer-mark-read-only-buffers "read-only")
   ("/" ibuffer-mark-dired-buffers "dired")
   ("e" ibuffer-mark-dissociated-buffers "dissociated")
   ("h" ibuffer-mark-help-buffers "help")
   ("z" ibuffer-mark-compressed-file-buffers "compressed")
   ("b" hydra-ibuffer-main/body "back" :color blue))

  (hydra-ibuffer-action
   (:color teal :columns 4
	   :after-exit
	   (if (eq major-mode 'ibuffer-mode)
	       (hydra-ibuffer-main/body)))
   "Action"
   ("A" ibuffer-do-view "view")
   ("E" ibuffer-do-eval "eval")
   ("F" ibuffer-do-shell-command-file "shell-command-file")
   ("I" ibuffer-do-query-replace-regexp "query-replace-regexp")
   ("H" ibuffer-do-view-other-frame "view-other-frame")
   ("N" ibuffer-do-shell-command-pipe-replace "shell-cmd-pipe-replace")
   ("M" ibuffer-do-toggle-modified "toggle-modified")
   ("O" ibuffer-do-occur "occur")
   ("P" ibuffer-do-print "print")
   ("Q" ibuffer-do-query-replace "query-replace")
   ("R" ibuffer-do-rename-uniquely "rename-uniquely")
   ("T" ibuffer-do-toggle-read-only "toggle-read-only")
   ("U" ibuffer-do-replace-regexp "replace-regexp")
   ("V" ibuffer-do-revert "revert")
   ("W" ibuffer-do-view-and-eval "view-and-eval")
   ("X" ibuffer-do-shell-command-pipe "shell-command-pipe")
   ("b" nil "back"))

  (hydra-ibuffer-sort
   (:color amaranth :columns 3)
   "Sort"
   ("i" ibuffer-invert-sorting "invert")
   ("a" ibuffer-do-sort-by-alphabetic "alphabetic")
   ("v" ibuffer-do-sort-by-recency "recently used")
   ("s" ibuffer-do-sort-by-size "size")
   ("f" ibuffer-do-sort-by-filename/process "filename")
   ("m" ibuffer-do-sort-by-major-mode "mode")
   ("b" hydra-ibuffer-main/body "back" :color blue))

  (hydra-ibuffer-filter
   (:color amaranth :columns 4)
   "Filter"
   ("m" ibuffer-filter-by-used-mode "mode")
   ("M" ibuffer-filter-by-derived-mode "derived mode")
   ("n" ibuffer-filter-by-name "name")
   ("c" ibuffer-filter-by-content "content")
   ("e" ibuffer-filter-by-predicate "predicate")
   ("f" ibuffer-filter-by-filename "filename")
   (">" ibuffer-filter-by-size-gt "size")
   ("<" ibuffer-filter-by-size-lt "size")
   ("/" ibuffer-filter-disable "disable")
   ("b" hydra-ibuffer-main/body "back" :color blue))
  ); use-package ibuffer
;; ibuffer:1 ends here

;; dired+

;; [[file:~/.emacs.d/README.org::*dired+][dired+:1]]
(use-package dired+
  :straight
  (:host github :repo "emacsmirror/dired-plus" :branch "master")
  :config
  (progn
    ;; I want the same color for file name and extension
    (setq diredp-file-suffix diredp-file-name)
    ) ;; end progn
  :bind
  (:map dired-mode-map
	("M-b" . backward-word)
	("<f1>" . hydra-dired/body)
	)

  ;; :hook (lambda ()
  ;;         (local-set-key (kbd "<f1>") (quote hydra-summary/body))
  ;;         ;; (local-set-key (kbd "M-b") (quote backward-word))
  ;;         )

  :hydra
  (hydra-dired (:hint nil :color pink)
	       "
_+_ mkdir          _v_iew           _m_ark             _(_ details        _i_nsert-subdir    wdired
_C_opy             _O_ view other   _U_nmark all       _)_ omit-mode      _$_ hide-subdir    C-x C-q : edit
_D_elete           _o_pen other     _u_nmark           _l_ redisplay      _w_ kill-subdir    C-c C-c : commit
_R_ename           _M_ chmod        _t_oggle           _g_ revert buf     _e_ ediff          C-c ESC : abort
_Y_ rel symlink    _G_ chgrp        _E_xtension mark   _s_ort             _=_ pdiff
_S_ymlink          ^ ^              _F_ind marked      _._ toggle hydra   \\ flyspell
_r_sync            ^ ^              ^ ^                ^ ^                _?_ summary
_z_ compress-file  _A_ find regexp
_Z_ compress       _Q_ repl regexp

T - tag prefix
"
	       ("\\" dired-do-ispell)
	       ("(" dired-hide-details-mode)
	       (")" dired-omit-mode)
	       ("+" dired-create-directory)
	       ("=" diredp-ediff)         ;; smart diff
	       ("?" dired-summary)
	       ("$" diredp-hide-subdir-nomove)
	       ("A" dired-do-find-regexp)
	       ("C" dired-do-copy)        ;; Copy all marked files
	       ("D" dired-do-delete)
	       ("E" dired-mark-extension)
	       ("e" dired-ediff-files)
	       ("F" dired-do-find-marked-files)
	       ("G" dired-do-chgrp)
	       ("g" revert-buffer)        ;; read all directories again (refresh)
	       ("i" dired-maybe-insert-subdir)
	       ("l" dired-do-redisplay)   ;; relist the marked or singel directory
	       ("M" dired-do-chmod)
	       ("m" dired-mark)
	       ("O" dired-display-file)
	       ("o" dired-find-file-other-window)
	       ("Q" dired-do-find-regexp-and-replace)
	       ("R" dired-do-rename)
	       ("r" dired-do-rsynch)
	       ("S" dired-do-symlink)
	       ("s" dired-sort-toggle-or-edit)
	       ("t" dired-toggle-marks)
	       ("U" dired-unmark-all-marks)
	       ("u" dired-unmark)
	       ("v" dired-view-file)      ;; q to exit, s to search, = gets line #
	       ("w" dired-kill-subdir)
	       ("Y" dired-do-relsymlink)
	       ("z" diredp-compress-this-file)
	       ("Z" dired-do-compress)
	       ("q" nil)
	       ("." nil :color blue))
  )

(add-hook 'dired-mode-hook
	  (lambda ()
	    (local-set-key (kbd "<f1>") (quote hydra-summary/body))
	    ;; (local-set-key (kbd "M-b") (quote backward-word))
	    ))

(use-package dired-filter
  ;; TODO replace shortcuts with hydra
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

(add-hook 'dired-mode-hook (lambda ()
			     (when (eq system-type 'windows-nt)
			       (make-local-variable 'coding-system-for-read)
			       (setq coding-system-for-read 'utf-8-dos))
			     ) ;; end lambda
	  ) ;; add-hook

(use-package find-dired+
  ;; https://www.emacswiki.org/emacs/find-dired+.el

  :disabled ;; freeze emacs ???

  :load-path "local-packages/"
  :config

  (progn
    (when (eq system-type 'windows-nt)
      (setq find-program "C:/Ingenico/GnuWin32/bin/find.exe")
      ) ;; end when
    ) ;; end progn
  )
;; dired+:1 ends here

;; calfw calendar

;; [[file:~/.emacs.d/README.org::*calfw%20calendar][calfw calendar:1]]
(use-package calfw
  :ensure t)
;; calfw calendar:1 ends here

;; hydra custom

;; [[file:~/.emacs.d/README.org::*hydra%20custom][hydra custom:1]]
(defhydra hydra-summary ()
  ("m" hydra-magit/body "magit" :exit t) ;; defined in local-packages/git-config.el
  ("b" hydra-bookmarks/body "bookmarks" :exit t)
  ("z" hydra-zoom/body "zoom" :exit t)
  )

(global-set-key (kbd "<f1>") 'hydra-summary/body)

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
;; hydra custom:1 ends here
