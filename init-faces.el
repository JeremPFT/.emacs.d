(let ((face-foundry (cond
                     ((or windows-p cygwin-p) "outline")
                     (linux-p   "PfEd")
                     (t         "")
                     ))
      (face-family (cond
                    ((or windows-p cygwin-p) "Consolas")
                    (linux-p   "DejaVu Sans Mono")
                    (t         "")
                    ))
      (face-height (cond
                    (home-computer-p 200)
                    (birdz-debian-computer-p 140)
                    (t 140)))
      )
  (set-face-attribute 'default nil
                      :inherit nil
                      :stipple nil
                      :background "#050000"
                      :foreground "#bbe0f0"
                      :inverse-video nil
                      :box nil
                      :strike-through nil
                      :overline nil
                      :underline nil
                      :slant 'normal
                      :weight 'normal
                      :height face-height
                      :width 'normal
                      :foundry face-foundry
                      :family face-family))

;;; init-faces.el ends here
