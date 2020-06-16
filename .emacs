;;; XEmacs backwards compatibility file
(setq user-init-file
      (expand-file-name "init.el"
			(expand-file-name ".xemacs" "~")))
(setq custom-file
      (expand-file-name "custom.el"
			(expand-file-name ".xemacs" "~")))
(setq multi-term
      (expand-file-name "multi-term.el"
			(expand-file-name ".xemacs" "~")))
(setq window-numbering
      (expand-file-name "window-numbering.el"
			(expand-file-name ".xemacs" "~")))
(setq etags-select
      (expand-file-name "etags-select.el"
			(expand-file-name ".xemacs" "~")))
(load-file etags-select)
(load-file window-numbering)
(load-file multi-term)
(load-file user-init-file)
(load-file custom-file)
