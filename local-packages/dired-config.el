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
