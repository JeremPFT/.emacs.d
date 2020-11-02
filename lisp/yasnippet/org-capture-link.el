;; used by snippet ~/.emacs.d/snippets/org-mode/new_link

;; ######################################################
;; replaces URL with Org-mode link including description
;; see id:2014-03-09-inbox-to-bookmarks
(defun my-www-get-page-title (url)
  "retrieve title of web page.
from: http://www.opensubscriber.com/message/help-gnu-emacs@gnu.org/14332449.html"
  (let ((title))

    (with-current-buffer (get-buffer-create "*capture url*")
      (erase-buffer)
      (insert-buffer (url-retrieve-synchronously url))
      (goto-char (point-min))
      (re-search-forward "<title>\\([^<]*\\)</title>" nil t 1)
      (setq title (match-string 1))
      (goto-char (point-min))
      (re-search-forward "charset=\"?\\([-0-9a-zA-Z]*\\)\"?" nil t 1)
      (decode-coding-string title (intern (downcase (match-string 1))))))
  )

(defun my-url-link-image()
  "Build string to output."
  (interactive)
  (let* (
         ;; (bds (bounds-of-thing-at-point 'url))
         ;; (beg (car bds))
         ;; (end (cdr bds))
         ;; (url (buffer-substring-no-properties beg end))
         (url "")
         (title "")
         )
    (message "my-url-link-image-wo-arg")
    (setq url (funcall interprogram-paste-function))
    (if (or (string= url "") (eq url nil))
        "no url in clipboard"
      (concat "[[" url "][" (my-www-get-page-title url) "]]"))))

(defun my-url-linkify ()
  "Make URL at cursor point into an Org-mode link.
If there's a text selection, use the text selection as input.

Example: http://example.com/xyz.htm
becomes
\[\[http://example.com/xyz.htm\]\[Source example.com\]\]

Adapted code from: http://ergoemacs.org/emacs/elisp_html-linkify.html"
  (interactive)
    (insert (my-url-link-image)))


;; (let (resultLinkStr bds p1 p2 domainName)
;;   ;; get the boundary of URL or text selection
;;   (if (region-active-p)
;;       (setq bds (cons (region-beginning) (region-end)) )
;;     (setq bds (bounds-of-thing-at-point 'url))
;;     )
;;   ;; set URL
;;   (setq p1 (car bds))
;;   (setq p2 (cdr bds))
;;   (let (
;;         (url (buffer-substring-no-properties p1 p2))
;;         )
;;     ;; retrieve title
;;     (let ((title (my-www-get-page-title url)))
;;       (message (concat "title is: " title))
;;       ;;(setq url (replace-regexp-in-string "&" "&amp;" url))
;;       (let ((resultLinkStr (concat "[[" url "][" title "]]")))
;;         ;; delete url and insert the link
;;         (delete-region p1 p2)
;;         (insert resultLinkStr)
;;         )
;;       )
;;     )
;;   )
;; )
