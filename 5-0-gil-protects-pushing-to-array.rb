#shwmae,pawb!dyma wy wystyr

@array = []

100.times.map do
  Thread.new do
    10_000.times do |index|
      @array.push index
    end
  end
end.each(&:join)

puts @array.size
puts (@array.size == 1_000_000) ? 'CORRECT' : 'ERROR'


# so, basically saying, GIL protected the code of MRI developers, not your code
# To illustrate that...
