@array = []

100.times.map do
  Thread.new do
    10_000.times do |i|
      @array.push(i)
    end
  end
end.each(&:join)

puts @array.size
puts (@array.size == 1_000_000) ? 'CORRECT' : 'ERROR'
