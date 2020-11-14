(use-package auctex
  ;; https://www.gnu.org/software/auctex/
  :when home-computer-p
  :defer t
  :ensure nil
  :custom
  (ConTeXt-Mark-version "IV")
  :config
  (defvar TeX-command-list)
  (defvar TeX-command-default1)
  (add-hook 'ConTeXt-mode-hook
            (lambda()
              (setq TeX-command-default "ConTeXt Full")))
  (add-hook 'TeX-mode-hook
            (lambda()
              (when (equal major-mode 'context-mode)
                (setq TeX-command-default "ConTeXt Full"))))
  (setq TeX-command-list
        (quote
         (("TeX" "%(PDF)%(tex) %(file-line-error) %`%(extraopts) %S%(PDFout)%(mode)%' %t" TeX-run-TeX nil
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
          ("Other" "" TeX-run-command t t :help "Run an arbitrary command"))))
  )
