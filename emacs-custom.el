(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ada-always-ask-project t)
 '(ada-build-confirm-command nil)
 '(ada-build-make-cmd "cd ../ && make")
 '(ada-build-run-cmd "cd ../bin && ${main}.exe")
 '(ada-case-exception-file (quote ("~/.emacs.d/ada_case_exceptions")))
 '(ada-indent 3)
 '(ada-indent-record-rel-type 0)
 '(ada-indent-when 2)
 '(ada-prj-file-ext-extra (quote ("gpr")))
 '(ada-prj-file-extensions (quote ("gpr" "adp" "prj")))
 '(ada-skel-initial-string "")
 '(ada-xref-full-path t)
 '(amx-ignored-command-matchers nil)
 '(amx-show-key-bindings nil)
 '(backup-by-copying t)
 '(backup-directory-alist (quote (("." . "~/.emacs.d/backup"))))
 '(bmkp-last-as-first-bookmark-file "d:/Users/jpiffret/AppData/Roaming/.emacs.d/bookmarks")
 '(c-default-style
   (quote
    ((c-mode . "ingenico")
     (c++-mode . "ingenico")
     (java-mode . "java")
     (awk-mode . "awk")
     (other . "gnu"))))
 '(c-hanging-semi&comma-criteria nil)
 '(calendar-week-start-day 1)
 '(column-number-mode t)
 '(confirm-kill-emacs (quote y-or-n-p))
 '(diredp-hide-details-initially-flag nil)
 '(diredp-ignore-compressed-flag nil)
 '(diredp-visit-ignore-extensions nil)
 '(display-line-numbers-mode t t)
 '(display-time-24hr-format t)
 '(display-time-day-and-date t)
 '(display-time-mode t)
 '(fill-column 80)
 '(global-auto-revert-mode t)
 '(global-linum-mode t)
 '(gpr-indent 2)
 '(gpr-indent-when 2)
 '(gpr-skel-initial-string "")
 '(grep-find-command
   (quote
    ("gfind . -type f -name \"*[.][hc]\" -exec grep --color=always -nH  {} \";\"" . 64)))
 '(hippie-expand-try-functions-list
   (quote
    (try-expand-dabbrev try-expand-dabbrev-all-buffers try-complete-file-name-partially try-complete-file-name try-expand-all-abbrevs try-expand-list try-expand-dabbrev-from-kill try-expand-line try-complete-lisp-symbol-partially try-complete-lisp-symbol)))
 '(ido-decorations
   (quote
    ("
-> " "" "
   " "
   ..." "[" "]" " [No match]" " [Matched]" " [Not readable]" " [Too big]" " [Confirm]")))
 '(indent-tabs-mode nil)
 '(linum-format "%6d")
 '(ls-lisp-verbosity nil)
 '(org-adapt-indentation nil)
 '(org-agenda-files
   (quote
    ("~/Dropbox/org/notes.org" "~/Dropbox/org/sncf.org" "~/Dropbox/org/dates.org" "~/Dropbox/org/administratif.org" "~/Dropbox/org/pauses.org")))
 '(org-capture-templates
   (quote
    (("l" "Link" entry
      (file+headline "~/Dropbox/org/new_links.org" "links")
      "** link
:PROPERTIES:
:TITLE: %?
:LINK:
:END:
")
     ("t" "Task" entry
      (file+headline "" "Tasks")
      "* TODO %?
  %u
  %a")
     ("c" "Clope" entry
      (file+headline "~/Dropbox/org/pauses.org" "pauses")
      "** clope
:PROPERTIES:
:TIMES: %U%?
:END:
"))))
 '(org-default-notes-file "~/Dropbox/org/notes.org")
 '(org-html-table-default-attributes nil)
 '(org-indent-indentation-per-level 0)
 '(org-mind-map-default-graph-attribs
   (quote
    (("autosize" . "false")
     ("size" . "9,12")
     ("resolution" . "100")
     ("nodesep" . "0.75")
     ("overlap" . "false")
     ("splines" . "ortho")
     ("rankdir" . "LR"))))
 '(org-mind-map-dot-output (quote ("png" "pdf" "jpeg" "svg" "eps" "gif" "tiff")))
 '(org-modules
   (quote
    (org-bbdb org-bibtex org-docview org-gnus org-info org-irc org-mhe org-rmail org-w3m org-collector)))
 '(org-publish-timestamp-directory "~/workspace/org/.org-timestamps/")
 '(org-refile-targets (quote ((org-agenda-files :maxlevel . 4))))
 '(org-startup-shrink-all-tables t)
 '(org-time-stamp-custom-formats (quote ("<%A %d %B %Y>" . "<%A %d %B %Y, %H:%M>")))
 '(package-archives
   (quote
    (("jpi" . "~/.emacs.d/package-repo-jpi/")
     ("gnu" . "https://elpa.gnu.org/packages/")
     ("melpa" . "http://melpa.org/packages/"))))
 '(package-selected-packages
   (quote
    (org-mind-map org-brain dired-filter amx ido-completing-read+ crm-custom immaterial flycheck elpy immaterial-theme wisi ada-mode magit org flx-isearch flx-ido)))
 '(python-fill-docstring-style (quote symmetric))
 '(python-indent-guess-indent-offset nil)
 '(show-paren-mode t))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:family "Courier New" :foundry "outline" :slant normal :weight normal :height 120 :width normal))))
 '(diredp-compressed-file-name ((t (:foreground "ivory"))))
 '(diredp-compressed-file-suffix ((t (:foreground "#00006DE06DE0"))))
 '(diredp-date-time ((t (:foreground "gray"))))
 '(diredp-dir-heading ((t (:foreground "sky blue"))))
 '(diredp-dir-name ((t (:foreground "deep sky blue"))))
 '(diredp-dir-priv ((t nil)))
 '(diredp-exec-priv ((t nil)))
 '(diredp-file-name ((t (:foreground "white smoke"))))
 '(diredp-ignored-file-name ((t (:foreground "red"))))
 '(diredp-link-priv ((t nil)))
 '(diredp-no-priv ((t nil)))
 '(diredp-number ((t (:foreground "pale turquoise"))))
 '(diredp-omit-file-name ((t (:inherit diredp-ignored-file-name))))
 '(diredp-read-priv ((t nil)))
 '(diredp-write-priv ((t nil)))
 '(font-lock-comment-delimiter-face ((t (:foreground "chocolate"))))
 '(font-lock-comment-face ((t (:foreground "chocolate"))))
 '(font-lock-constant-face ((t (:foreground "chartreuse"))))
 '(font-lock-doc-face ((t (:foreground "chocolate"))))
 '(highlight-indentation-current-column-face ((t (:background "gray15"))))
 '(highlight-indentation-face ((t (:inherit fringe :background "gray15"))))
 '(hl-line ((t (:background "gray30"))))
 '(internal-border ((t (:background "white"))))
 '(isearch ((t (:background "gray20" :foreground "#eeeeee" :underline t :weight ultra-bold))))
 '(linum ((t (:background "#102027" :foreground "#777777" :weight normal :height 100))))
 '(magit-branch-local ((t (:foreground "orange"))))
 '(mode-line ((t (:background "midnight blue" :foreground "#eeeeee" :box (:line-width 1 :color "#102027")))))
 '(mode-line-inactive ((t (:background "gray22" :foreground "#eeeeee" :box (:line-width 1 :color "#102027")))))
 '(package-name ((t (:foreground "light goldenrod"))))
 '(region ((t (:background "dim gray" :foreground "#eeeeee"))))
 '(replacep-msg-emphasis ((t (:foreground "brown")))))
