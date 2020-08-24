(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(LaTeX-command-style
   (quote
    (("" "%(PDF)%(latex) %(file-line-error) %(extraopts) %S%(PDFout)"))))
 '(TeX-command-list
   (quote
    (("Make" "make" TeX-run-TeX nil t :help "Make pdf output using Makefile.")
     ("TeX" "%(PDF)%(tex) %(file-line-error) %`%(extraopts) %S%(PDFout)%(mode)%' %t" TeX-run-TeX nil
      (plain-tex-mode texinfo-mode ams-tex-mode)
      :help "Run plain TeX")
     ("LaTeX" "%`%l%(mode)%' %T " TeX-run-TeX nil
      (latex-mode doctex-mode)
      :help "Run LaTeX")
     ("Makeinfo" "makeinfo %(extraopts) %t" TeX-run-compile nil
      (texinfo-mode)
      :help "Run Makeinfo with Info output")
     ("Makeinfo HTML" "makeinfo %(extraopts) --html %t" TeX-run-compile nil
      (texinfo-mode)
      :help "Run Makeinfo with HTML output")
     ("AmSTeX" "amstex %(PDFout) %`%(extraopts) %S%(mode)%' %t" TeX-run-TeX nil
      (ams-tex-mode)
      :help "Run AMSTeX")
     ("ConTeXt" "%(cntxcom) --once --texutil %(extraopts) %(execopts)%t" TeX-run-TeX nil
      (context-mode)
      :help "Run ConTeXt once")
     ("ConTeXt Full" "%(cntxcom) %(extraopts) %(execopts)%t" TeX-run-TeX nil
      (context-mode)
      :help "Run ConTeXt until completion")
     ("BibTeX" "%(bibtex) %s" TeX-run-BibTeX nil
      (plain-tex-mode latex-mode doctex-mode context-mode texinfo-mode ams-tex-mode)
      :help "Run BibTeX")
     ("Biber" "biber %s" TeX-run-Biber nil
      (plain-tex-mode latex-mode doctex-mode texinfo-mode ams-tex-mode)
      :help "Run Biber")
     ("View" "%V" TeX-run-discard-or-function t t :help "Run Viewer")
     ("Print" "%p" TeX-run-command t t :help "Print the file")
     ("Queue" "%q" TeX-run-background nil t :help "View the printer queue" :visible TeX-queue-command)
     ("File" "%(o?)dvips %d -o %f " TeX-run-dvips t
      (plain-tex-mode latex-mode doctex-mode texinfo-mode ams-tex-mode)
      :help "Generate PostScript file")
     ("Dvips" "%(o?)dvips %d -o %f " TeX-run-dvips nil
      (plain-tex-mode latex-mode doctex-mode texinfo-mode ams-tex-mode)
      :help "Convert DVI file to PostScript")
     ("Dvipdfmx" "dvipdfmx %d" TeX-run-dvipdfmx nil
      (plain-tex-mode latex-mode doctex-mode texinfo-mode ams-tex-mode)
      :help "Convert DVI file to PDF with dvipdfmx")
     ("Ps2pdf" "ps2pdf %f" TeX-run-ps2pdf nil
      (plain-tex-mode latex-mode doctex-mode texinfo-mode ams-tex-mode)
      :help "Convert PostScript file to PDF")
     ("Glossaries" "makeglossaries %s" TeX-run-command nil
      (plain-tex-mode latex-mode doctex-mode texinfo-mode ams-tex-mode)
      :help "Run makeglossaries to create glossary
     file")
     ("Index" "%(makeindex) %s" TeX-run-index nil
      (plain-tex-mode latex-mode doctex-mode texinfo-mode ams-tex-mode)
      :help "Run makeindex to create index file")
     ("upMendex" "upmendex %s" TeX-run-index t
      (plain-tex-mode latex-mode doctex-mode texinfo-mode ams-tex-mode)
      :help "Run upmendex to create index file")
     ("Xindy" "texindy %s" TeX-run-command nil
      (plain-tex-mode latex-mode doctex-mode texinfo-mode ams-tex-mode)
      :help "Run xindy to create index file")
     ("Check" "lacheck %s" TeX-run-compile nil
      (latex-mode)
      :help "Check LaTeX file for correctness")
     ("ChkTeX" "chktex -v6 %s" TeX-run-compile nil
      (latex-mode)
      :help "Check LaTeX file for common mistakes")
     ("Spell" "(TeX-ispell-document \"\")" TeX-run-function nil t :help "Spell-check the document")
     ("Clean" "TeX-clean" TeX-run-function nil t :help "Delete generated intermediate files")
     ("Clean All" "(TeX-clean t)" TeX-run-function nil t :help "Delete generated intermediate and output files")
     ("Other" "" TeX-run-command t t :help "Run an arbitrary command"))))
 '(TeX-show-compilation t)
 '(ace-isearch-function (quote avy-goto-char))
 '(ada-always-ask-project t)
 '(ada-build-confirm-command nil)
 '(ada-build-prompt-prj (quote prompt))
 '(ada-case-exception-file (quote ("~/.emacs.d/ada_case_exceptions")))
 '(ada-indent 3)
 '(ada-indent-label 0)
 '(ada-indent-record-rel-type 0)
 '(ada-indent-when 0)
 '(ada-prj-file-ext-extra (quote ("gpr")))
 '(ada-prj-file-extensions (quote ("gpr" "adp" "prj")))
 '(ada-skel-initial-string "")
 '(ada-xref-full-path t)
 '(amx-ignored-command-matchers nil)
 '(amx-show-key-bindings nil)
 '(backup-by-copying t)
 '(backup-directory-alist (quote (("." . "~/.emacs.d/backup"))))
 '(bmkp-last-as-first-bookmark-file nil)
 '(browse-kill-ring-show-preview t)
 '(c-default-style
   (quote
    ((c-mode . "ingenico")
     (c++-mode . "ingenico")
     (java-mode . "java")
     (awk-mode . "awk")
     (other . "gnu"))))
 '(c-hanging-semi&comma-criteria nil)
 '(calendar-intermonth-header "Wk")
 '(calendar-intermonth-text
   (quote
    (propertize
     (format "%2d"
             (car
              (calendar-iso-from-absolute
               (calendar-absolute-from-gregorian
                (list month day year)))))
     (quote font-lock-face)
     (quote calendar-iso-week-face))))
 '(calendar-mark-holidays-flag t)
 '(calendar-week-start-day 1)
 '(column-number-mode t)
 '(compilation-search-path
   (quote
    ("~/workspace/ada_test_architectures/" "~/workspace/ada_test_architectures/src/services/" "~/workspace/ada_test_architectures/src/objects/" "~/workspace/ada_test_architectures/src/infrastructure/" "~/workspace/ada_test_architectures/src/test/")))
 '(confirm-kill-emacs (quote y-or-n-p))
 '(diredp-hide-details-initially-flag nil)
 '(diredp-ignore-compressed-flag nil)
 '(diredp-visit-ignore-extensions nil)
 '(display-line-numbers-mode t t)
 '(display-time-24hr-format t)
 '(display-time-day-and-date t)
 '(display-time-mode t)
 '(doom-modeline-buffer-file-name-style (quote relative-from-project))
 '(fill-column 80)
 '(global-auto-revert-mode t)
 '(global-linum-mode t)
 '(gpr-indent 3)
 '(gpr-indent-when 0)
 '(gpr-skel-initial-string "")
 '(grep-command "grep --color=always --before-context=5 -nH --null -e ")
 '(grep-find-command
   (quote
    ("gfind . -type f -name \"*[.]*\" -exec grep --color=always -nHi  {} \";\"" . 62)))
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
 '(inhibit-startup-screen t)
 '(initial-buffer-choice (quote jp/initial-buffer))
 '(ivy-wrap t)
 '(js-indent-level 2)
 '(linum-format "%6d")
 '(ls-lisp-use-insert-directory-program t)
 '(ls-lisp-verbosity nil)
 '(package-archives
   (quote
    (("jpi" . "~/.emacs.d/package-repo-jpi/")
     ("gnu" . "https://elpa.gnu.org/packages/")
     ("melpa" . "http://melpa.org/packages/"))))
 '(package-selected-packages (quote (ada-mode wisi)))
 '(plantuml-default-exec-mode (quote jar))
 '(projectile-completion-system (quote ivy))
 '(python-fill-docstring-style (quote symmetric))
 '(python-indent-guess-indent-offset nil)
 '(remember-data-file "~/.emacs.d/notes.org")
 '(safe-local-variable-values
   (quote
    ((eval load "~/workspace/ada_test_architectures/src/.emacs_prj_settings/ata-application-object-tests")
     (eval load "~/workspace/ada_test_architectures/src/.emacs_prj_settings/ata-data_access-tests")
     (eval load "~/workspace/ada_test_architectures/src/.emacs_prj_settings/ata-data_access")
     (eval load "~/workspace/ada_test_architectures/src/.emacs_prj_settings/ata_testing_data")
     (eval load "~/workspace/ada_test_architectures/src/.emacs_prj_settings/ata_model_object_tests")
     (eval load "~/workspace/ada_test_architectures/src/.emacs_prj_settings/ata_data_access_tests")
     (eval load "~/workspace/ada_test_architectures/src/.emacs_prj_settings/ata_repository")
     (eval load "~/workspace/ada_test_architectures/src/.emacs_prj_settings/ata")
     (eval load "~/workspace/ada_test_architectures/src/.emacs_prj_settings/ata_application")
     (eval load "~/workspace/ada_test_architectures/src/.emacs_prj_settings/ata_application_object")
     (eval load "~/workspace/ada_test_architectures/src/.emacs_prj_settings/ata_application_object_tests")
     (eval load "~/workspace/ada_test_architectures/src/.emacs_prj_settings/ata_application_service")
     (eval load "~/workspace/ada_test_architectures/src/.emacs_prj_settings/ata_data_access")
     (eval load "~/workspace/ada_test_architectures/src/.emacs_prj_settings/ata_model")
     (eval load "~/workspace/ada_test_architectures/src/.emacs_prj_settings/ata_model_object")
     (eval load "~/workspace/ada_test_architectures/src/.emacs_prj_settings/ata_model_service")
     (eval load "~/workspace/ada_test_architectures/src/.emacs_prj_settings/ata_repositories")
     (eval load "~/workspace/ada_test_architectures/src/.emacs_prj_settings/run")
     (eval load "~/workspace/ada_test_architectures/src/.emacs_prj_settings/testing")
     (eval load "~/workspace/ada_test_architectures/src/.emacs_prj_settings/utils")
     (eval load "~/workspace/ada_test_architectures/src/.emacs_prj_settings/utils_tests"))))
 '(show-paren-mode t)
 '(speed-type-default-lang (quote French))
 '(tex-start-commands "--output-dir=tmp \"\\nonstopmode\\input\"")
 '(treemacs-width 40))
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
 '(diredp-ignored-file-name ((t (:foreground "white"))))
 '(diredp-link-priv ((t nil)))
 '(diredp-no-priv ((t nil)))
 '(diredp-number ((t (:foreground "pale turquoise"))))
 '(diredp-omit-file-name ((t (:inherit diredp-ignored-file-name))))
 '(diredp-read-priv ((t nil)))
 '(diredp-write-priv ((t nil)))
 '(ediff-current-diff-A ((t (:background "dark slate blue"))))
 '(ediff-current-diff-B ((t (:background "dark slate blue"))))
 '(ediff-even-diff-A ((t (:background "royal blue"))))
 '(ediff-even-diff-Ancestor ((t (:background "dodger blue"))))
 '(ediff-even-diff-B ((t (:background "royal blue"))))
 '(ediff-even-diff-C ((t (:background "brown"))))
 '(ediff-fine-diff-A ((t (:background "navy"))))
 '(ediff-fine-diff-B ((t (:background "navy"))))
 '(ediff-odd-diff-A ((t (:background "dark olive green"))))
 '(ediff-odd-diff-B ((t (:background "dark olive green"))))
 '(fic-author-face ((t (:background "steel blue" :foreground "orangered" :underline t))))
 '(fic-face ((t (:foreground "coral" :slant oblique :weight bold))))
 '(font-lock-comment-delimiter-face ((t (:foreground "chocolate"))))
 '(font-lock-comment-face ((t (:foreground "chocolate"))))
 '(font-lock-constant-face ((t (:foreground "chartreuse"))))
 '(font-lock-doc-face ((t (:foreground "chocolate"))))
 '(highlight-indentation-current-column-face ((t (:background "gray15"))))
 '(highlight-indentation-face ((t (:inherit fringe :background "gray15"))))
 '(hl-line ((t (:background "gray30"))))
 '(internal-border ((t (:background "white"))))
 '(isearch ((t (:background "gray20" :foreground "#eeeeee" :underline t :weight ultra-bold))))
 '(link ((((class color) (min-colors 89)) (:foreground "#4f9a94" :underline t))))
 '(linum ((t (:background "#102027" :foreground "#777777" :weight normal :height 100))))
 '(magit-branch-local ((t (:foreground "orange"))))
 '(magit-hash ((t (:foreground "sky blue"))))
 '(mode-line ((t (:background "midnight blue" :foreground "#eeeeee" :box (:line-width 1 :color "#102027")))))
 '(mode-line-inactive ((t (:background "gray22" :foreground "#eeeeee" :box (:line-width 1 :color "#102027")))))
 '(package-name ((t (:foreground "light goldenrod"))))
 '(region ((t (:background "dim gray" :foreground "#eeeeee"))))
 '(replacep-msg-emphasis ((t (:foreground "brown"))))
 '(show-paren-match ((t (:background "gray" :weight bold))))
 '(ztreep-diff-model-add-face ((t (:foreground "chocolate")))))
