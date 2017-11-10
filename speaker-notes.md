### 0-0-title.png
I've been developing in Ruby for almost 10 years, my overall programming experience is even more, but for the majority of this time I didn't know how exactly multi-threading in Ruby MRI works. The same goes for many experienced developers I've been talking to. That's why I decided to do this talk :-)

### 0-0-first-10_000.rb
### 0-1-100-threads-doing-the-same.rb
### 0-2-add-check-in-the-end.rb
### 0-3-single-thread-body.rb
This single line is the reason for the whole weirdness

### 0-4-expand-thread-body.rb
### 1-0-gil-seemingly-protects-you.rb
So back to our example when a hundred threads are adding to a bank account 10 thousand times each

### 1-1-innocent-refactoring.rb
Refactoring by definition is change the code in a way that it does not change externally observable behaviour of that code

### 2-0-veeqo-is-multi-channel-order-management.png
### 2-1-sidekiq-and-shopify.png
### 2-2-shopify-api-active-support.png
### 2-3-messed-up-orders.png
### 2-4-grapes-and-olives.png
### 3-0-the-phrase-is-misleading.png
### 3-1-two-threads.png
### 3-2-two-threads-serially.png
### 3-3-two-threads-serially-slider.png
### 4-0-only-one-core.rb
### 4-1-parallelism-vs-concurrency.png
### 4-2-concurrent-but-not-parallel.png
### 4-2-context-switching.png
### 4-3-concurrent-and-parallel.png
### 4-4-switching-context-at-method-boundary.rb
then context gets switches
and then they save the same valye incrementing the bank account only once instead of twice
now imagine a hundred threads do the same

### 5-0-gil-protects-pushing-to-array.rb
so, basically saying, GIL protected the code of MRI developers, not your code
To illustrate that...

### 6-0-populating-array-in-order.rb
Never rely on GIL. Just never.
Except for built-in functions, of course.

you may think that okay, there is a method call and context switching is happening there
so if you write code delinerately avoiding method calls, your code will be threadsafe

### 7-0-unpredictable-context-switching.rb
Because there is a context switching on else branch of an if-statement

Specific points at which Ruby switches context are undocumented internals of the interpreter
You should never rely on them
Slide: the only safe way is to *assume context can be switched at any line* (~of your ruby code~)
Points of context switching can be switched at any future version of Ruby and you will never read it from release notes, because, again, it is undocumented internals of Ruby interpreter
must show versions as they will show it to their mates
2.4, def ... false; # Aaaaand *it's failed*
There are 3000 commits in Ruby MRI itself


### 7-1-ruby-2-4-unreachable-code.png
### 8-0-tl-dr.png
