;;;; D:\Users\jpiffret\emacs-26.1-i686\bin\runemacs.exe --eval "(setenv \"HOME\" \"d:/Users/jpiffret/AppData/Roaming/Dropbox/emacs_ingenico\")" --load d:/Users/jpiffret/AppData/Roaming/Dropbox/emacs_ingenico/.emacs
(setenv "HOME" "d:/Users/jpiffret/AppData/Roaming/Dropbox/emacs_ingenico")

;; git: JeremPFT TCiBpZifai9m3Gk2
;; cbb240b4c6ca715746c2a0cdbc4fd990b7464713

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;; custom
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(setq custom-file "~/.emacs.d/.emacs-custom.el")
(load custom-file)

(add-to-list 'load-path "~/.emacs.d/lisp/")
(byte-recompile-directory "~/.emacs.d/lisp/" 0)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;; el-get
;;;; source: https://github.com/dimitri/el-get/blob/master/README.md
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(add-to-list 'load-path "~/.emacs.d/el-get/el-get")

(unless (require 'el-get nil t)
  (url-retrieve
   "https://github.com/dimitri/el-get/raw/master/el-get-install.el"
   (lambda (s)
     (let (el-get-install-skip-emacswiki-recipes)
       (goto-char (point-max))
       (eval-print-last-sexp)))))

(add-to-list 'el-get-recipe-path "~/.emacs.d/el-get-jpi/recipes")

(setq my-packages
      (append
       '(el-get)
       ;; '(el-get ada-mode)
       (mapcar 'el-get-source-name el-get-sources)))

(el-get 'sync my-packages)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;; packages
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(package-initialize)

(add-to-list 'package-archives
             '("jpi" . "~/package-repo-jpi/") t)

;; (add-to-list 'load-path "~/.emacs.d/elpa/benchmark-init-20150905.938")
;; (require 'benchmark-init)
;; (add-hook 'after-init-hook 'benchmark-init/deactivate)

(unless (file-exists-p package-user-dir)
  (package-refresh-contents))

(setq package-list '(
                     flx-ido
                     flx-isearch
                     flx
                     magit
                     org
                     ada-mode
                     paradox
                     ))

(dolist (package package-list)
  (unless (package-installed-p package)
    (package-install package)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;; clone package repository
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(add-to-list 'load-path "~/.emacs.d/lisp/elpa-mirror")
(require 'elpa-mirror)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;; environment
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(setenv "PATH" (concat "C:\\Program Files (x86)\\GnuWin32\\bin;"  (getenv "PATH")))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;; development
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(add-hook 'c-mode-hook (lambda () (setq comment-start "//"
                                        comment-end   "")))

(c-add-style "ingenico"
             '("gnu"
               (c-basic-offset . 2)     ; Guessed value
               (c-offsets-alist
                (block-close . 0)       ; Guessed value
                (brace-entry-open . 0)  ; Guessed value
                (brace-list-close . 0)  ; Guessed value
                (brace-list-intro . +)  ; Guessed value
                (brace-list-open . 0)   ; Guessed value
                (case-label . +)        ; Guessed value
                (class-close . 0)       ; Guessed value
                (class-open . 0)        ; Guessed value
                (defun-block-intro . +) ; Guessed value
                (defun-close . 0)       ; Guessed value
                (defun-open . 0)        ; Guessed value
                (do-while-closure . 0)  ; Guessed value
                (else-clause . 0)       ; Guessed value
                (inclass . +)           ; Guessed value
                (statement . 0)             ; Guessed value
                (statement-block-intro . +) ; Guessed value
                (statement-case-intro . +) ; Guessed value
                (substatement . +)      ; Guessed value
                (substatement-open . 0) ; Guessed value
                (topmost-intro . 0)     ; Guessed value
                (access-label . -)
                (annotation-top-cont . 0)
                (annotation-var-cont . +)
                (arglist-close . c-lineup-close-paren)
                (arglist-cont c-lineup-gcc-asm-reg 0)
                (arglist-cont-nonempty . c-lineup-arglist)
                (arglist-intro . c-lineup-arglist-intro-after-paren)
                (block-open . 0)
                (brace-list-entry . 0)
                (c . c-lineup-C-comments)
                (catch-clause . 0)
                (comment-intro . c-lineup-comment)
                (composition-close . 0)
                (composition-open . 0)
                (cpp-define-intro c-lineup-cpp-define +)
                (cpp-macro . -1000)
                (cpp-macro-cont . 0)
                (extern-lang-close . 0)
                (extern-lang-open . 0)
                (friend . 0)
                (func-decl-cont . +)
                (incomposition . +)
                (inexpr-class . +)
                (inexpr-statement . +)
                (inextern-lang . 0)
                (inher-cont . c-lineup-multi-inher)
                (inher-intro . +)
                (inlambda . c-lineup-inexpr-block)
                (inline-close . 0)
                (inline-open . 0)
                (inmodule . +)
                (innamespace . +)
                (knr-argdecl . 0)
                (knr-argdecl-intro . 5)
                (label . 0)
                (lambda-intro-cont . +)
                (member-init-cont . c-lineup-multi-inher)
                (member-init-intro . +)
                (module-close . 0)
                (module-open . 0)
                (namespace-close . 0)
                (namespace-open . 0)
                (objc-method-args-cont . c-lineup-ObjC-method-args)
                (objc-method-call-cont c-lineup-ObjC-method-call-colons c-lineup-ObjC-method-call +)
                (objc-method-intro .
                                   [0])
                (statement-case-open . 0)
                (statement-cont . +)
                (stream-op . c-lineup-streamop)
                (string . -1000)
                (substatement-label . 0)
                (template-args-cont c-lineup-template-args +)
                (topmost-intro-cont first c-lineup-topmost-intro-cont c-lineup-gnu-DEFUN-intro-cont))))

(add-hook 'c-mode-hook (lambda () (c-set-style "ingenico")))
(add-hook 'cc-mode-hook (lambda () (c-set-style "ingenico")))
(add-hook 'c-mode-hook (lambda () (electric-pair-mode)))
(add-hook 'cc-mode-hook (lambda () (electric-pair-mode)))

(defun insert-html-tag ()
  "to be used for Doxygen"
  (interactive)
  (let ( tag in-region region-start region-stop )
    (setq tag (read-from-minibuffer "tag? "))
    (setq in-region (region-active-p))
    (when in-region
      (setq region-start (region-beginning)
            region-stop (region-end))
      )

    (when in-region
      (goto-char region-start))
    (insert ?< tag ?>)
    (when in-region
      (goto-char (+ region-stop (string-width tag) 2)))
    (insert ?< ?/ tag ?>)
    ))

(add-hook 'c-mode-hook
          (lambda ()
            (local-set-key (kbd "C-c C-t") (quote insert-html-tag))))

(add-hook 'python-mode-hook (lambda () (electric-pair-mode)))

;; following work with C-s but not with M-% ... :(
(define-key minibuffer-local-map "(" 'self-insert-command )
(define-key minibuffer-local-ns-map "(" 'self-insert-command )

;; pretty print
;;
(defun jpi-pp()
  "pretty printer. Only when an region is selected. Only useful in C."
  (interactive)
  (let ((start (region-beginning))(stop (region-end)))
    (indent-region start stop)
    (align nil nil)
    (indent-region start stop)
    (align nil nil)
    ))

(defun jpi-pp-2()
  "pretty printer space operator"
  (interactive)

  (setq start-pos (point))

  (setq group-operators '("[" "]" "(" ")" "{" "}"))
  (setq operators '("," "*" "&" "+" "-" "/"))

  (while group-operators
    (let (operator regexp)
      (setq operator (car group-operators)
            group-operators (cdr group-operators)
            regexp "[]A-Za-z_0-9*&[()+/*,\"]")

      (goto-char start-pos)

      (while (search-forward operator nil t nil)

        ;; not inside string or comment
        (unless (or (nth 3 (syntax-ppss))
                    (nth 4 (syntax-ppss)))

          (unless (= (point) (line-beginning-position))
            (forward-char -1)
            (when (looking-back regexp)
              (insert " ")))

          (forward-char 1)
          (when (looking-at regexp)
            (unless (looking-at ",")
                    (insert " "))))

        ) ;; while search
      ) ;; let
    ) ;; while group-operators

  (while operators
    (let (operator)
      (setq operator (car operators)
            operators (cdr operators)
            regexp "[A-Za-z_0-9]")

      (goto-char start-pos)

      (while (search-forward operator nil t nil)

        (unless (or (nth 3 (syntax-ppss))
                    (nth 4 (syntax-ppss)))

          (unless (string= operator ",")
            (unless (= (point) (line-beginning-position))
              (forward-char -1)
              (when (looking-back regexp)
                (unless (or (string= (buffer-substring-no-properties (point) (+ 2 (point))) "->")
                            (string= (buffer-substring-no-properties (point) (+ 2 (point))) "*/"))
                  (insert " ")))
              (forward-char)))

          (when (looking-at regexp)
            (insert " ")))
        ) ;; while search
      ) ;; let
    ) ;; while operators
  )

(defun ada-when-open-hook ()
  (when (eq major-mode 'ada-mode)
    (fci-mode)
    (setq fci-rule-column 78)))

(add-hook 'after-change-major-mode-hook #'ada-when-open-hook)

(add-hook 'before-save-hook #'ada-before-save-hook)

(defun ada-before-save-hook ()
  (when (eq major-mode 'ada-mode)
    (ada-case-adjust-buffer)
    (indent-buffer)))

(add-hook 'before-save-hook #'ada-before-save-hook)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;; TODO: categorize
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; (provide 'virtual-desktops)
;; seems to corrupt ibuffer
;; (require 'session)
;; (add-hook 'after-init-hook 'session-initialize)
;; (desktop-save-mode -1)


(add-hook 'before-save-hook 'delete-trailing-whitespace)
;; (defun my-prog-nuke-trailing-whitespace ()
;;   (when (derived-mode-p 'prog-mode)
;;     (delete-trailing-whitespace)))
;; (add-hook 'before-save-hook 'my-prog-nuke-trailing-whitespace)

(global-hl-line-mode 1)

;; (require 'grep-edit)
(require 'fill-column-indicator)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;; magit
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; (add-to-list 'load-path "~/.emacs.d/lisp/magit-gitflow-master")
;; (byte-recompile-directory "~/.emacs.d/lisp/magit-gitflow-master" 0)
;; (require 'magit-gitflow)
;; (add-hook 'magit-mode-hook 'turn-on-magit-gitflow)

;; speed up magit
(if (eq system-type 'windows-nt)
    (progn
      (setq exec-path (add-to-list 'exec-path "C:/Program Files/Git/bin"))
      (setenv "PATH" (concat "C:\\Program Files\\Git\\bin;" (getenv "PATH")))))

;; ajoute une liste de fichiers suivi sous git.
;; PROBLEM : n'est pas récursif, n'affiche que les éléments du répertoire racine ...
;;
;; (magit-add-section-hook
;;    'magit-status-sections-hook
;;    'magit-insert-tracked-files
;;    nil
;;    'append)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;; elisp (personal, imported)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(require 'dired+)
;; I want the same color for file name and extension
(setq diredp-file-suffix diredp-file-name)

(require 'htmlize)

(add-to-list 'load-path "~/.emacs.d/lisp/Emacs-wgrep-master")
(byte-recompile-directory "~/.emacs.d/lisp/Emacs-wgrep-master" 0)
(require 'wgrep)

(add-to-list 'load-path "~/.emacs.d/lisp/bookmark-plus")
(byte-recompile-directory "~/.emacs.d/lisp/bookmark-plus" 0)
(require 'bookmark+)

(add-to-list 'load-path "~/.emacs.d/lisp/openssl-cipher")
(byte-recompile-directory "~/.emacs.d/lisp/openssl-cipher" 0)
(require 'openssl-cipher)

(require 'ingenico-parse-log)
(defalias 'yes-or-no-p 'y-or-n-p)
(global-set-key (kbd "<f5>") 'revert-buffer)
(global-set-key (kbd "C-x C-g") 'goto-line)
(global-set-key (kbd "C-x C-b") 'ibuffer)
(global-set-key (kbd "C-x b") 'ido-switch-buffer)

(defun indent-buffer ()
  (interactive)
  (indent-region (point-min) (point-max)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;; flx (completion engine for Ido)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; recommended: https://docs.projectile.mx/en/latest/configuration/#ido

(require 'flx-ido)

(setq my-ido-decorations
      '("\n-> " "" "\n   " "\n   ..." "[" "]"
        " [No match]" " [Matched]" " [Not readable]" " [Too big]" " [Confirm]"))
(setq orig-ido-decorations
      '("{" "}" " | " " | ..." "[" "]"
        " [No match]" " [Matched]" " [Not readable]" " [Too big]" " [Confirm]"))

;; M-x customize-variable ido-decorations

(ido-mode 1)
(ido-everywhere 1)
(flx-ido-mode 1)
;; disable ido faces to see flx highlights.
(setq ido-enable-flex-matching t)
(setq ido-use-faces nil)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;; asn1-mode
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; warning: The old asn1-mode works. The new one doesn't.

(setq auto-mode-alist
      (cons '("\\.[Aa][Ss][Nn][1]?$" . asn1-mode) auto-mode-alist))
(autoload 'asn1-mode "asn1-mode.el"
  "Major mode for editing ASN.1 specifications." t)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;; calendar
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; add week number
(copy-face font-lock-constant-face 'calendar-iso-week-face)
(set-face-attribute 'calendar-iso-week-face nil
                    :height 1.0 :foreground "salmon")
;; (set-face-attribute 'calendar-iso-week-face nil
;;                     :height 0.7)
(setq calendar-intermonth-text
      '(propertize
        (format "%2d"
                (car
                 (calendar-iso-from-absolute
                  (calendar-absolute-from-gregorian (list month day year)))))
        'font-lock-face 'calendar-iso-week-face))

(copy-face 'default 'calendar-iso-week-header-face)
(set-face-attribute 'calendar-iso-week-header-face nil
                    :height 1.0 :foreground "salmon")
(setq calendar-intermonth-header
      (propertize "Wk"                  ; or e.g. "KW" in Germany
                  'font-lock-face 'calendar-iso-week-header-face))

(require 'french-holidays)
(setq calendar-holidays holiday-french-holidays)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;; org-mode
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(add-to-list 'auto-mode-alist '("\\.org\\.txt\\'" . org-mode))
(add-to-list 'auto-mode-alist '("\\.txt\\'" . org-mode))

;;; patched function org-translate-time from org.el
;;; replaced
;; (concat
;;  (if inactive "[" "<") (substring tf 1 -1)
;;  (if inactive "]" ">"))
;;; with

;; (require 'org-collector)
;; removed: default behavior is better ...
;; see https://orgmode.org/manual/Capturing-column-view.html: C-c C-x i (org-insert-columns-dblock))

(global-set-key (kbd "C-c c") 'org-capture)

;; setting up org-babel for literate programming
(org-babel-do-load-languages
 'org-babel-load-languages
 '(
   (python . t)
   ;;   (sh . t)
   (C . t)
   ;; Include other languages here...
   ))
;; Syntax highlight in #+BEGIN_SRC blocks
(setq org-src-fontify-natively t)
;; Don't prompt before running code in org
(setq org-confirm-babel-evaluate nil)
;; Fix an incompatibility between the ob-async and ob-ipython packages
(progn
  (defvar ob-async-no-async-languages-alist)
  (setq ob-async-no-async-languages-alist '("ipython")))

(setq-default org-src-window-setup 'current-window)

(progn
  (defvar org-html-postamble)
  (setq org-html-postamble nil))

(declare-function org-html--format-toc-headline "ext:org-mode")
(declare-function org-export-get-relative-level "ext:org-mode")
(declare-function org-export-collect-headlines "ext:org-mode")
(declare-function org-html-html5-p "ext:org-mode")
(declare-function org-html--toc-text "ext:org-mode")

(defun org-html-toc (depth info)
  "Redefines function from ox-html.el to remove 'Table of Contents'
Build a table of contents.
DEPTH is an integer specifying the depth of the table.  INFO is a
plist used as a communication channel.  Return the table of
contents as a string, or nil if it is empty."
  (let ((toc-entries
	 (mapcar (lambda (headline)
		   (cons (org-html--format-toc-headline headline info)
			 (org-export-get-relative-level headline info)))
		 (org-export-collect-headlines info depth)))
	(outer-tag (if (and (org-html-html5-p info)
			    (plist-get info :html-html5-fancy))
		       "nav"
		     "div")))
    (when toc-entries
      (concat (format "<%s id=\"table-of-contents\">\n" outer-tag)
	      ;; (format "<h%d>%s</h%d>\n"
	      ;;         org-html-toplevel-hlevel
	      ;;         (org-html--translate "Table of Contents" info)
	      ;;         org-html-toplevel-hlevel)
	      "<div id=\"text-table-of-contents\">"
	      (org-html--toc-text toc-entries)
	      "</div>\n"
	      (format "</%s>\n" outer-tag)))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;; auto remove mouse pointer
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; emacs-25.3_1-x86_64/share/emacs/25.3/lisp/avoid.el
;; move mouse pointer when near the cursor
(when (display-mouse-p) (mouse-avoidance-mode 'jump))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;; enabled commands
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(put 'erase-buffer 'disabled nil)
(put 'narrow-to-region 'disabled nil)
(put 'upcase-region 'disabled nil)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;; scratch buffer
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defun unkillable-scratch-buffer ()
  (if (equal (buffer-name (current-buffer)) "*scratch*")
      (progn
        (delete-region (point-min) (point-max))
        nil)
    t))

(add-hook 'kill-buffer-query-functions 'unkillable-scratch-buffer)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;; projectile configuration
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; removed jpi (projectile-mode nil)
;; (define-key projectile-mode-map (kbd "C-c p") 'projectile-command-map)
;; (setq projectile-switch-project-action #'projectile-dired)
;; (setq projectile-enable-caching t)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;; perspeen configuration
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; removed jpi (perspeen-mode nil)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;; completion: ido + flx
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(require 'flx-ido)
(ido-mode 1)
(flx-ido-mode 1)
(ido-everywhere 1)

;; disable ido faces to see flx highlights.
(setq ido-enable-flex-matching t)
(setq ido-use-faces nil)

(define-key (cdr ido-minor-mode-map-entry) [remap write-file] nil)
(define-key (cdr ido-minor-mode-map-entry) [remap dired-create-directory] nil)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;; replace+
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; from https://www.emacswiki.org/emacs/OccurMode

(require 'replace+)
;; (define-key occur-mode-map (kbd "C-*") 'next-error)
;; (define-key occur-mode-map (kbd "C-/") 'previous-error)

(global-set-key (kbd "C-*") 'next-error)
(global-set-key (kbd "C-/") 'previous-error)

;; force to use the same window as *Occur* to show the occurence
(defadvice occur-next-error (before my-occur-next-error activate)
  (let ((win (get-buffer-window (current-buffer))))
    (if win
        (select-window win))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;; emacs client
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; setenv EMACS_SERVER_FILE=.emacs.d/server/server

(server-start)
