@bank_account = 0

100.times.map do
  Thread.new do
    10_000.times do
      value = @bank_account
      value = value + 1
      @bank_account = value
    end
  end
end.each(&:join)

print @bank_account
puts (@bank_account == 1_000_000) ? ' CORRECT' : ' ERROR'


# So back to our example when a hundred threads are adding to a bank account 10 thousand times each
