@array = []

100.times.map do
  Thread.new do
    100_000.times do |index|
      @array.push index
    end
  end
end.each(&:join)

print @array.size
puts @array.size == 10_000_000 ?
       "\e[32m CORRECT \e[0m" :
       "\e[31m ERROR \e[0m"
