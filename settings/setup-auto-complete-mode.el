(add-to-list 'load-path "~/elpa/auto-complete-20130503.2013")
                                        ; Load the default configuration
(require 'auto-complete-config)
                                        ; Make sure we can find the dictionaries
(add-to-list 'ac-dictionary-directories "~/elpa/auto-complete-20130209.651/dict")
                                        ; Use dictionaries by default
(setq-default ac-sources (add-to-list 'ac-sources 'ac-source-dictionary))
(global-auto-complete-mode t)
                                        ; Start auto-completion after 2 characters of a word
(setq ac-auto-start 2)
                                        ; case sensitivity is important when finding matches
(setq ac-ignore-case nil)

(provide 'setup-auto-complete-mode)
