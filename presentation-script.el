(require 'demo-it)

;; (erase-buffer)
;; demo-it-insert !! types onto a buffer
;; (text-scale-set (demo-it--get-text-scale size))
;; make centered-window center out even when split into too (I guess, change the minimum window width threshold)

(setq demo-it--shell-or-eshell :shell)
(setq demo-it--insert-text-speed :faster)
(setq demo-it--keymap-mode-style :advanced-mode)
(setq demo-it--open-windows-size 100)

(defun rubyconf/show-image-slide (image-file)
  (centered-window-mode -1)
  (eimp-mode +1)
  (find-file image-file)
  (delete-other-windows)
  (fringe-mode '(0 . 0))
  (demo-it-hide-mode-line)
  (eimp-fit-image-to-whole-window)
  (eimp-mode -1)
  )

(defun rubyconf/show-source-code-file (source-code-file)
  (centered-window-mode +1)
  (find-file source-code-file)
  (demo-it-highlight-dwim :line 1 2)
  (fancy-widen)
  (goto-char (point-max))
  (delete-other-windows)
  )

(defun rubyconf/show-source-code-file-and-narrow (source-code-file line-start line-end)
  (rubyconf/show-source-code-file source-code-file)
  (demo-it-highlight-dwim :line line-start line-end)
)

(defun rubyconf/setup-shell()
  (demo-it-start-shell)
  (demo-it-run-in-shell "/bin/bash --login" nil :instant)
  (sit-for 3.5)
  (demo-it-run-in-shell "rvm 2.3" nil :instant)
  (demo-it-run-in-shell "PS1='$ '" nil :instant)
  (comint-clear-buffer)
  )

(defun rubyconf/run-shell()
  (demo-it-start-shell)
  (comint-clear-buffer)
  )

(defun rubyconf/run-file-in-opened-shell (interpreter source-code-file)
  (sit-for 0.1)
  (demo-it-run-in-shell (concat interpreter " " source-code-file))
  )

(defun rubyconf/run-file-in-shell (interpreter source-code-file)
  (rubyconf/run-shell)
  (rubyconf/run-file-in-opened-shell interpreter source-code-file)
  )

(defun rubyconf/run-file-with-mri (source-code-file)
  (rubyconf/run-file-in-shell "ruby" source-code-file)
)

(defun rubyconf/run-file-with-jruby (source-code-file)
  (rubyconf/run-file-in-shell "jruby" source-code-file)
)

(demo-it-create :single-window
                (rubyconf/setup-shell)
                (show-paren-mode -1)

                (rubyconf/show-image-slide "title.png")

                (rubyconf/show-image-slide "wedding-cake-ruby.png")

                (rubyconf/show-image-slide "team-veeqo.png")

                (rubyconf/show-source-code-file "bank-account-first-10-000.rb")
                (rubyconf/show-source-code-file "bank-account-first-10-000-repeat-100-times.rb")
                (rubyconf/show-source-code-file "0-add-check-in-the-end.rb")
                (demo-it-highlight-dwim :line 6 11)
                (rubyconf/show-source-code-file-and-narrow "simplest-race-condition.rb" 6 11)
                (rubyconf/show-source-code-file "simplest-race-condition.rb")
                (rubyconf/run-file-with-jruby "simplest-race-condition.rb")

                (rubyconf/show-source-code-file "0-3-single-thread-body.rb")
                (rubyconf/show-source-code-file "0-4-expand-thread-body.rb")
                (split-window-horizontally)
                (find-file-other-window "0-4-expand-thread-body.rb")

                (rubyconf/show-source-code-file "1-0-gil-seemingly-protects-you.rb")
                (rubyconf/run-file-with-mri "1-0-gil-seemingly-protects-you.rb")
                (rubyconf/show-source-code-file "1-1-innocent-refactoring.rb")
                (rubyconf/run-file-with-mri "1-1-innocent-refactoring.rb")

                (rubyconf/show-source-code-file "4-0-only-one-core.rb")
                (rubyconf/run-file-with-mri "4-0-only-one-core.rb")
                (demo-it-run-in-shell "sudo ./turn-off-all-but-one-cores")
                (demo-it-run-in-shell "nproc")
                (rubyconf/run-file-in-opened-shell "ruby" "4-0-only-one-core.rb")
                (demo-it-run-in-shell "sudo ./turn-on-all-cores && nproc")

                (rubyconf/show-image-slide "parallelism-is-not-concurrency.png")

                (rubyconf/show-image-slide "two-threads.png")
                (rubyconf/show-image-slide "serial-threads.png")
                (rubyconf/show-image-slide "serial-threads-this-is-not-the-case.png")
                (rubyconf/show-image-slide "concurrent-and-parallel.png")
                (rubyconf/show-image-slide "concurrent-but-not-parallel.png")

                (rubyconf/show-image-slide "the-moment-where-mri-switched-between-threads.png")
                (rubyconf/show-source-code-file "4-4-switching-context-at-method-boundary.rb")

                (rubyconf/show-source-code-file "5-0-gil-protects-pushing-to-array.rb")
                (rubyconf/run-file-with-mri "5-0-gil-protects-pushing-to-array.rb")
                (rubyconf/run-file-in-opened-shell "jruby" "5-0-gil-protects-pushing-to-array.rb")
                (rubyconf/show-image-slide "gil-is-here-not-for-your-convenience.png")
                (rubyconf/show-source-code-file "6-0-populating-array-in-order.rb")
                (rubyconf/run-file-with-mri "6-0-populating-array-in-order.rb")

                (rubyconf/show-image-slide "veeqo-integrations.png")
                (rubyconf/show-image-slide "sidekiq-to-shopify-api.png")
                (rubyconf/show-image-slide "sidekiq-shopify_api-activeresource-shopify-api.png")
                (rubyconf/show-image-slide "orders-correct.png")
                (rubyconf/show-image-slide "orders-messed-up.png")
                (rubyconf/show-image-slide "grapes-and-olives.png")

                (rubyconf/show-source-code-file "7-0-unpredictable-context-switching.rb")
                (rubyconf/run-file-with-mri "7-0-unpredictable-context-switching.rb")
                (rubyconf/show-source-code-file "7-0-unpredictable-context-switching.rb")
                (rubyconf/show-source-code-file "7-1-unpredictable-context-switching-if-true.rb")
                (rubyconf/run-file-with-mri "7-1-unpredictable-context-switching-if-true.rb")
                (rubyconf/show-source-code-file "7-1-unpredictable-context-switching-if-true.rb")
                (rubyconf/show-source-code-file "7-2-unpredictable-context-switching-unless-false.rb")
                (rubyconf/run-file-with-mri "7-2-unpredictable-context-switching-unless-false.rb")
                (demo-it-run-in-shell "ruby --version")
                (demo-it-run-in-shell "rvm 2.4")
                (rubyconf/run-file-in-opened-shell "ruby" "7-2-unpredictable-context-switching-unless-false.rb")
                (rubyconf/show-image-slide "turning-commit.png")
                (rubyconf/show-source-code-file "7-2-unpredictable-context-switching-unless-false.rb")
                (rubyconf/show-source-code-file "7-3-ruby-2-4-pretend-to-calculate-false.rb")
                (rubyconf/run-file-with-mri "7-3-ruby-2-4-pretend-to-calculate-false.rb")

                (rubyconf/show-image-slide "so-what-should-you-do.png")
                (rubyconf/show-image-slide "there-will-never-be-a-magic-bullet.png")

                (rubyconf/show-image-slide "only-mri-has-gil-not-jruby-not-rubinius.png")
                (rubyconf/show-image-slide "gil-does-not-save-you-from-race-conditions.png")
                (rubyconf/show-image-slide "parallelism-is-not-concurrency.png")
                (rubyconf/show-image-slide "gil-is-here-not-for-your-convenience.png")
                (rubyconf/show-image-slide "assume-context-can-be-switched-at-any-line.png")
                (rubyconf/show-image-slide "guilds-wont-help-on-their-own.png")

                (rubyconf/show-image-slide "tl-dr.png")

                (rubyconf/show-image-slide "title.png")
                )

(demo-it-start)
