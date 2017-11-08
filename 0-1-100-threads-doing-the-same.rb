@bank_account = 0

100.times.map do
  Thread.new do
    10_000.times do
      @bank_account += 1
    end
  end
end.each(&:join)
