;; Nathan Yee default .emacs initialization file

(setq package-enable-at-startup nil)
(package-initialize)

;; Are we running XEmacs or Emacs?
(defvar running-xemacs (string-match "XEmacs\\|Lucid" emacs-version))
(set-scroll-bar-mode 'right)   ; replace 'right with 'left to place it to the left

;; Turn on font-lock mode for Emacs
(cond ((not running-xemacs)
	   (global-font-lock-mode t)))

;; Set the hostname without the suffix
(setq host (system-name))
;(if (string-match "^\\([^\.]+\\)\." (system-name))
;    (setq host (substring (system-name) (match-beginning 1) (match-end 1)))
;  (setq host (system-name)))

;; Set the title
(defvar title '("%b|" user-real-login-name "@" host "|(%f)"))

;; Set the font
;(set-default-font "fixed")


;; Always end a file with a newline
(setq require-final-newline t)
(setq next-line-add-newlines		nil)
(setq
 c-mode-hook '(lambda ()
  (auto-fill-mode 1))
 c++-mode-hook '(lambda ()
	(auto-fill-mode 1))
 text-mode-hook '(lambda ()
	(auto-fill-mode 1))
 java-mode-hook '(lambda ()
	 (c-set-style "gnu")))

;;(if (not (fboundp 'php-mode))
;; Make it so PHP is handled like perl
(setq auto-mode-alist (append (list (cons "\\.php\\'" 'perl-mode))
				  auto-mode-alist))
;;)

;; Make it so expect is handled like sh
(setq auto-mode-alist (append (list (cons "\\.exp\\'" 'tcl-mode))
				  auto-mode-alist))
;; Make it so .m4 is handled like sh
(setq auto-mode-alist (append (list (cons "\\.m4\\'" 'sh-mode))
				  auto-mode-alist))

;; Make javascript work like a c file
(setq auto-mode-alist (append (list (cons "\\.js\\'" 'c-mode))
				  auto-mode-alist))


(setq-default icon-title-format title)
(setq-default frame-title-format title)
(setq inhibit-splash-screen t)
(setq default-tab-width 4)
(setq use-file-dialog nil)
(setq sh-basic-offset 8)
;; Stop at the end of the file, not just add lines
(setq next-line-add-newlines nil)
(setq c-default-style "linux")
(setq-default c-basic-offset 4)


(defun stamp-region-active-p ()
  "Say whether the region is active."
  (and (boundp 'transient-mark-mode)
	   transient-mark-mode
	   (boundp 'mark-active)
	   mark-active))

(defun delete-backward-region ()
  (setq transient-mark-mode t)
  (interactive)
  (if (not (stamp-region-active-p))
	  (delete-backward-char 1)
	  (kill-region (mark) (point))
  )
  (set-mark nil)
  (setq transient-mark-mode nil)
)

;; Set up the keyboard so the delete key on both the regular keyboard
;; and the keypad delete the character under the cursor and to the right
;; under X, instead of the default, backspace behavior.
;(global-set-key [backspace] 'delete-backward-char)
(global-set-key [delete] 'delete-char)
(global-set-key [kp-delete] 'delete-char)
(global-set-key [mouse-3] 'delete-backward-region)
(global-set-key [mouse-6] 'undo)
(global-set-key [mouse-7] "\C-Z") ;;redo
(global-set-key [(shift backspace)] 'delete-backward-region)
(display-time)
;; turn on syntax highlighting
;;
(require 'font-lock)
;; Turn on font-lock in all modes that support it
(if (fboundp 'global-font-lock-mode)
	(global-font-lock-mode t))
;;(font-lock-make-faces t)
(setq font-lock-maximum-decoration t)
(set-default 'scroll-step 3)     ; so emacs won't recenter window when I scroll
(global-unset-key "\e\e") ;unbind 'esc esc' to avoid common miskey

(global-set-key "\C-o" 'find-file)
(global-set-key "\C-r" 'query-replace-regexp)
(global-set-key "\C-g" 'goto-line )
(global-set-key "\^C\^I" 'indent-region)
(global-set-key "\C-xf" 'isearch-forward)

;(require 'xcscope)
;(global-set-key [f1]  'cscope-set-initial-directory)
;; (define-key global-map [(control f4)]  'cscope-unset-initial-directory)
;(global-set-key [f4]  'cscope-find-this-symbol)
;(global-set-key [f5]  'cscope-find-global-definition-no-prompting)
;;(define-key global-map [(control f8)]  'cscope-pop-mark)
;;(define-key global-map [(control f9)]  'cscope-next-symbol)
;;(define-key global-map [(control f10)] 'cscope-next-file)
;;(define-key global-map [(control f11)] 'cscope-prev-symbol)
;;(define-key global-map [(control f12)] 'cscope-prev-file)
;;(define-key global-map [(meta f9)]  'cscope-display-buffer)
;;(define-key global-map [(meta f10)] 'cscope-display-buffer-toggle)
(global-set-key [f6] 'query-replace-regexp)
(global-set-key [f7] 'indent-region)
(global-set-key [f8] 'comment-region)
(global-set-key [f9] 'uncomment-region)
(global-set-key [f10] 'start-kbd-macro)
(global-set-key [f11] 'end-kbd-macro)
(global-set-key [f12] 'call-last-kbd-macro)

(define-key global-map [(control ?q)]  'kill-buffer)
;;(define-key global-map [(control ?f)]  'isearch-forward)
(define-key isearch-mode-map [(control ?f)] 'isearch-repeat-forward)
;;(keyboard-translate ?\C-f ?\C-s)
(global-set-key "\C-z" 'undo)
;;(keyboard-translate ?\C-z ?\C-_)
;;(keyboard-translate ?\C-c ?\M-w)
;;(keyboard-translate ?\C-v ?\C-y)
;;(keyboard-translate ?\C-s ?\C-x\C-s)
(global-set-key "\C-s" 'save-buffer)
;;(global-set-key "\C-a" 'write-file)

(global-set-key [vertical-scroll-bar mouse-1] 'scroll-bar-drag)

(defun up-slightly () (interactive) (scroll-up 5))
(defun down-slightly () (interactive) (scroll-down 5))
(global-set-key [mouse-4] 'down-slightly)
(global-set-key [mouse-5] 'up-slightly)

(defun up-one () (interactive) (scroll-up 1))
(defun down-one () (interactive) (scroll-down 1))
(global-set-key [(shift mouse-4)] 'down-one)
(global-set-key [(shift mouse-5)] 'up-one)

(defun up-a-lot () (interactive) (scroll-up))
(defun down-a-lot () (interactive) (scroll-down))
(global-set-key [(control mouse-4)] 'down-a-lot)
(global-set-key [(control mouse-5)] 'up-a-lot)

(setq inhibit-startup-message t)

;; (setq initial-frame-alist
;;       (cons
;;        '(foreground-color  . "White")
;;        initial-frame-alist))
;; (setq initial-frame-alist
;;       (cons
;;        '(background-color  . "Black")
;;        initial-frame-alist))
;; (setq initial-frame-alist
;;       (cons
;;        '(cursor-color      . "Pink")
;;        initial-frame-alist))

;; Display settings
;; default size and color options for all frames
;; foreground, background, and cursor colors
(setq default-frame-alist
	  (cons
	   '(foreground-color  . "White")
	   default-frame-alist))
(setq default-frame-alist
	  (cons
	   '(background-color  . "Black")
	   default-frame-alist))
(setq default-frame-alist
	  (cons
	   '(cursor-color      . "Pink")
	   default-frame-alist))
;;; ********************
;;; func-menu is a package that scans your source file for function
;;; definitions and makes a menubar entry that lets you jump to any
;;; particular function definition by selecting it from the menu.  The
;;; following code turns this on for all of the recognized languages.
;;; Scanning the buffer takes some time, but not much.
;;;
;;; Send bug reports, enhancements etc to:
;;; David Hughes <ukchugd@ukpmr.cs.philips.nl>
;;;
(cond (running-xemacs
	   (require 'func-menu)
	   (define-key global-map 'f8 'function-menu)
	   (add-hook 'find-file-hooks 'fume-add-menubar-entry)
	   (define-key global-map "\C-cl" 'fume-list-functions)
	   (define-key global-map "\C-cg" 'fume-prompt-function-goto)

	   ;; The Hyperbole information manager package uses (shift button2) and
	   ;; (shift button3) to provide context-sensitive mouse keys.  If you
	   ;; use this next binding, it will conflict with Hyperbole's setup.
	   ;; Choose another mouse key if you use Hyperbole.
	   (define-key global-map '(shift button3) 'mouse-function-menu)

	   ;; For descriptions of the following user-customizable variables,
	   ;; type C-h v <variable>
	   (setq fume-max-items 25
		 fume-fn-window-position 1
		 fume-auto-position-popup t
		 fume-display-in-modeline-p t
		 fume-menubar-menu-location "File"
		 fume-buffer-name "*Function List*"
		 fume-no-prompt-on-valid-default nil)
	   ))


(put 'downcase-region 'disabled nil)
(put 'upcase-region 'disabled nil)
(put 'dired-find-alternate-file 'disabled nil)

; list the packages you want
(setq package-list '(yasnippet auto-complete dracula-theme helm nyan-cat))

;; MELPA Packages
(setq package-archives '(("gnu" . "https://elpa.gnu.org/packages/")
						 ("marmalade" . "https://marmalade-repo.org/packages/")
						 ("melpa" . "https://melpa.org/packages/")))

; activate all the packages (in particular autoloads)
(package-initialize)

; fetch the list of packages available
(unless package-archive-contents
  (package-refresh-contents))

; install the missing packages
(dolist (package package-list)
  (unless (package-installed-p package)
	(package-install package)))

;; Start yasnippet at start
(add-to-list 'load-path "~/.emacs.d/elpa/yasnippet-20170216.1928")
(require 'yasnippet)
(yas-global-mode 1)

(add-to-list 'load-path "~/.emacs.d/elpa/auto-complete-1.5.1")
(add-to-list 'load-path "~/.emacs.d/elpa/popup-0.5.3")
(require 'auto-complete)
(global-auto-complete-mode t)

;; Delete the whole line
(global-set-key "\C-cd" 'kill-whole-line)

;; switch emacs frames
(global-set-key [C-tab] 'other-window)

(add-hook 'term-mode-hook
		  (lambda ()
			(add-to-list 'term-bind-key-alist '("M-[" . multi-term-prev))
			(add-to-list 'term-bind-key-alist '("M-]" . multi-term-next))))


(defvar ansi-color-names-vector
  ["#101010" "#803030" "#4b762f" "#aa9943"
   "#324c80" "#a06c9a" "#82b4ae" "#ededed"])

;; color layout is like this
;; (defvar ansi-color-names-vector
;;   ["black" "red" "green" "yellow" "orange" "magenta" "cyan" "white"])

;;; make the term beautifull
;; order of colours is wrong?
(eval-after-load 'term
  '(progn
	 (let ((term-face-names (vector 'term-color-black
					'term-color-red
					'term-color-green
					'term-color-yellow
					'term-color-blue
					'term-color-magenta
					'term-color-cyan
					'term-color-white
					'term))
	   (term-color-names (vconcat ansi-color-names-vector ["#d2dec4"])))
	   (set-face-background 'term 'nil)
	   (cl-mapc 'set-face-foreground term-face-names term-color-names)
	   (custom-set-variables
	'(term-default-bg-color "#000000")
	'(term-default-fg-color "#dddd00")))))

;; newline-without-break-of-line
(defun newline-without-break-of-line ()
  "1. move to end of the line.
  2. insert newline with index"

  (interactive)
  (let ((oldpos (point)))
	(end-of-line)
	(newline-and-indent)))

(global-set-key (kbd "<C-return>") 'newline-without-break-of-line)

;; Stop auto indent when <ret> is hit
(global-set-key (kbd "<RET>") 'electric-indent-just-newline)

(defun set-frame-width-interactive (arg)
  (interactive "p")
  (set-frame-width (selected-frame) arg))

;; frame- or window-resizing function
;; from http://dse.livejournal.com/67732.html. Resizes either frame or window
;; to 80 columns. If the window can be sized to 80 columns wide, without
;; resizing the frame itself, it will resize the window. Otherwise, it will
;; resize the frame. You can use a prefix argument to specify a
;; different column width
(defun fix-frame-horizontal-size (width)
  "Set the frame's size to 80 (or prefix arg WIDTH) columns wide."
  (interactive "P")
  (if window-system
	  (set-frame-width (selected-frame) (or width 80))
	(error "Cannot resize frame horizontally: is a text terminal")))

(defun fix-window-horizontal-size (width)
  "Set the window's size to 80 (or prefix arg WIDTH) columns wide."
  (interactive "P")
  (enlarge-window (- (or width 80) (window-width)) 'horizontal))

(defun fix-horizontal-size (width)
  "Set the window's or frame's width to 80 (or prefix arg WIDTH)."
  (interactive "P")
  (condition-case nil
	  (fix-window-horizontal-size width)
	(error
	 (condition-case nil
	 (fix-frame-horizontal-size width)
	   (error
	(error "Cannot resize window or frame horizontally"))))))

(global-set-key (kbd "C-x W") 'fix-horizontal-size)

(add-hook 'term-mode-hook
		  (lambda ()
			(setq show-trailing-whitespace nil)))

(require 'window-numbering)
;; highlight the window number in pink color
(custom-set-faces '(window-numbering-face ((t (:foreground "DeepPink" :underline "DeepPink" :weight bold)))))
(window-numbering-mode 1)

;;binding the key
(global-set-key "\M-?" 'etags-select-find-tag-at-point)
(global-set-key "\M-." 'etags-select-find-tag)

;; Auto refresh buffers when they change on disk and not in the buffer
(global-auto-revert-mode t)

;; Load dracula theme at startup
(add-to-list 'custom-theme-load-path "~/.emacs.d/elpa/dracula-theme-20170412.845")
(load-theme 'dracula t)

;; Replace BufferMenu to iBuffer
(global-set-key (kbd "C-x C-b") 'ibuffer)
(autoload 'ibuffer "ibuffer" "List buffers." t)

;; Turn on delete highlighted stuff
(delete-selection-mode t)

;; Helm Config
(require 'helm)
(require 'helm-config)

(global-set-key (kbd "M-x") 'helm-M-x)

(define-key global-map [remap find-file] 'helm-find-files)
(global-set-key (kbd "C-x C-b") 'helm-buffers-list)

(setq helm-split-window-in-side-p           t ; open helm buffer inside current window, not occupy whole other window
      helm-move-to-line-cycle-in-source     t ; move to end or beginning of source when reaching top or bottom of source.
      helm-ff-search-library-in-sexp        t ; search for library in `require' and `declare-function' sexp.
      helm-scroll-amount                    8 ; scroll 8 lines other window using M-<next>/M-<prior>
      helm-ff-file-name-history-use-recentf t)

(define-key helm-map (kbd "<tab>") 'helm-execute-persistent-action) ; rebind tab to run persistent action ie. make tab completion work


(setq helm-autoresize-max-height 0)
(setq helm-autoresize-min-height 20)
(helm-autoresize-mode 1)

(helm-mode 1)

;; Turn nyan-cat mode on
(nyan-mode 1)
