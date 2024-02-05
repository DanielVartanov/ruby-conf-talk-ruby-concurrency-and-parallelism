(require 'demo-it)

;; (erase-buffer)
;; demo-it-insert !! types onto a buffer

(setq demo-it--shell-or-eshell :shell)
(setq demo-it--insert-text-speed :faster)
(setq demo-it--keymap-mode-style :advanced-mode)
(setq demo-it--open-windows-size 100)

(defun rubyconf/show-image-slide (image-file)
  (centered-window-mode -1)
  (find-file image-file)
  (delete-other-windows)
  (fringe-mode '(10 . 10))
  (demo-it-hide-mode-line)
  (eimp-mode +1)
  (eimp-fit-image-to-whole-window)
  (eimp-mode -1)
  )

(defun rubyconf/show-source-code-file (source-code-file &optional scale)
  (unless scale (setq scale 5))

  (centered-window-mode +1)
  (eimp-mode -1)
  (find-file source-code-file)
  (demo-it-hide-mode-line)
  (demo-it-highlight-dwim :line 1 2)
  (fancy-widen)
  (text-scale-set scale)
  (goto-char (point-max))
  (delete-other-windows)
  (message "")
  )

(defun rubyconf/show-source-code-file-and-narrow (source-code-file line-start line-end)
  (rubyconf/show-source-code-file source-code-file)
  (demo-it-highlight-dwim :line line-start line-end)
)

(defun rubyconf/show-source-code-file-and-warn-on-narrow (source-code-file &optional scale)
  (rubyconf/show-source-code-file source-code-file scale)
  (message "narrow")
  )

(defun rubyconf/setup-shell()
  (demo-it-start-shell)
  (demo-it-run-in-shell "/bin/bash --login" nil :instant)
  (sit-for 3.5)
  (demo-it-run-in-shell "rvm 3.2" nil :instant)
  (demo-it-run-in-shell "PS1='$ '" nil :instant)
  (demo-it-run-in-shell "ruby --version" nil :instant)
  (demo-it-hide-mode-line)
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
  (demo-it-start-shell)
  (demo-it-run-in-shell "rvm jruby-9.1")
  (comint-clear-buffer)
  (sit-for 0.3)
  (comint-clear-buffer)
  (demo-it-run-in-shell (concat "jruby " source-code-file))
)

(demo-it-create :single-window
                (rubyconf/setup-shell)
                (show-paren-mode -1)

                ;; -- 1 Simplest race condition --
                (rubyconf/show-source-code-file "bank-account-first-10-000.rb")
                (rubyconf/show-source-code-file "bank-account-first-10-000-repeat-100-times.rb")
                (rubyconf/show-source-code-file-and-warn-on-narrow "0-add-check-in-the-end.rb")
                (demo-it-highlight-dwim :line 6 11)
                (rubyconf/show-source-code-file-and-narrow "simplest-race-condition.rb" 6 12)
                (rubyconf/show-source-code-file "simplest-race-condition.rb")
                (rubyconf/run-file-with-jruby "simplest-race-condition.rb")
                (rubyconf/show-source-code-file-and-narrow "simplest-race-condition.rb" 9 9)
                (rubyconf/show-source-code-file "0-3-single-thread-body.rb" 7)
                (rubyconf/show-source-code-file "0-4-expand-thread-body.rb" 7)
                (split-window-horizontally)
                (find-file-other-window "0-4-expand-thread-body.rb")

                ;; -- 2 GIL and innocent refactoring --
                (rubyconf/show-source-code-file "2-0-gil-seemingly-protects-you.rb" 5)
                (rubyconf/run-file-with-mri "2-0-gil-seemingly-protects-you.rb")
                (rubyconf/show-source-code-file-and-warn-on-narrow "2-1-innocent-refactoring.rb" 3)
                (demo-it-highlight-dwim :line 3 9)
                (demo-it-highlight-dwim :line 14 16)
                (rubyconf/run-file-with-mri "2-1-innocent-refactoring.rb")

                (rubyconf/show-image-slide "first-two-questions.png")

                ;; -- 3 Step aside: only one core --
                (rubyconf/show-source-code-file "3-0-only-one-core.rb" 3)
                (rubyconf/run-file-with-mri "3-0-only-one-core.rb")
                (demo-it-run-in-shell "sudo ./turn-off-all-but-one-cores")
                (demo-it-run-in-shell "nproc")
                (rubyconf/run-file-in-opened-shell "ruby" "3-0-only-one-core.rb")
                (demo-it-run-in-shell "sudo ./turn-on-all-cores && nproc")

                (rubyconf/show-image-slide "three-questions.png")

                ;; -- 4 Parallelism is not concurrency --
                (rubyconf/show-image-slide "4-0-parallelism-is-not-concurrency.png")
                (rubyconf/show-image-slide "two-threads.png")
                (rubyconf/show-image-slide "serial-threads.png")
                (rubyconf/show-image-slide "concurrent-and-parallel.png")
                (rubyconf/show-image-slide "concurrent-but-not-parallel.png")

                (rubyconf/show-image-slide "the-moment-where-mri-switched-between-threads.png")

                (rubyconf/show-image-slide "III-answer-given.png")
                (rubyconf/show-source-code-file-and-warn-on-narrow "4-1-switching-context-at-method-boundary.rb" 3)
                (demo-it-highlight-dwim :line 14 16)

                (rubyconf/show-image-slide "two-answers-given.png")

                ;; -- 5 GIL protects internal MRI data --
                (rubyconf/show-source-code-file-and-warn-on-narrow "5-0-gil-protects-pushing-to-array.rb")
                (demo-it-highlight-dwim :line 8 8)
                (rubyconf/run-file-with-mri "5-0-gil-protects-pushing-to-array.rb")
                (rubyconf/run-file-in-opened-shell "jruby" "5-0-gil-protects-pushing-to-array.rb")
                (rubyconf/show-image-slide "gil-is-here-not-for-your-convenience.png")
                (rubyconf/show-source-code-file-and-warn-on-narrow "5-1-populating-array-in-order.rb" 2)
                (demo-it-highlight-dwim :line 17 27)
                (rubyconf/run-file-with-mri "5-1-populating-array-in-order.rb")

                (rubyconf/show-image-slide "three-answers-given.png")

                ;; -- 6 Veeqo, Sidekiq and Shopify --
                (rubyconf/show-image-slide "veeqo-integrations.png")
                (rubyconf/show-image-slide "sidekiq-to-shopify-api.png")
                (rubyconf/show-image-slide "sidekiq-shopify_api-activeresource-shopify-api.png")
                (rubyconf/show-image-slide "orders-correct.png")
                (rubyconf/show-image-slide "orders-messed-up.png")
                (rubyconf/show-image-slide "grapes-and-olives.png")

                ;; -- 7 Unpredictable context switching --
                (rubyconf/show-source-code-file "7-0-unpredictable-context-switching.rb")
                (rubyconf/run-file-with-mri "7-0-unpredictable-context-switching.rb")
                (rubyconf/show-source-code-file "7-0-unpredictable-context-switching.rb")
                (demo-it-highlight-dwim :line 7 7)
                (rubyconf/show-source-code-file-and-narrow "7-1-unpredictable-context-switching-if-true.rb" 7 7)
                (rubyconf/run-file-with-mri "7-1-unpredictable-context-switching-if-true.rb")
                (rubyconf/show-source-code-file-and-narrow "7-1-unpredictable-context-switching-if-true.rb" 7 7)
                (rubyconf/show-source-code-file-and-narrow "7-2-unpredictable-context-switching-unless-false.rb" 7 7)
                (rubyconf/run-file-with-mri "7-2-unpredictable-context-switching-unless-false.rb")
                (demo-it-run-in-shell "ruby --version")
                (demo-it-run-in-shell "rvm 2.4")
                (rubyconf/run-file-in-opened-shell "ruby" "7-2-unpredictable-context-switching-unless-false.rb")
                (rubyconf/show-image-slide "turning-commit.png")
                (rubyconf/show-source-code-file-and-narrow "7-2-unpredictable-context-switching-unless-false.rb" 7 7)
                (rubyconf/show-source-code-file-and-narrow "7-3-ruby-2-4-pretend-to-calculate-false.rb" 7 8)
                (rubyconf/run-file-with-mri "7-3-ruby-2-4-pretend-to-calculate-false.rb")
                (rubyconf/show-image-slide "assume-context-can-be-switched-at-any-line.png")

                ;; -- 8 What should you do, Rails 4 and Guilds --
                (rubyconf/show-image-slide "8-0-so-what-should-you-do.png")
                (rubyconf/show-image-slide "guilds-wont-help-on-their-own.png")

                ;; -- 9 Take home slides
                (rubyconf/show-image-slide "only-mri-has-gil-not-jruby-not-rubinius.png")
                (rubyconf/show-image-slide "gil-does-not-save-you-from-race-conditions.png")
                (rubyconf/show-image-slide "4-0-parallelism-is-not-concurrency.png")
                (rubyconf/show-image-slide "gil-is-here-not-for-your-convenience.png")
                (rubyconf/show-image-slide "assume-context-can-be-switched-at-any-line.png")
                (rubyconf/show-image-slide "there-will-never-be-a-magic-bullet.png")

                ;; -- 10 TL;DR and end
                (rubyconf/show-image-slide "tl-dr.png")

                (rubyconf/show-image-slide "title.png")
                )

(demo-it-start)
