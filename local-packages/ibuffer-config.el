(use-package ibuffer
  ;; https://github.com/reinh/dotemacs/blob/master/conf/init.org#ido
  ;; https://www.emacswiki.org/emacs/IbufferMode

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
