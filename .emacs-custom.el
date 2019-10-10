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
 '(backup-by-copying t)
 '(backup-directory-alist (quote (("." . "~/.emacs.d/backup"))))
 '(bmkp-last-as-first-bookmark-file #("~/.emacs.d/bookmarks" 2 11 (face flx-highlight-face)))
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
 '(ido-decorations
   (quote
    ("
-> " "" "
   " "
   ..." "[" "]" " [No match]" " [Matched]" " [Not readable]" " [Too big]" " [Confirm]")))
 '(indent-tabs-mode nil)
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
 '(org-modules
   (quote
    (org-bbdb org-bibtex org-docview org-gnus org-info org-irc org-mhe org-rmail org-w3m org-collector)))
 '(org-refile-targets (quote ((org-agenda-files :maxlevel . 4))))
 '(org-time-stamp-custom-formats (quote ("<%A %d %B %Y>" . "<%A %d %B %Y, %H:%M>")))
 '(package-archives
   (quote
    (("jpi" . "~/.emacs.d/package-repo-jpi/")
     ("gnu" . "https://elpa.gnu.org/packages/")
     ("melpa" . "http://melpa.org/packages/"))))
 '(package-selected-packages
   (quote
    (paradox wisi ada-mode magit org flx-isearch flx-ido)))
 '(show-paren-mode t))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(diredp-compressed-file-suffix ((t (:foreground "#00006DE06DE0"))))
 '(diredp-dir-name ((t (:foreground "Blue"))))
 '(diredp-dir-priv ((t nil)))
 '(diredp-exec-priv ((t nil)))
 '(diredp-file-name ((t (:foreground "black"))))
 '(diredp-link-priv ((t nil)))
 '(diredp-no-priv ((t nil)))
 '(diredp-omit-file-name ((t (:inherit diredp-ignored-file-name))))
 '(diredp-read-priv ((t nil)))
 '(diredp-write-priv ((t nil)))
 '(magit-branch-local ((t (:foreground "orange")))))
