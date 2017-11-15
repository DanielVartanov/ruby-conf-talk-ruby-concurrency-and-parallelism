# Inspired by https://gist.github.com/headius/5783237

@array = []

100.times.map do
  Thread.new do
    10_000.times do |index|
      @array.push index
    end
  end
end.each(&:join)

puts 'array size is ' + (@array.size == 1_000_000 ? "\e[32m CORRECT \e[0m" : "\e[31m ERROR \e[0m")

# Also check contents!

expected = (0..10_000).to_a * 100

contents_correct = 1_000_000.times.all? do |i|
  @array[i] == expected[i]
end

puts 'array contents are ' + (contents_correct ? "\e[32m CORRECT \e[0m" : "\e[31m WRONG \e[0m")
