(defun ingenico-parse-log()
  (interactive)
  (goto-char (point-min))

  (with-current-buffer (get-buffer-create "ingenico-log.org")
    (erase-buffer)
    (insert "|--|--|--|--|--|--|--|" ?\n)
    (insert "| time | file | function | line | module | status | syserr | log | " ?\n)
    (insert "|--|--|--|--|--|--|--|" ?\n)
    )

  (defvar ip-regexp "")
  (defvar time-regexp "")
  (defvar line-start-regexp "")
  (defvar line-module "")
  (defvar line-file "")
  (defvar line-function "")
  (defvar line-line-number "")
  (defvar line-log "")
  (defvar line-status-code "")
  (defvar line-sys-code "")
  (defvar tmp-pos 0)
  (defvar is-line-processed nil)

  (setq ip-regexp "[0-9]+\\.[0-9]+\\.[0-9]+\\.[0-9]+: ")
  (setq time-regexp "[A-Z][a-z]\\{2\\} +[0-9]+ [0-9]\\{2\\}:[0-9]\\{2\\}:[0-9]\\{2\\} +")
  (setq line-start-regexp (concat ip-regexp "\\(" time-regexp "\\)"))

  ;; looking for date
  (while (search-forward-regexp line-start-regexp nil t nil)

    (defvar line-time "")

    (setq line-time (match-string 1)
          line-module ""
          line-file ""
          line-function ""
          line-line-number ""
          line-log ""
          line-status-code ""
          line-sys-code ""
          )


    ;; ignore *.T3A
    (skip-chars-forward "^:")

    (setq is-line-processed nil)

    (save-excursion
      (goto-char (line-beginning-position))
      (setq is-line-processed t)
      (when (search-forward "Sample" (line-end-position) t)
        (when (search-forward "No pinpad connected" (line-end-position) t)
          (setq is-line-processed nil)
          )))

    (when is-line-processed
      (if (search-forward "[" (line-end-position) t 2)
          ;; dll or sch
          (progn
            (setq tmp-pos (point))

            (search-forward-regexp "\\([^ ]*\\) \\([^ ]*\\) \\([^] ]*\\)")

            (setq line-file (match-string 1))
            (setq line-function (match-string 2))
            (setq line-line-number (match-string 3))

            (when (search-forward "]" (line-end-position) t)
              ;; (setq line-place (buffer-substring-no-properties tmp-pos (point)))

              (if (search-forward "E=<" (line-end-position) t)
                  ;; dll
                  (progn
                    (setq line-module "DLL")
                    (setq tmp-pos (point))
                    (if (looking-at "0x")
                        (progn
                          (goto-char (+ 2 (point)))
                          (setq tmp-pos (point))
                          (skip-chars-forward "0-9A-F"))
                      (skip-chars-forward "A-Z_")
                      )
                    (setq line-status-code (buffer-substring-no-properties tmp-pos (point)))

                    (save-excursion
                      (when (search-forward "Os/Sch=" (line-end-position) t)
                        (setq tmp-pos (point))
                        (skip-chars-forward "0-9A-F")
                        (setq line-sys-code (buffer-substring-no-properties tmp-pos (point)))))

                    )
                ;; sch
                (setq line-module "Scheme")
                (goto-char (line-beginning-position))
                (search-forward "Err=" (line-end-position))
                (setq tmp-pos (point))
                (skip-chars-forward "0-9A-F")
                (setq line-status-code (buffer-substring-no-properties tmp-pos (point)))
                (when (string-prefix-p "0x" line-status-code)
                  (setq line-status-code (substring line-status-code 3))
                  )
                (save-excursion
                  (when (search-forward "Bis=" (line-end-position) t)
                    (setq tmp-pos (point))
                    (skip-chars-forward "0-9A-F")
                    (setq line-sys-code (buffer-substring-no-properties tmp-pos (point)))))
                )
              )

            (skip-chars-forward "^:")
            (setq line-log (buffer-substring-no-properties (+ 1 (point)) (line-end-position)))
            )

        (skip-chars-forward ": ")
        ;; (search-forward "NarPinChange")
        ;; (skip-chars-forward "A-Za-z")
        ;; (skip-chars-forward " ")
        (setq line-log (buffer-substring-no-properties (point) (line-end-position)))
        )

      (when (equal line-module "") (setq line-module "Sample"))

      (with-current-buffer (get-buffer-create "ingenico-log.org")
        (insert "|"
                line-time "|"
                line-file "|"
                line-function "|"
                line-line-number "|"
                line-module "|"
                line-status-code "|"
                line-sys-code "|"
                line-log "|"
                ?\n)
        )
      )
    )

  (switch-to-buffer "ingenico-log.org")
  (goto-char (point-min))
  (org-mode)
  (org-ctrl-c-ctrl-c)
  )

(provide 'ingenico-parse-log)
