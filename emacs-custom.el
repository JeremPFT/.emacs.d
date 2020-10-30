(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(TeX-command-list
   '(("TeX" "%(PDF)%(tex) %(file-line-error) %`%(extraopts) %S%(PDFout)%(mode)%' %t" TeX-run-TeX nil
      (plain-tex-mode texinfo-mode ams-tex-mode)
      :help "Run plain TeX")
     ("LaTeX" "%`%l%(mode)%' %T" TeX-run-TeX nil
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
     ("ConTeXt" "%(cntxcom) %(extraopts) %(execopts)%t" TeX-run-TeX nil
      (context-mode)
      :help "Run ConTeXt (ConTeXt Full alias)")
     ("ConTeXt Full" "%(cntxcom) %(extraopts) %(execopts)%t" TeX-run-TeX nil
      (context-mode)
      :help "Run ConTeXt until completion")
     ("BibTeX" "bibtex %s" TeX-run-BibTeX nil
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
     ("Index" "makeindex %s" TeX-run-index nil
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
     ("Other" "" TeX-run-command t t :help "Run an arbitrary command")))
 '(ansi-color-faces-vector
   [default default default italic underline success warning error])
 '(ansi-color-names-vector
   ["#242424" "#e5786d" "#95e454" "#cae682" "#8ac6f2" "#333366" "#ccaa8f" "#f6f3e8"])
 '(backup-by-copying t)
 '(backup-directory-alist '(("." . "~/.emacs.d/backup")))
 '(before-save-hook '(delete-trailing-whitespace))
 '(bmkp-bmenu-state-file "~/.emacs.d/emacs-bookmarks/.bmk-bmenu-state.el")
 '(bmkp-last-as-first-bookmark-file
   "~/.emacs.d/emacs-bookmarks/birdz")
 '(bookmark-default-file "~/.emacs.d/emacs-bookmarks/bmk.emacs")
 '(column-number-mode t)
 '(custom-enabled-themes '(tsdh-dark))
 '(enable-remote-dir-locals t)
 '(grep-find-command
   '("find . -type f -exec grep --color=always -n -e  \"{}\" NUL \";\"" . 48))
 '(indent-tabs-mode nil)
 '(org-agenda-files
   '("~/.emacs.d/README.org" "~/workspace/org/reference-cards/org-categories-tests/OrgTutorial.org" "~/workspace/org/birdz/birdz_tasks.org.txt" "~/workspace/org/agenda/agenda.org" "~/workspace/org/agenda/dates.org" "~/workspace/org/agenda/dette_cetelem.org" "~/workspace/org/agenda/pauses.org"))
 '(org-id-link-to-org-use-id 'create-if-interactive-and-no-custom-id)
 '(python-fill-docstring-style 'symmetric)
 '(recentf-auto-cleanup 'never)
 '(recentf-mode nil)
 '(safe-local-variable-values
   '((eval load "~/workspace/ada_test_architectures/src/.emacs_prj_settings/utils-test")
     (eval load "~/workspace/ada_test_architectures/src/.emacs_prj_settings/ata-repository-test")
     (eval load "~/workspace/ada_test_architectures/src/.emacs_prj_settings/ata-model-service-test")
     (eval load "~/workspace/ada_test_architectures/src/.emacs_prj_settings/ata-model-object-test")
     (eval load "~/workspace/ada_test_architectures/src/.emacs_prj_settings/ata-application-service-test")
     (eval load "~/workspace/ada_test_architectures/src/.emacs_prj_settings/ata-application-object-test")
     (eval load "~/workspace/ada_test_architectures/src/.emacs_prj_settings/ata-application-object")
     (eval load "~/workspace/ada_test_architectures/src/.emacs_prj_settings/ata-model-service")
     (eval load "~/workspace/ada_test_architectures/src/.emacs_prj_settings/ata-repository")
     (eval load "~/workspace/ada_test_architectures/src/.emacs_prj_settings/ata-model-object")
     (eval load "~/workspace/ada_test_architectures/src/.emacs_prj_settings/run")))
 '(show-paren-mode t))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
