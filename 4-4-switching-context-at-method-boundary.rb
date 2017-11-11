@bank_account = 0

def read_from_bank_account
  @bank_account
end

def write_to_bank_account(value)
  @bank_account = value
end

100.times.map do
  Thread.new do
    10_000.times do
      value = read_from_bank_account() # <-- method call
      value = value + 1
      write_to_bank_account(value) # <-- method call
    end
  end
end.each(&:join)

print @bank_account
puts (@bank_account == 1_000_000) ? "\e[32m CORRECT \e[0m" : "\e[31m ERROR \e[0m"
