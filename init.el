;;; init.el --- emacs setup

(leaf emacs-html-articles
  :doc Emacs-la-communaute-se-demande-comment-accroitre-son-attractivite
  :url https://edi.developpez.com/actu/309395/Emacs-la-communaute-se-demande-comment-accroitre-son-attractivite-certains-suggerent-plus-de-modernite-et-Richard-Stallman-se-prete-au-jeu-des-echanges-d-idees/
  )

(unless (file-exists-p (emacs-dir-file "init-package.el"))
  (let ((dir "~/.emacs.d/elpa"))
    (when (file-exists-p dir)
      (delete-directory dir t)))

  (eval-and-compile
    (defvar jpi/package-refresh-contents-p nil)

    (customize-set-variable
     'package-archives
     '(
       ("org" . "https://orgmode.org/elpa/")
       ("gnu" . "https://elpa.gnu.org/packages/")
       ("melpa" . "https://melpa.org/packages/")
       ("melpa stable" . "https://stable.melpa.org/packages/")))
    (unless jpi/package-refresh-contents-p
      (package-initialize)
      (package-refresh-contents)
      (setq jpi/package-refresh-contents-p t))

    (unless (package-installed-p 'leaf)
      (package-install 'leaf))

    (write-region "" nil (emacs-dir-file "init-package.el"))
    )

  ) ;; unless init-package.el

(leaf leaf-setup
  :url https://github.com/conao3/leaf.el
  :init
  (leaf leaf-keywords
    :url https://github.com/conao3/leaf-keywords.el
    :init
    (leaf hydra
      :url https://github.com/abo-abo/hydra
      :ensure t)
    (leaf el-get
      :url https://github.com/dimitri/el-get
      :url https://www.emacswiki.org/emacs/el-get
      :ensure t)
    (leaf blackout
      :ensure t
      :url https://github.com/raxod502/blackout
      :config
      (blackout 'emacs-lisp-mode "elisp")
      (blackout 'eldoc-mode "")
      (blackout 'isearch-mode "")
      )
    :ensure t
    :config
    (leaf-keywords-init)) ;; leaf-keywords

  (leaf feather
    :disabled t
    :ensure t
    :require blackout
    :config
    (feather-mode 1)
    (customize-set-variable 'leaf-alias-keyword-alist '((:ensure . :package)))
    :blackout feather-mode
    ) ;; feather

  (leaf leaf-tree
    :ensure t
    :bind
    :blackout leaf-tree-mode
    ) ;; leaf-tree

  ) ;; leaf-setup

(leaf jpi/functions
  :config
  (defun jpi/indent-buffer ()
    (interactive)
    (let ((position (point)))
      (cond ((derived-mode-p 'cc-mode)
             (clang-format-buffer))
            (t
             (indent-region (point-min) (point-max))
             (goto-char position)))))

  (defalias 'indent-buffer 'jpi/indent-buffer)

  (defun jpi/initial-buffer ()
    (interactive)
    (let ((jp--buffer (get-buffer-create "*fetching.org*")))
      (set-buffer jp--buffer)
      (org-mode)
      (insert "#+NAME: output-fetch-repositories\n"
              "#+CALL: ~/workspace/org/startup.org:fetch-repositories()")
      (beginning-of-line)
      jp--buffer
      ))

  (defun jpi/stop-loading-file ()
    "Use in elisp file to prevent loading part below the call."
    (with-current-buffer " *load*"
      (goto-char (point-max))))

  (defun jpi/untabify-whole-buffer ()
    "Ensure there is no tabs in files, except for makefiles."
    (unless (derived-mode-p 'makefile-mode)
      (untabify (point-min) (point-max))))

  (defun jpi/kill-passwords-gpg ()
    "Kill passwords.org.gpg file before killing emacs.
Prevent to prompt for the password at restart."
    (interactive)
    (let ((buffer (get-buffer "passwords.org.gpg")))
      (when buffer
        (kill-buffer buffer))))

  (defun jpi/indent-prog-modes ()
    "Used to automatically indent a file in a prog-mode before
saving it."
    (when (derived-mode-p 'prog-mode)
      (indent-buffer)))

  (defun jpi/org-save-this-readme ()
    "Old function to automaticaly save and tangle README.org"
    (let ((this-file-name (expand-file-name "README.org" user-emacs-directory))
          (init-el-file (expand-file-name "init.el" user-emacs-directory))
          (init-elc-file (expand-file-name "init.elc" user-emacs-directory)))
      (when (and (not (eq (buffer-file-name) nil))
                 (string= (buffer-file-name) this-file-name))
        (when (file-exists-p init-el-file) (delete-file init-el-file))
        (when (file-exists-p init-elc-file) (delete-file init-elc-file))
        (org-babel-tangle)
        ;; (when (y-or-n-p-with-timeout "Recompile? " 2 nil)
        ;;   (byte-compile-file "init.el" t))
        ))
    ) ;; jpi/org-save-this-readme
  ;; (add-hook 'after-save-hook 'org-save-this-readme)

  )

(leaf jpi-constants
  :config
  (leaf computers-identifications
    :config
    (leaf computers-names
      :config
      (defconst current-computer-name
        (upcase (system-name)))

      (defconst ingenico-computer-name
        "FR0WSC3NRYM2")

      (defconst home-computer-name
        "DESKTOP-5R08DIM")

      (defconst birdz-computer-name
        "JPIFFRET-PC")

      (defconst birdz-debian-computer-name
        "DEBIAN-BIRDZ-JPI")
      ) ;; computers-names

    (leaf computers-predicates
      :config
      (defconst ingenico-computer-p
        (string= current-computer-name
                 ingenico-computer-name))

      (defconst home-computer-p
        (string= current-computer-name
                 home-computer-name))

      (defconst birdz-computer-p
        (string= current-computer-name
                 birdz-computer-name))

      (defconst birdz-debian-computer-p
        (string= current-computer-name
                 birdz-debian-computer-name))
      ) ;; computers-predicates

    (leaf os-predicates
      :config
      (defconst windows-p (eq system-type 'windows-nt))
      (defconst cygwin-p (eq system-type 'cygwin))
      (defconst linux-p (eq system-type 'gnu/linux))

      (unless (or
               ingenico-computer-p
               home-computer-p
               birdz-computer-p
               birdz-debian-computer-p)
        (warn (concat "current computer unknown: " current-computer-name)))
      ) ;; os-predicates
    ) ;; computers-identifications

  (leaf directories
    :config

    (defconst home-dir
      (file-name-as-directory (getenv "HOME")))

    (defconst home-bin-dir
      (file-name-as-directory
       (expand-file-name "bin" home-dir)))

    (unless (file-exists-p home-bin-dir) (warn "please create \"~/bin\" directory"))

    (defconst workspace-dir
      (file-name-as-directory (expand-file-name "workspace" home-dir)))

    (defconst emacs-install-lisp-dir
      (file-name-as-directory
       (cond (linux-p "/usr/share/emacs/26.1/lisp")
             (windows-p "e:/programs/emacs-27.1-x86_64/share/emacs/27.1/lisp"))))

    (defconst lisp-dir
      (file-name-as-directory (concat user-emacs-directory "lisp")))
    (add-to-list 'load-path lisp-dir)
    ) ;; directories
  ) ;; jpi/constants

(leaf jpi/set-default-face
  :config
  (defconst face-foundry (cond
                          ((or windows-p cygwin-p) "outline")
                          (linux-p   "PfEd")
                          (t         "")
                          ))
  (defconst face-family (cond
                         ((or windows-p cygwin-p) "Consolas")
                         (linux-p   "DejaVu Sans Mono")
                         (t         "")
                         ))
  (defconst face-height (cond
                         <<<<<<< Updated upstream
                         (home-computer-p 200)
                         (birdz-debian-computer-p 180)
                         =======
                         (home-computer-p 240)
                         (birdz-debian-computer-p 140)
                         >>>>>>> Stashed changes
                         (t 140)))

  (set-face-attribute 'default nil
                      :inherit nil
                      :stipple nil
                      ;; :background "#050000"
                      ;; :foreground "#bbe0f0"
                      :inverse-video nil
                      :box nil
                      :strike-through nil
                      :overline nil
                      :underline nil
                      :slant 'normal
                      :weight 'normal
                      :height face-height
                      :width 'normal
                      :foundry face-foundry
                      :family face-family)
  ) ;; jpi/faces

(leaf emacs
  :config
  (leaf cus-start
    :doc "define customization properties of builtins"
    :tag "builtin" "internal"
    :custom ((user-full-name . "Jeremy Piffret")
             (user-mail-address . "j.piffret@gmail.com")
             (user-login-name . "jpiffret")
             (column-number-mode . t)
             (fill-column . 69)
             (truncate-lines . t)
             (menu-bar-mode . t)
             (tool-bar-mode . t)
             (scroll-bar-mode . t)
             (indent-tabs-mode . nil)
             (show-paren-mode . t)
             (electric-pair-mode . t)
             (global-hl-line-mode . t)
             (frame-title-format .
                                 '(:eval
                                   (format "%s: %s %s"
                                           (or (file-remote-p default-directory 'host)
                                               system-name)
                                           (buffer-name)
                                           (cond
                                            (buffer-file-truename
                                             (concat "(" buffer-file-truename ")"))
                                            (dired-directory
                                             (concat "{" dired-directory "}"))
                                            (t
                                             "[no file]")))))
             ) ;; :custom
    :config
    (defalias 'yes-or-no-p 'y-or-n-p)
    :bind*
    ("<f5>" . revert-buffer)
    ("C-x C-g" . goto-line)
    ("C-*" . next-error)
    ("C-/" . previous-error)
    ("C-c C-o" . org-open-at-point-global)

    :hook
    (before-save-hook . jpi/untabify-whole-buffer)
    (before-save-hook . delete-trailing-whitespace)
    (kill-emacs-hook . jpi/kill-passwords-gpg)
    (before-save-hook . jpi/indent-prog-modes)
    ) ;; cus-start

  (leaf emacs-env
    :config
    (setq shell-command-switch "-c")
    (let ((dir-list (cond (linux-p '(
                                     "/opt/gnatstudio/bin"
                                     ))
                          (birdz-computer-p '(
                                              "c:/installs/msys64/usr/bin"
                                              ))
                          (home-computer-p '(
                                             "c:/Program Files/Git/cmd"
                                             "c:/Program Files/Git/bin"
                                             "e:/programs/cygwin64/bin"
                                             "C:/Program Files (x86)/GnuPG/bin"
                                             ))
                          (t
                           (warn "ERROR JPI: undefined environment for this computer")
                           nil)
                          )))
      (dolist (dir dir-list)
        (setenv "PATH" (concat dir path-separator (getenv "PATH")))
        (setq exec-path (add-to-list 'exec-path dir))))
    ) ;; emacs-env
  (leaf server
    :require t
    :config
    (unless (server-running-p)
      (server-start)))
  (leaf emacs-visual
    :config
    (add-to-list 'default-frame-alist '(fullscreen . maximized))
    (leaf zenburn-theme
      :disabled t
      :ensure t
      :config
      (load-theme 'zenburn t))
    (leaf solarized-theme
      :url https://github.com/bbatsov/solarized-emacs
      :ensure t
      :config
      (load-theme 'solarized-dark t)
      :custom
      (solarized-use-variable-pitch . nil)
      (solarized-scale-org-headlines . nil)
      )
    (leaf face-remap
      :hydra (hydra-zoom
              (global-map "<f2>")
              "zoom"
              ("g" text-scale-increase "in")
              ("l" text-scale-decrease "out")))
    (leaf linum
      :config
      (defvar linum-format-fmt)
      (defvar linum-format)

      (add-hook 'linum-before-numbering-hook
                (lambda ()
                  (setq-local linum-format-fmt
                              (let ((w (length (number-to-string
                                                (count-lines (point-min) (point-max))))))
                                (concat "%" (number-to-string w) "d")))))

      (defun linum-format-func (line)
        (concat
         (propertize (format linum-format-fmt line) 'face 'linum)
         (propertize " " 'face 'mode-line)))

      (setq linum-format 'linum-format-func)
      (linum-mode)
      )
    )

  (leaf hydra-main-menu
    :hydra
    (hydra-summary ()
                   ("m" hydra-magit/body "magit" :exit t)
                   ("b" hydra-bookmarks/body "bookmarks" :exit t)
                   ("z" hydra-zoom/body "zoom" :exit t)
                   )
    :bind*
    ("<f1>" . hydra-summary/body)
    )
  ) ;; emacs

;;
;; security
;;

;; [[file:~/.emacs.d/README-leaf.org::*security][security:1]]
;; gpg command https://www.linuxtricks.fr/wiki/chiffrer-des-fichiers-par-mot-de-passe-avec-gnupg
;; gpg in emacs https://www.masteringemacs.org/article/keeping-secrets-in-emacs-gnupg-auth-sources
;; emacs info: EasyPG Assistant
;; customize-group: epa, epg (EasyPG Assistant and EasyPG)
;; to encrypt a region : `epa-encrypt-region'

;; WIP: gpg-agent
;; pinentry downloaded in ~/tmp/pinentry-1.1.0 (doesn't build, missing fltk-config, installed with cygwin)
;; https://www.qwant.com/?client=brz-moz&q=emacs%20pinentry%20windows
;; https://github.com/ecraven/pinentry-emacs
;; https://emacs.stackexchange.com/questions/32881/enabling-minibuffer-pinentry-with-emacs-25-and-gnupg-2-1-on-ubuntu-xenial
;; https://stackoverflow.com/questions/60812866/emacs-gpg-pinentry-el-for-authentication
;; https://blog.grdryn.me/blog/flatpak-emacs-with-gpg-agent.html
;;
;; fltk: gui library
;; https://www.fltk.org/doc-1.3/common.html#common_boxtypes

(leaf security
  :config
  (leaf epg
    ;; on windows, use gnu4win. Cygwin gpg raise an error.
    :custom (epg-gpg-program . "gpg")
    :config
    (setenv "GPG_AGENT_INFO" nil) ; disable external pin entry (doesn't work with debian)
    )
  ) ;; security

(leaf magit
  :ensure t
  :init
  (leaf magit-popup :ensure t)
  :config
  (leaf git-link
    :ensure t
    )
  (leaf magit-gitflow
    ;;
    ;; TODO see magit-gitflow
    ;;
    :ensure t
    :config
    (add-hook 'magit-mode-hook 'turn-on-magit-gitflow)
    )
  :custom
  (magit-repository-directories .
                                '(("~/.emacs.d"  . 0)
                                  ("~/.emacs.d/lisp/comb"  . 0)
                                  ("~/workspace/" . 2)
                                  ))

  (magit-repolist-columns .
                          '(("Name" 25 magit-repolist-column-ident nil)
                            ("Version" 25 magit-repolist-column-version nil)
                            ("Branch" 15 magit-repolist-column-branch nil)
                            ("Branches" 8 magit-repolist-column-branches nil)
                            ("Flag" 4 magit-repolist-column-flag ((:right-align t)))
                            ("B<U" 3 magit-repolist-column-unpulled-from-upstream
                             ((:right-align t)
                              (:help-echo "Upstream changes not in branch")))
                            ("B>U" 3 magit-repolist-column-unpushed-to-upstream
                             ((:right-align t)
                              (:help-echo "Local changes not in upstream")))
                            ("Path" 30 magit-repolist-column-path nil)
                            ("Push" 4 magit-repolist-column-unpushed-to-pushremote))
                          )

  ;; TODO
  ;; ;; commit after save
  ;; (defun git-commit-after-save ()
  ;;   (let ((git-rev-parse-output "")
  ;;         (git-rev-parse-cmd "git rev-parse")
  ;;         (repository-p nil)
  ;;         (git-commit-cmd "git commit")
  ;;         (current-output ""))
  ;;     (setq current-output (call-process git-rev-parse-cmd))
  ;;     ))

  :hydra
  (hydra-magit
   (:color red :hint nil)
   "
        ^Magit commands^
--------------------------------
    _s_ status   _c_ commit
    _P_ pull    _la_ log all
    _p_ push     _d_ diff
    "
   ("p" magit-push :exit t :column "commits")
   ("P" magit-pull :exit t)
   ("s" magit-status :exit t)
   ("c" magit-commit :exit t :column "others")
   ("d" magit-diff :exit t)
   ("la" magit-log-all :exit t)
   ) ;; hydra-magit
  )

(leaf files
  :custom
  (backup-by-copying . t)
  (backup-directory-alist . '(("." . "~/.emacs.d/backup")))
  (enable-remote-dir-locals . t)
  :config
  (leaf f
    :doc "Modern API for working with files and directories:
  f-join, f-filename, f-direname..."
    :url http://github.com/rejeep/f.el
    :ensure t
    :require t)
  (leaf recentf
    :doc "deactivate recentf functionalities"
    :custom
    (recentf-auto-cleanup . 'never)
    (recentf-mode . nil)
    )
  (leaf autorevert
    :require t
    :custom
    (global-auto-revert-mode . t)
    (auto-revert-interval . 1))
  )

(leaf moving-in-emacs
  :config
  (leaf avy
    :ensure t
    :url https://github.com/abo-abo/avy
    :doc "like ace-jump"
    :custom
    (avy-timeout-seconds . 0.3)
    (avy-all-windows . 'all-frames)
    :bind
    (("C-M-:" . avy-goto-char-timer)
     ("C-:" . avy-goto-char-2))
    :config
    (leaf avy-menu
      :url https://github.com/mrkkrp/avy-menu
      :ensure t
      )
    )
  (leaf link-hint
    :ensure t
    :bind
    ("C-c l o" . link-hint-open-link)
    ("C-c l c" . link-hint-copy-link))
  ) ;; moving-in-emacs
;; completion

(leaf completion
  :config
  (leaf flx
    :doc "flx mode. Used with completion list.

  `flx-isearch' exists, but take a long time inside a long file."
    :ensure t
    )

  (leaf swiper
    :doc "Completion engine.  Install ivy, counsel, swiper."
    :url https://github.com/abo-abo/swiper
    :ensure t
    :config
    (leaf counsel
      :ensure t
      :bind
      (("M-y" . counsel-yank-pop)
       ("C-x r b" . counsel-bookmark)
       ("C-x b" . ivy-switch-buffer)
       ;; counsel-switch-buffer show a preview of buffer, it's too long
       ("M-x" . counsel-M-x)
       ("C-h f" . counsel-describe-function)
       ("C-h v" . counsel-describe-variable)
       ("C-x C-f" . counsel-find-file)
       ("C-x C-d" . counsel-find-file)
       ("C-x d" . counsel-find-file))
      (:ivy-minibuffer-map
       ("M-y" . ivy-next-line)))
    (leaf ivy
      "
    https://oremacs.com/swiper/#key-bindings
    https://www.reddit.com/r/emacs/comments/6xc0im/ivy_counsel_swiper_company_helm_smex_and_evil/
    https://www.youtube.com/user/abo5abo
    https://sam217pa.github.io/2016/09/13/from-helm-to-ivy/
    "
      :ensure t
      :bind
      (:ivy-minibuffer-map
       ("<RET>" . ivy-alt-done)
       ("C-j" . ivy-immediate-done)
       )
      :custom
      (ivy-re-builders-alist . '((counsel-ag     . ivy--regex-plus)
                                 (swiper-isearch . ivy--regex-ignore-order)
                                 (t              . ivy--regex-fuzzy)))
      (ivy-use-virtual-buffers . 'bookmarks)
      (ivy-height . 15)
      )
    (global-set-key (kbd "C-s") 'isearch-forward)
    (global-set-key (kbd "C-r") 'isearch-backward)
    ) ;; swiper
  ) ;; completion

(leaf org
  :tag "builtin"
  :mode
  ("\\.org\\'" . org-mode)
  ("\\.\\(org\\|txt\\)\\'" . org-mode)
  ("\\*notes\\*" . org-mode)
  :custom
  (
   (org-adapt-indentation . nil)                                         ; don't indent levels contents
   (org-default-notes-file . "~/workspace/org/capture.org")
   (org-edit-src-content-indentation . 0)
   (org-hide-leading-stars . nil)                                        ; show all levels stars
   (org-html-postamble . nil)
   (org-html-table-default-attributes . nil)                             ; no html table default attributes
   (org-id-link-to-org-use-id . 'create-if-interactive-and-no-custom-id) ; org-store-link create an id
   (org-indent-indentation-per-level . 0)                                ; sub levels indentation to 0
   (org-indent-mode . nil)                                               ; don't try to indent sub levels
   (org-level-color-stars-only . nil)                                    ; level titles are colored too
   (org-publish-timestamp-directory . "~/workspace/org/.org-timestamps/")
   (org-src-window-setup . 'current-window)
   (org-startup-shrink-all-tables . t)
   (org-tags-column . -153)                                              ; tags alignment
   ;; (org-headline-done ((t (:foreground "medium aquamarine"))))

   (org-time-stamp-custom-formats
    . '("<%A %d %B %Y>" . "<%A %d %B %Y, %H:%M>"))

   (org-file-apps . '(("\\.mm\\'" . default)
                      ("\\.x?html?\\'" . "firefox %s")
                      ("^http" . "firefox %s")
                      (auto-mode . emacs)
                      (directory . emacs)))

   (org-modules . '(org-bbdb
                    org-bibtex
                    org-docview
                    org-gnus
                    org-info
                    org-irc
                    org-mhe
                    org-rmail
                    org-w3m))

   ) ;; :custom

  :config
  ;; (add-to-list 'load-path (concat user-emacs-directory "straight/repos/org/contrib/lisp"))

  ;; (require 'org-velocity) ;; disables: org-ql is a lot more rich (but I don't understand it yet...)

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

  (leaf column-view
    :ensure nil ; not a package
    :doc "see https://orgmode.org/manual/Capturing-column-view.html:
        C-c C-x i (org-insert-columns-dblock)"
    )

  (leaf org-web-tools
    :ensure t)

  (leaf ob-async
    :ensure t org
    :url https://github.com/astahlman/ob-async
    )

  (leaf org-generate
    :ensure t org
    :url https://github.com/conao3/org-generate.el
    )

  ;; Fix an incompatibility between the ob-async and ob-ipython packages
  ;; TODO integrate in use-package
  (leaf TODO-integrate-to-leaf
    :config
    (progn
      (defvar ob-async-no-async-languages-alist)
      (setq ob-async-no-async-languages-alist '("ipython")))
    )

  (leaf org-mind-map
    :ensure t
    ;; mind map
    :init (require 'ox-org)
    :custom
    (org-mind-map-engine . "dot")
    (org-mind-map-default-graph-attribs
     . '(("autosize" . "false")
         ("size" . "9,12")
         ("resolution" . "100")
         ("nodesep" . "0.75")
         ("overlap" . "false")
         ("splines" . "ortho")
         ("rankdir" . "LR")))
    (org-mind-map-dot-output . '("png" "pdf" "jpeg" "svg" "eps" "gif" "tiff"))
    )

  (leaf org-brain
    :ensure t
    ;; mind map
    )

  (leaf poporg
    :ensure t
    ;; http://pragmaticemacs.com/emacs/write-code-comments-in-org-mode-with-poporg/
    ;; https://github.com/QBobWatson/poporg
    :bind (("C-c /" . poporg-dwim)))

  (leaf htmlize
    :ensure t
    ;; to export html file
    )

  (leaf org-capture
    :ensure nil ;; not a package
    :bind
    (("C-c c" . org-capture))

    :custom
    (
     (org-capture-templates
      .
      (quote
       (

        ("l" "Link" entry
         (file+headline "~/workspace/org/capture.org" "any/every-thing")
         (file "~/.emacs.d/org-capture-templates/capt-tmpl-link.org")
         )

        ("t" "Task" entry
         (file+headline "" "Tasks")
         "* TODO %?
           %u
           %a")

        ("c" "Clope" entry
         (file+headline "e:/Dropbox/org/pauses.org" "pauses")
         "** clope
           :PROPERTIES:
           :TIMES: %U%?
           :END:
           ")

        ("E" "Event With Clipboard" entry (file+headline "~/workspace/org/events.org" "Transient")
         "* EVENT %?\n%U\n   %c" :empty-lines 1)

        ("e" "note" entry (file+headline "~/workspace/org/capture.org" "any/every-thing")
         (file "~/.emacs.d/org-capture-templates/capt-tmpl-link.org")
         :empty-lines 1)

        ("b" "bookmark")

        ("bm" "manga" entry (file+headline "~/workspace/org/bookmarks/bookmarks-loisirs-mangas.org" "liste")
         (file "~/.emacs.d/org-capture-templates/capt-tmpl-bmk-mangas.org")
         :empty-lines 1)

        ("p" "passwords" entry (file "~/workspace/org/passwords.org.gpg")
         (file "~/.emacs.d/org-capture-templates/capt-tmpl-pwd.org"))

        )
       )

      ) ;; org-capture-templates
     ) ;; :custom
    ) ;; org-capture

  (leaf org-agenda
    :ensure nil ;; not a package
    :bind
    ("C-c a" . org-agenda)
    :config
    :custom
    (
     (org-agenda-files
      . (quote
         (
          "~/.emacs.d/README.org"
          "~/.emacs.d/lisp/yasnippet/org-snippet-new-link.org"
          "~/workspace/ada_test_architectures"
          "~/workspace/ada_utils/src/result/README.org"
          "~/workspace/birdz/notes"
          "~/workspace/org/agenda"
          "~/workspace/org/bookmarks"
          "~/workspace/org/capture.org"
          "~/workspace/org/emploi"
          "~/workspace/org/reference-cards"
          "~/workspace/org/reference-cards/tests"
          )))
     (org-log-done . t)
     ;; org-agenda-files (quote ("~/workspace/org/agenda"))
     (org-refile-targets . (quote ((org-agenda-files :maxlevel . 4))))

     ) ;; :custom
    ) ;; org-agenda
  ) ;; org

(leaf bookmark+
  :url https://www.emacswiki.org/emacs/BookmarkPlus
  :el-get emacsmirror/bookmark-plus
  :config
  (setq bmkp-bmenu-state-file (f-join user-emacs-directory "emacs-bookmarks/.bmk-bmenu-state.el")
        bookmark-default-file (f-join user-emacs-directory
                                      (cond (birdz-computer-p "emacs-bookmarks/birdz")
                                            (t                "emacs-bookmarks/emacs")))
        bmkp-last-as-first-bookmark-file nil)
  :require bookmark+
  :hydra
  (hydra-bookmarks ()
                   "bookmark+"
                   ("D"  (find-file org-bmk-dir)                                      "directory" :column "my bookmarks" :exit t)
                   ("bc" (find-file (concat org-bmk-dir "bookmarks-current.org.txt")) "current" :exit t)
                   ("bl" (find-file (concat org-bmk-dir "bookmarks-loisirs.org.txt")) "loisir" :exit t)

                   ("sv" bookmark-save "save" :column "bookmark-mode")
                   ("l" bookmark-load  "load")

                   ("a" bmkp-add-tags       "add" :column "tags")
                   ("c" bmkp-copy-tags      "copy")
                   ("p" bmkp-paste-add-tags "past")
                   )
  ) ;; bookmark+

(leaf yasnippet
  :doc links
  :url https://github.com/joaotavora/yasnippet
  :url http://joaotavora.github.io/yasnippet
  :url https://github.com/mrkkrp/common-lisp-snippets
  :doc TODO remove home / birdz directories, use condition inside snippets.
  :ensure t
  :config
  (yas-global-mode 1)
  (add-to-list 'load-path (concat lisp-dir "yasnippet"))
  :custom
  (yas-snippet-dirs . '("~/.emacs.d/snippets/home"
                        "~/.emacs.d/snippets/birdz"))
  :blackout 'yas-minor-mode
  )

(leaf ibuffer
  :url tips:      http://martinowen.net/blog/2010/02/03/tips-for-emacs-ibuffer.html
  :url example:   https://github.com/reinh/dotemacs/blob/master/conf/init.org
  :url emacswiki: https://www.emacswiki.org/emacs/IbufferMode
  :init
  ;; prevent "functions might not be defined at runtime" message when
  ;; byte-compiling
  (require 'ibuffer nil t) ;; TODO meaning of the arguments nil t
  (add-hook 'ibuffer-mode-hook
            (lambda ()
              (ibuffer-auto-mode)
              (ibuffer-switch-to-saved-filter-groups "default")))
  :bind
  (("C-x C-b" . ibuffer)
   (:ibuffer-mode-map
    ("<f1>" . hydra-ibuffer-main/body)
    ))
  :custom
  (
   (ibuffer-show-empty-filter-groups . nil)
   ;; *Help*
   ;; ibuffer-filtering-alist
   ;; ibuffer-filtering-qualifiers
   (ibuffer-saved-filter-groups
    . (quote (("default"
               ("bookmarks" (name . "bookmarks"))
               ("Magit" (name . "^magit"))
               ("birdz-dirs" (and (mode . dired-mode)(filename . "birdz")))
               ("ada_utils" (or (filename . "ada_utils")))
               ("ada_test_architectures" (or (filename . "ada_test_architectures")))
               ("birdz" (or (filename . "birdz") (name . "cnd-161")))
               ("ssh:dev" (filename . "ssh:dev"))
               ("Help" (or (name . "\*Help\*") (name . "\*Apropos\*") (name . "\*info\*")))
               ))))
   (ibuffer-directory-abbrev-alist
    . (quote (("~/Ingenico_Workspace/SUPTER-7682_mexique"
               . "SUPTER-7682_mexique")
              ("dllsch_t3_bbva_key_injection_pin_block_private"
               . "dllsch_t3_..._private"))))
   (ibuffer-default-sorting-mode . (quote filename-or-dired))
   (ibuffer-formats
    . (quote
       ((mark modified read-only locked " "
              (name 25 25 :left :elide)
              " "
              (size 7 -1 :right)
              " "
              (mode 8 8 :left :elide)
              " " filename-and-process)
        (mark " "
              (name 16 -1)
              " " filename))))
   ) ;; :custom
  :config
  (progn
    (define-ibuffer-sorter filename-or-dired
      "Sort the buffers by their pathname."
      (:description "filenames plus dired")
      (string-lessp
       (with-current-buffer (car a)
         (or buffer-file-name
             (if (derived-mode-p 'dired-mode)
                 (expand-file-name dired-directory))
             ;; so that all non pathnames are at the end
             "~"))
       (with-current-buffer (car b)
         (or buffer-file-name
             (if (derived-mode-p 'dired-mode)
                 (expand-file-name dired-directory))
             ;; so that all non pathnames are at the end
             "~"))))

    (define-key ibuffer-mode-map (kbd "s p")
      'ibuffer-do-sort-by-filename-or-dired)

    (define-ibuffer-column size-h
      (:name "Size" :inline t)
      (cond
       ((> (buffer-size) 1000000) (format "%7.1fM" (/ (buffer-size) 1000000.0)))
       ((> (buffer-size) 100000) (format "%7.0fk" (/ (buffer-size) 1000.0)))
       ((> (buffer-size) 1000) (format "%7.1fk" (/ (buffer-size) 1000.0)))
       (t (format "%8d" (buffer-size)))))
    ) ;; :config

  :hydra
  (
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
            (if (derived-mode-p 'ibuffer-mode)
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
   ) ;; :hydra
  ) ;; ibuffer

;; TODO frame title
;; sources:
;; - [[https://emacs.stackexchange.com/questions/16834/how-to-change-the-title-from-emacshost-to-file-name][emacs.stackexchange]]
;; - [[https://www.emacswiki.org/emacs/FrameTitle][emacswiki]]
;; #+BEGIN_COMMENT default value
;; (setq-default frame-title-format
;; '(:eval
;; (format "%s@%s: %s %s"
;; (or (file-remote-p default-directory 'user)
;; user-real-login-name)
;; (or (file-remote-p default-directory 'host)
;; system-name)
;; (buffer-name)
;; (cond
;; (buffer-file-truename
;; (concat "(" buffer-file-truename ")"))
;; (dired-directory
;; (concat "{" dired-directory "}"))
;; (t
;; "[no file]")))))
;; #+END_COMMENT

;; JP;; custom
;; JP;; #+NAME: default-frame-alist
;; JP
;; JP;; [[file:~/.emacs.d/README-leaf.org::default-frame-alist][default-frame-alist]]
;; JP;; default-frame-alist ends here
;; JP

;; JP;; jpi-full-screen
;; JP;; #+NAME: jpi-full-screen
;; JP
;; JP;; [[file:~/.emacs.d/README-leaf.org::jpi-full-screen][jpi-full-screen]]
;; JP;; frame & display:
;; JP;; https://stackoverflow.com/questions/16481984/get-width-of-current-monitor-in-emacs-lisp
;; JP;; https://www.gnu.org/software/emacs/manual/html_node/emacs/Frame-Commands.html
;; JP;; https://www.gnu.org/software/emacs/manual/html_node/elisp/Parameter-Access.html
;; JP(defun jpi-full-screen ()
;; JP  (interactive)
;; JP  (cond
;; JP   (ingenico-computer-p
;; JP    (set-frame-position (selected-frame) 0 0)
;; JP    (set-frame-width (selected-frame) 188)
;; JP    (set-frame-height (selected-frame) 52))
;; JP   ;; (set-frame-position (selected-frame) -5 0)
;; JP   ;; (set-frame-width (selected-frame) 380)
;; JP   ;; (set-frame-height (selected-frame) 53))
;; JP   (home-computer-p
;; JP    (set-frame-position (selected-frame) 0 0)
;; JP    (set-frame-width (selected-frame) 188)
;; JP    (set-frame-height (selected-frame) 53)))
;; JP  ;; (cond
;; JP  ;;  ((string= (system-name) ingenico-system-name)
;; JP  ;;   (set-frame-position (selected-frame) 0 0)
;; JP  ;;   (set-frame-width (selected-frame) 188)
;; JP  ;;   (set-frame-height (selected-frame) 52))
;; JP  ;;  ;; (set-frame-position (selected-frame) -5 0)
;; JP  ;;  ;; (set-frame-width (selected-frame) 380)
;; JP  ;;  ;; (set-frame-height (selected-frame) 53))
;; JP  ;;  ((string= (system-name) home-system-name)
;; JP  ;;   (set-frame-position (selected-frame) 0 0)
;; JP  ;;   (set-frame-width (selected-frame) 188)
;; JP  ;;   (set-frame-height (selected-frame) 53)))
;; JP  )
;; JP;; jpi-full-screen ends here
;; JP
