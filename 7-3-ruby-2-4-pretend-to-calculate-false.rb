@bank_account = 0

100.times.map do
  Thread.new do
    100_000.times do
      value = @bank_account
      bla = false
      value = value + 1 unless bla && false
      @bank_account = value
    end
  end
end.each(&:join)

print @bank_account
puts @bank_account == 10_000_000 ?
       "\e[32m CORRECT \e[0m" :
       "\e[31m ERROR \e[0m"
