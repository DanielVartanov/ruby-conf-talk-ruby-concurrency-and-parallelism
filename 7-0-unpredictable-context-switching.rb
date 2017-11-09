@bank_account = 0

def dummmy
  false
end

100.times.map do
  Thread.new do
    100_000.times do
      value = @bank_account
      value = value + 1 unless dummmy
      @bank_account = value
    end
  end
end.each(&:join)

puts @bank_account
puts (@bank_account == 10_000_000) ? 'CORRECT' : 'ERROR'

# Because there is a context switching on else branch of an if-statement

# Specific points at which Ruby switches context are undocumented internals of the interpreter
# You should never rely on them
# Slide: the only safe way is to *assume context can be switched at any line* (~of your ruby code~)
# Points of context switching can be switched at any future version of Ruby and you will never read it from release notes, because, again, it is undocumented internals of Ruby interpreter
### must show versions as they will show it to their mates
# 2.4, def ... false; # Aaaaand *it's failed*
# There are 3000 commits in Ruby MRI itself
