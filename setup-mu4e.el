(require 'mu4e)
(setq mu4e-mu-binary "/usr/bin/mu")
(setq message-kill-buffer-on-exit t)

(setq mu4e-maildir (expand-file-name "~/.email/mbsyncmail"))
(setq mu4e-drafts-folder "/Drafts")
(setq mu4e-sent-folder   "/Sent Items")
(setq mu4e-trash-folder  "/Trash")
(setq message-signature-file "~/.emacs.d/.signature") ; put your signature in this file

(defun my-render-html-message ()
  (let ((dom (libxml-parse-html-region (point-min) (point-max))))
    (erase-buffer)
    (shr-insert-document dom)
    (goto-char (point-min))))

;; get mail
;; (setq mu4e-get-mail-command "mbsync -c ~/.emacs.d/.mbsyncrc home"
;;       mu4e-html2text-command "w3m -T text/html"
;;       mu4e-update-interval 120
;;       mu4e-headers-auto-update t
;;       mu4e-compose-signature-auto-include nil)

(setq mu4e-get-mail-command "mbsync -c ~/.emacs.d/.mbsyncrc home"
      mu4e-html2text-command 'my-render-html-message
      mu4e-update-interval 120
      mu4e-headers-auto-update t
      mu4e-compose-signature-auto-include nil)

(setq mu4e-maildir-shortcuts
      '( ("/INBOX"               . ?i)
         ("/Sent Items"   . ?s)
         ("/Trash"       . ?t)
         ("/Drafts"    . ?d)))

;; don't save message to Sent Messages, Gmail/IMAP takes care of this
(setq mu4e-sent-messages-behavior 'delete)

;; don't prompt for applying of marks, just apply
(setq mu4e-headers-leave-behavior 'apply)

;; Try to display images in mu4e
(setq
 mu4e-view-show-images t
 mu4e-view-image-max-width 800)

(setq
 message-send-mail-function   'smtpmail-send-it
 smtpmail-default-smtp-server "smtp.gmail.com"
 smtpmail-smtp-server         "smtp.gmail.com"
 smtpmail-local-domain        "smtp.gmail.com")

;; use imagemagick, if available
(when (fboundp 'imagemagick-register-types)
  (imagemagick-register-types))

;; (setq mu4e-confirm-quit nil
;;       mu4e-headers-date-format "%d/%b/%Y %H:%M" ; date format
;;       mu4e-html2text-command "html2text -utf8 -width 72")

;; Start mu4e in fullscreen, immediately ping for new mail
(defun mu4e-up-to-date-status ()
  (interactive)
  (window-configuration-to-register :mu4e-fullscreen)
  (mu4e)
  (mu4e-update-mail-show-window)
  (delete-other-windows))

;; Restore previous window configuration
(defun mu4e-quit-session ()
  "Restores the previous window configuration and kills the magit buffer"
  (interactive)
  (kill-buffer)
  (jump-to-register :mu4e-fullscreen))

(define-key mu4e-main-mode-map (kbd "q") 'mu4e-quit-session)
(define-key mu4e-main-mode-map (kbd "p") 'previous-line)
(define-key mu4e-main-mode-map (kbd "n") 'next-line)
(define-key mu4e-headers-mode-map (kbd "M-u") 'mu4e-update-mail-show-window)

(provide 'setup-mu4e)
