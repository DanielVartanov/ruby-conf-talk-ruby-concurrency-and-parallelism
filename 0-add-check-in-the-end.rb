


@bank_account = 0

100.times do
  10_000.times do
    @bank_account += 1
  end
end

print @bank_account
puts @bank_account == 1_000_000 ?
       "\e[32m CORRECT \e[0m" :
       "\e[31m ERROR \e[0m"
