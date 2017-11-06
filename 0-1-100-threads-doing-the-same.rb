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
