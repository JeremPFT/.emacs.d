(use-package org
  :mode
  ("\\.\\(org\\|txt\\)\\'" . org-mode)
  ("\\*notes\\*" . org-mode)
  :bind (("C-c a" . org-agenda)
         ("C-c c" . org-capture))
  :config
  (setq org-indent-mode 0
        org-adapt-indentation nil
        org-agenda-files (quote ("~/workspace/org/agenda"))
        org-default-notes-file "~/Dropbox/org/notes.org"
        org-file-apps
        (quote
         ((auto-mode . emacs)
          ("\\.mm\\'" . default)
          ("\\.x?html?\\'" . default)
          ("\\.pdf\\'" . default)
          (directory . emacs)))
        org-fontify-done-headline t
        org-hide-leading-stars nil
        org-html-table-default-attributes nil
        org-indent-indentation-per-level 0
        org-level-color-stars-only nil
        org-modules
        (quote
         (org-bbdb org-bibtex org-docview org-gnus org-info org-irc org-mhe org-rmail org-w3m))
        org-publish-timestamp-directory "~/workspace/org/.org-timestamps/"
        org-refile-targets (quote ((org-agenda-files :maxlevel . 4)))
        org-src-window-setup (quote current-window)
        org-startup-shrink-all-tables t
        org-time-stamp-custom-formats (quote ("<%A %d %B %Y>" . "<%A %d %B %Y, %H:%M>"))
        ;; org-headline-done ((t (:foreground "medium aquamarine")))
        org-capture-templates
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
")))
        )
  )

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

;; setting up org-babel for literate programming
(org-babel-do-load-languages
 'org-babel-load-languages
 '(
   (python . t)
   ;;   (sh . t)
   (C . t)
   ;; Include other languages here...
   ))

(progn
  (defvar org-html-postamble)
  (setq org-html-postamble nil))

(use-package org-web-tools)

(use-package ob-async
  ;; https://github.com/astahlman/ob-async
  :after org
  )

(use-package org-generate
  :after org
  :straight (:host github :repo "conao3/org-generate.el"))

;; Fix an incompatibility between the ob-async and ob-ipython packages
;; TODO integrate in use-package
(progn
  (defvar ob-async-no-async-languages-alist)
  (setq ob-async-no-async-languages-alist '("ipython")))

(use-package org-mind-map
  ;; mind map
  :init (require 'ox-org)
  :config
  (setq org-mind-map-engine "dot"
        org-mind-map-default-graph-attribs
        (quote
         (("autosize" . "false")
          ("size" . "9,12")
          ("resolution" . "100")
          ("nodesep" . "0.75")
          ("overlap" . "false")
          ("splines" . "ortho")
          ("rankdir" . "LR")))
        org-mind-map-dot-output (quote ("png" "pdf" "jpeg" "svg" "eps" "gif" "tiff"))
        )
  )

(use-package org-brain
  ;; mind map
  )

(use-package poporg
  ;; http://pragmaticemacs.com/emacs/write-code-comments-in-org-mode-with-poporg/
  ;; https://github.com/QBobWatson/poporg
  :bind (("C-c /" . poporg-dwim)))

