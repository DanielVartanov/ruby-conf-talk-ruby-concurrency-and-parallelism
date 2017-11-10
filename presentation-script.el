(require 'demo-it)

(centered-window-mode t) ;; Install Emacs 25!!!

(defvar zenburn-override-colors-alist
  '(("zenburn-bg+05" . "#282828")
    ("zenburn-bg+1"  . "#2F2F2F")
    ("zenburn-bg+2"  . "#3F3F3F")
    ("zenburn-bg+3"  . "#4F4F4F")))

(load-theme 'zenburn t)

(setq demo-it--shell-or-eshell :shell)
(setq demo-it--insert-text-speed :faster)
(setq demo-it--keymap-mode-style :advanced-mode)
(setq demo-it--open-windows-size 120)

(demo-it-start-shell)

(defun rubyconf-setup()
  (demo-it-run-in-shell "/bin/bash --login")
  (demo-it-run-in-shell "PS1='$ '")
  )

(defun rubyconf-1-1-innocent-refactoring ()
  (demo-it-run-in-shell "ruby 1-1-innocent-refactoring.rb")
  )

(defun rubyconf-teardown ()
  ;; (demo-it-run-in-shell "exit" nil :instant)
)

(demo-it-create :single-window
 rubyconf-setup
 (find-file "4-2-concurrent-but-not-parallel.png")
 (find-file "1-1-innocent-refactoring.rb")
 rubyconf-1-1-innocent-refactoring
 rubyconf-teardown
)

(demo-it-start)
