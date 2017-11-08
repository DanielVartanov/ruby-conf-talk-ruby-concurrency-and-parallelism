@bank_account = 0

100.times.map do
  Thread.new do
    100_000.times do
      value = @bank_account
      value = value + 1 unless false
      @bank_account = value
    end
  end
end.each(&:join)

puts @bank_account
puts (@bank_account == 10_000_000) ? 'CORRECT' : 'ERROR'
