; -*-emacs-lisp-*-

;;
;; My .emacs:
;; Geronimo Orozco <gorozco@gmail.com>
;;

;; Modified and Composed from:
;; 
;; Geronimo Orozco <gorozco@gmail.com>
;; Gunnar Wolf <gwolf@gwolf.org>
;; Alvaro Lopez <alvaro@gnu.org>
;; K. Arun <kar@myrealbox.com>
;; Chema Celorio <chema@celorio.com>
;; Miguel de Icaza <miguel@helixcode.com>
;; Mattias Nyrell 199911

;; ..

;; My info
;;
;;
;; Note for emacs 23:
;; $ mkdir -p ~/.emacs.d/elpa/
;; $ cd ~/.emacs.d/elpa/
;; Go to: http://marmalade-repo.org/ and download package.el 
;; Uncomment following line
;; 
;; Color theme
(global-linum-mode t)
(add-to-list 'load-path "~/.emacs.d/themes/")
(add-to-list 'load-path "~/.emacs.d/elpa/")
(require 'package)
(add-to-list 'package-archives '("elpa" . "http://tromey.com/elpa/"))
(add-to-list 'package-archives '("marmelade" . "http://marmalade-repo.org/packages/"))
(package-initialize)
;; source: http://steve.yegge.googlepages.com/my-dot-emacs-file
(defun rename-file-and-buffer (new-name)
  "Renames both current buffer and file it's visiting to NEW-NAME."
  (interactive "sNew name: ")
  (let ((name (buffer-name))
        (filename (buffer-file-name)))
    (if (not filename)
        (message "Buffer '%s' is not visiting a file!" name)
      (if (get-buffer new-name)
          (message "A buffer named '%s' already exists!" new-name)
        (progn
          (rename-file name new-name 1)
          (rename-buffer new-name)
          (set-visited-file-name new-name)
          (set-buffer-modified-p nil))))))

(setq user-full-name "Geronimo Orozco")
(setq user-mail-address "geronimo.orozco@intel.com")

;;
;; Autoload markdown mode
(add-to-list 'auto-mode-alist '("\\.md\\'" . markdown-mode))

;;
;; Autoload puppet mode
(add-to-list 'auto-mode-alist '("\\.pp\\'" . puppet-mode))

;; Set the short-cut keys
;;
(define-key global-map [f1]  (lambda () 
						  (interactive) 
												  (manual-entry (current-word))))  ;; Help
(define-key global-map [f2]  'gdb)
(define-key global-map [f3]  'kill-buffer-fast)                  ;; Close
(define-key global-map [f4]  'goto-line)                         ;; Goto line
(define-key global-map [f5]  'other-window)
(define-key global-map [f7]  'replace-string)                    ;; Replace
(define-key global-map [f9]  'undo)                              ;; Undo
(define-key global-map [f10] 'compile)                           ;; Compile
(define-key global-map [f11] 'next-error)                        ;; Error
(define-key global-map [f12] 'add-change-log-entry-other-window) ;; Changelog

;; Fix 'home' and 'end' keys
;;
( global-set-key [home] 'beginning-of-line)
( global-set-key [end] 'end-of-line)

;; Set Meta +  P to next error
;;
( global-set-key "\M-p" 'next-error) 

;; yes -> y, no -> n
;;
(fset 'yes-or-no-p 'y-or-n-p)

;; Make control+pageup/down scroll the other buffer
;;
(global-set-key [C-next]  'scroll-other-window)
(global-set-key [C-prior] 'scroll-other-window-down)

;; Dont show the GNU splash screen
;;
(setq inhibit-startup-message t)

;; Make all "yes or no" prompts show "y or n" instead
;;
(fset 'yes-or-no-p 'y-or-n-p)

;; Paste at point NOT at cursor
;;
; (setq mouse-yank-at-point 't)

;; Open unidentified files in text mode
;;
(setq default-major-mode 'text-mode)

;; Windows-like selection
;; 
; (pc-selection-mode)

;; Automagically read compressed files
;;
(auto-compression-mode 1)

;; Display clock 
;;
(display-time)

;; Auto fill in all major modes
;;
;; (setq-default auto-fill-function 'do-auto-fill) 

;; Compile command line to use :
;;
(setq compile-command "make CFLAGS=\"-O0 -g3 -Wall\" -j3")

;; over the filesystem.
;;
(defun make-backup-file-name (file-name)
  "Create the non-numeric backup file name for `file-name'."
  (require 'dired)
  (if (file-exists-p "~/.backups")
      (concat (expand-file-name "~/.backups/")
                  (dired-replace-in-string "/" "|" file-name))
    (concat file-name "~")))

;; tab, colour, and misc options
;;

(custom-set-variables
 '(compilation-window-height 6 t)
 '(c-default-style "K&R")
 '(line-number-mode t)
 '(font-lock-maximum-decoration t)
 '(c-progress-interval 8)
 '(auto-revert-stop-on-user-input nil)
 '(compilation-scroll-output t)
 '(tab-width 5)
 '(compilation-ask-about-save nil t)
 '(c-basic-offset 8)
 '(c-tab-always-indent (quote other))
 '(font-lock-support-mode (quote jit-lock-mode))
 '(delete-old-versions t)
 '(standard-indent 8)
 '(auto-revert-interval 2)
 '(column-number-mode t)
 '(indent-tabs-mode t)
 '(next-line-add-newlines nil)
 '(global-font-lock-mode t nil (font-lock))
 '(global-auto-revert-mode t nil (autorevert))
 '(font-lock-global-modes t)
 '(gdb-many-windows t)
)

;; disable line split
(setq fill-column nil)

;; disable any noice
;;
(setq bell-volume 0)
(setq visible-bell t)

;; hide the menu bar
;;
(menu-bar-mode nil)
(tool-bar-mode nil)
(setq menubar-visible-p nil)
(setq default-toolbar-visible-p nil)

;; hide the scroll bar
;;
;; (scroll-bar-mode -1)

;; Useful function:
;; convert dos (^M) end of line to unix end of line
(defun dos2unix()
  (interactive)
  (goto-char(point-min))
  (while (search-forward "\r" nil t) (replace-match "")))

;; Useful function:
;; unix2dos
(defun unix2dos()
  (interactive)
  (goto-char(point-min))
  (while (search-forward "\n" nil t) (replace-match "\r\n")))

;; Useful function:
;; Insert date into buffer
(defun insert-date ()
  "Insert date at point."
  (interactive)
  (insert (format-time-string "%A, %B %e, %Y %k:%M:%S %z")))

;; Useful function:
;; Compute the length of the marked region 
(defun region-length ()
  "length of a region"
  (interactive)
  (message (format "%d" (- (region-end) (region-beginning)))))

;; Active the mouse wheel:
;; Add scrolling with mouse
;; (mouse-wheel-mode)
(global-set-key   [mouse-4] '(lambda () (interactive) (scroll-down 5)))
(global-set-key   [mouse-5] '(lambda () (interactive) (scroll-up   5)))
(global-set-key [S-mouse-4] '(lambda () (interactive) (scroll-down 1)))
(global-set-key [S-mouse-5] '(lambda () (interactive) (scroll-up   1)))
(global-set-key [C-mouse-5] '(lambda () (interactive) (scroll-up   (/ (window-height) 2))))
(global-set-key [C-mouse-4] '(lambda () (interactive) (scroll-down (/ (window-height) 2))))

;; Carbon Emacs: OS X
;;
(when (featurep 'mac-carbon)
  ;; Look and Feel 
  (setq default-frame-alist '(
    (cursor-color . "red")
    (cursor-type . box)
    (foreground-color . "lightcyan")
    (background-color . "#001125")
    (font . "-*-Courier-medium-*-*--12-*")
  ))

 ;; Spell program
 (setq ispell-really-aspell t)
 (setq ispell-program-name "/usr/local/bin/aspell")
 (setq ispell-extra-args '("-d" "/Library/Application Support/cocoAspell/aspell6-en-6.0-0/en.multi"))
 (setenv "ASPELL_CONF" nil)

 ;; Mouse
 (setq mac-emulate-three-button-mouse nil)
 (global-set-key [wheel-up]'(lambda ()(interactive)(scroll-down 2)))
 (global-set-key [wheel-down]'(lambda ()(interactive)(scroll-up 2)))
 (setq mouse-wheel-scroll-amount '(2.1))
)

(setq w32-pass-lwindow-to-system 'control)
(setq w32-lwindow-modifier 'control)

;(autoload 'nuke-trailing-whitespace "nuke-trailing-whitespace" nil t)
;(add-hook 'mail-send-hook 'nuke-trailing-whitespace)
;(add-hook 'write-file-hooks 'nuke-trailing-whitespace)

;; Prevent flyspell from finding mistakes in the code.
;; From Jim Meyering.
(add-hook 'c-mode-hook          'flyspell-prog-mode 1)
(add-hook 'c++-mode-hook        'flyspell-prog-mode 1)
(add-hook 'cperl-mode-hook      'flyspell-prog-mode 1)
(add-hook 'autoconf-mode-hook   'flyspell-prog-mode 1)
(add-hook 'autotest-mode-hook   'flyspell-prog-mode 1)
(add-hook 'sh-mode-hook         'flyspell-prog-mode 1)
(add-hook 'makefile-mode-hook   'flyspell-prog-mode 1)
(add-hook 'emacs-lisp-mode-hook 'flyspell-prog-mode 1)
(require 'term)
(defun visit-ansi-term ()
  "If the current buffer is:
     1) a running ansi-term named *ansi-term*, rename it.
     2) a stopped ansi-term, kill it and create a new one.
     3) a non ansi-term, go to an already running ansi-term
        or start a new one while killing a defunt one"
  (interactive)
  (let ((is-term (string= "term-mode" major-mode))
        (is-running (term-check-proc (buffer-name)))
        (term-cmd "/bin/bash")
        (anon-term (get-buffer "*ansi-term*")))
    (if is-term
        (if is-running
            (if (string= "*ansi-term*" (buffer-name))
                (call-interactively 'rename-buffer)
              (if anon-term
                  (switch-to-buffer "*ansi-term*")
                (ansi-term term-cmd)))
          (kill-buffer (buffer-name))
          (ansi-term term-cmd))
      (if anon-term
          (if (term-check-proc "*ansi-term*")
              (switch-to-buffer "*ansi-term*")
            (kill-buffer "*ansi-term*")
            (ansi-term term-cmd))
        (ansi-term term-cmd)))))
(global-set-key (kbd "<f2>") 'visit-ansi-term)

;; http://hugoheden.wordpress.com/2009/03/08/copypaste-with-emacs-in-terminal/
;; I prefer using the "clipboard" selection (the one the
;; typically is used by c-c/c-v) before the primary selection
;; (that uses mouse-select/middle-button-click)
(setq x-select-enable-clipboard t)

;; If emacs is run in a terminal, the clipboard- functions have no
;; effect. Instead, we use of xsel, see
;; http://www.vergenet.net/~conrad/software/xsel/ -- "a command-line
;; program for getting and setting the contents of the X selection"
(unless window-system
 (when (getenv "DISPLAY")
  ;; Callback for when user cuts
  (defun xsel-cut-function (text &optional push)
    ;; Insert text to temp-buffer, and "send" content to xsel stdin
    (with-temp-buffer
      (insert text)
      ;; I prefer using the "clipboard" selection (the one the
      ;; typically is used by c-c/c-v) before the primary selection
      ;; (that uses mouse-select/middle-button-click)
      (call-process-region (point-min) (point-max) "xsel" nil 0 nil "--clipboard" "--input")))
  ;; Call back for when user pastes
  (defun xsel-paste-function()
    ;; Find out what is current selection by xsel. If it is different
    ;; from the top of the kill-ring (car kill-ring), then return
    ;; it. Else, nil is returned, so whatever is in the top of the
    ;; kill-ring will be used.
    (let ((xsel-output (shell-command-to-string "xsel --clipboard --output")))
      (unless (string= (car kill-ring) xsel-output)
	   xsel-output )))
  ;; Attach callbacks to hooks
  (setq interprogram-cut-function 'xsel-cut-function)
  (setq interprogram-paste-function 'xsel-paste-function)
  ;; Idea from
  ;; http://shreevatsa.wordpress.com/2006/10/22/emacs-copypaste-and-x/
  ;; http://www.mail-archive.com/help-gnu-emacs@gnu.org/msg03577.html
 ))
