# Inspired by https://gist.github.com/headius/5783237

@array = []

100.times.map do
  Thread.new do
    10_000.times do |index|
      @array.push index
    end
  end
end.each(&:join)

expected = (0..10_000).to_a * 100

contents_correct = 1_000_000.times.all? do |i|
  @array[i] == expected[i]
end

puts 'array size is ' + (@array.size == 1_000_000 ? 'CORRECT' : 'WRONG')
puts 'array contents are ' + (contents_correct ? 'CORRECT' : 'WRONG')  # <-- Also check contents!

# Never rely on GIL. Just never.

# you may think that okay, there is a method call and context switching is happening there
# so if you write code delinerately avoiding method calls, your code will be threadsafe
