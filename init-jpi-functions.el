;;; init-jpi-functions.el --- my personnal functions

(defun jpi/indent-buffer ()
  (interactive)
  (let ((position (point)))
    (cond ((derived-mode-p 'cc-mode)
           (clang-format-buffer))
          (t
           (indent-region (point-min) (point-max))
           (goto-char position)))))

(defalias 'indent-buffer 'jpi/indent-buffer)

(defun jpi/initial-buffer ()
  (interactive)
  (let ((jp--buffer (get-buffer-create "*fetching.org*")))
    (set-buffer jp--buffer)
    (org-mode)
    (insert "#+NAME: output-fetch-repositories\n"
            "#+CALL: ~/workspace/org/startup.org:fetch-repositories()")
    (beginning-of-line)
    jp--buffer
    ))

(defun jpi/stop-loading-file ()
  (with-current-buffer " *load*"
    (goto-char (point-max))))

(provide 'jpi/functions)

;;; init-jpi-functions.el ends here
