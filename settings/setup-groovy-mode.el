; Only spaces, no tabs, indent by 4 spaces
(setq-default indent-tabs-mode nil)
(setq-default tab-width 4)
(setq indent-line-function 'insert-tab)
(defun my-c-mode-hook ()
  (setq indent-tabs-mode nil
        c-basic-offset 4))
(add-hook 'c-mode-common-hook 'my-c-mode-hook)

(provide 'setup-groovy-mode)
