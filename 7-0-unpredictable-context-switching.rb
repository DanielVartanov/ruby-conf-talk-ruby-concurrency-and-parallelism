@bank_account = 0

1000.times.map do
  Thread.new do
    10_000.times do
      value = @bank_account
      value = value + 1
      @bank_account = value
    end
  end
end.each(&:join)

print @bank_account
puts @bank_account == 10_000_000 ?
       "\e[32m CORRECT \e[0m" :
       "\e[31m ERROR \e[0m"
