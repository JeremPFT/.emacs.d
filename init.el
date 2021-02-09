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

(leaf emacs>27
  :doc "see `early-init-file'")

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
  :url "https://github.com/conao3/leaf.el"
  :init
  (leaf leaf-keywords
    :url "https://github.com/conao3/leaf-keywords.el"
    :init
    (leaf hydra
      :url "https://github.com/abo-abo/hydra"
      :ensure t)
    (leaf el-get
      :ensure t)
    (leaf blackout
      :ensure t
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
    :blackout
    feather-mode
    ) ;; feather

  (leaf leaf-tree
    :ensure t
    :bind
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
      (file-name-as-directory (expand-file-name "workspace-dir" home-dir)))

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
                         (home-computer-p 200)
                         (birdz-debian-computer-p 140)
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
             (fill-column . 79)
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
    (leaf zenburn-theme
      :ensure t
      :config
      (load-theme 'zenburn t))
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
    :url "http://github.com/rejeep/f.el"
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
    :url "https://github.com/abo-abo/avy"
    :doc "like ace-jump"
    :custom
    (avy-timeout-seconds . 0.3)
    (avy-all-windows . 'all-frames)
    :bind
    (("C-M-:" . avy-goto-char-timer)
     ("C-:" . avy-goto-char-2))
    :config
    (leaf avy-menu
      :url "https://github.com/mrkkrp/avy-menu"
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
    :url "https://github.com/abo-abo/swiper"
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
  :bind
  ("C-c a" . org-agenda)
  :custom
  ((org-adapt-indentation . nil)                                         ; don't indent levels contents
   (org-default-notes-file . "~/workspace/org/capture.org")
   (org-edit-src-content-indentation . 0)
   (org-hide-leading-stars . nil)                                        ; show all levels stars
   (org-html-table-default-attributes . nil)                             ; no html table default attributes
   (org-id-link-to-org-use-id . 'create-if-interactive-and-no-custom-id) ; org-store-link create an id
   (org-indent-indentation-per-level . 0)                                ; sub levels indentation to 0
   (org-indent-mode . nil)                                               ; don't try to indent sub levels
   (org-level-color-stars-only . nil)                                    ; level titles are colored too
   (org-tags-column . -153)                                              ; tags alignment
   (org-publish-timestamp-directory . "~/workspace/org/.org-timestamps/")
   (org-src-window-setup . 'current-window)
   (org-startup-shrink-all-tables . t)
   (org-time-stamp-custom-formats . '("<%A %d %B %Y>" . "<%A %d %B %Y, %H:%M>"))
   (org-html-postamble . nil)

   (org-file-apps . '(("\\.mm\\'" . default)
                      ("\\.x?html?\\'" . "firefox %s")
                      ("^http" . "firefox %s")
                      (auto-mode . emacs)
                      (directory . emacs))))

  (org-modules . '(org-bbdb
                   org-bibtex
                   org-docview
                   org-gnus
                   org-info
                   org-irc
                   org-mhe
                   org-rmail
                   org-w3m))

  ;; (org-headline-done ((t (:foreground "medium aquamarine"))))
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
    :url "https://github.com/astahlman/ob-async"
    )

  (leaf org-generate
    :ensure t org
    :url "https://github.com/conao3/org-generate.el"
    )

  ;; Fix an incompatibility between the ob-async and ob-ipython packages
  ;; TODO integrate in use-package
  (leaf TODO-integrate-to-leaf)
  (progn
    (defvar ob-async-no-async-languages-alist)
    (setq ob-async-no-async-languages-alist '("ipython")))

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
  ) ;; org

(leaf bookmark+
  ;; https://www.emacswiki.org/emacs/BookmarkPlus
  :el-get emacsmirror/bookmark-plus
  :config
  (setq bmkp-bmenu-state-file (f-join user-emacs-directory "emacs-bookmarks/.bmk-bmenu-state.el")
        bookmark-default-file (f-join user-emacs-directory
                                      (cond (birdz-computer-p "emacs-bookmarks/birdz")
                                            (t                "emacs-bookmarks/emacs")))
        bmkp-last-as-first-bookmark-file nil)
  :hydra
  (hydra-bookmarks ()
                   "bookmarks+"
                   ("D"  (find-file org-bmk-dir)                                      "directory" :column "my bookmarks" :exit t)
                   ("bc" (find-file (concat org-bmk-dir "bookmarks-current.org.txt")) "current" :exit t)
                   ("bl" (find-file (concat org-bmk-dir "bookmarks-loisirs.org.txt")) "loisir" :exit t)

                   ("sv" bookmark-save "save" :column "bookmark-mode")
                   ("l" bookmark-load  "load")

                   ("a" bmkp-add-tags       "add" :column "tags")
                   ("c" bmkp-copy-tags      "copy")
                   ("p" bmkp-paste-add-tags "past")
                   )
  ) ;; bookmarks+



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
;; JP(add-to-list 'default-frame-alist '(fullscreen . maximized))
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
