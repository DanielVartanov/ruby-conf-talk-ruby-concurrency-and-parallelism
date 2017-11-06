@array = []

100.times.map do
  Thread.new do
    1000.times do
      @array.push(0)
    end
  end
end.each(&:join)

puts @array.size
puts (@array.size == 100_000) ? 'CORRECT' : 'ERROR'
