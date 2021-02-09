;;; init-jpi-constants.el --- my personnal constants

;;
;; + COMPUTERS IDENTIFICATIONS
;;

;; - NAMES

(defconst current-computer-name
  (upcase (system-name)))

(defconst ingenico-computer-name
  "FR0WSC3NRYM2")

(defconst home-computer-name
  "DESKTOP-5R08DIM")

(defconst birdz-computer-name
  "JPIFFRET-PC")

(defconst birdz-debian-computer-name
  "DEBIAN-BIRDZ-JPI")

;; - PREDICATES

(defconst ingenico-computer-p
  (string= current-computer-name
	   ingenico-computer-name))

(defconst home-computer-p
  (string= current-computer-name
	   home-computer-name))

(defconst birdz-computer-p
  (string= current-computer-name
	   birdz-computer-name))

(defconst birdz-debian-computer-p
  (string= current-computer-name
	   birdz-debian-computer-name))

;;
;; + OS IDENTIFICATIONS
;;

(defconst windows-p (eq system-type 'windows-nt))
(defconst cygwin-p (eq system-type 'cygwin))
(defconst linux-p (eq system-type 'gnu/linux))

(unless (or
         ingenico-computer-p
         home-computer-p
         birdz-computer-p
         birdz-debian-computer-p)
  (warn (concat "current computer unknown: " current-computer-name)))

;;
;; + DIRECTORIES
;;

(defconst home-dir (file-name-as-directory (getenv "HOME")))

(defconst home-bin-dir (file-name-as-directory (concat home-dir "bin")))
(unless (file-exists-p home-bin-dir) (warn "please create \"~/bin\" directory"))

(defconst workspace-dir (file-name-as-directory (concat home-dir "workspace")))

;;; init-jpi-constants.el ends here
