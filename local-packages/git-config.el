;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;; magit
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(use-package magit
  ;;
  ;; TODO see magit-gitflow
  ;;
  :pin gnu
  :config

  ;; speed up magit
  (when (eq system-type 'windows-nt)
    (setq exec-path (add-to-list 'exec-path "C:/Program Files/Git/cmd"))
    (setq exec-path (add-to-list 'exec-path "C:/Program Files/Git/bin"))
    (setenv "PATH" (concat "C:\\Program Files\\Git\\cmd;"
                           "C:\\Program Files\\Git\\bin;"
                           (getenv "PATH"))))
  )

(use-package git-link
  :straight (:host github :repo "sshaw/git-link")
  )

;; doesn't work ... windows ?
;; (use-package magit-todos)
;; ;; https://github.com/alphapapa/magit-todos

(defhydra hydra-magit (:hint nil)
  "
_s_ status    _c_ commit
_P_ pull      _la_ log all
_p_ push      _d_ diff
"
  ("p" magit-push :exit t)
  ("P" magit-pull :exit t)
  ("c" magit-commit :exit t)
  ("d" magit-diff :exit t)
  ("la" magit-log-all :exit t)
  ("s" magit-status :exit t)
  )
