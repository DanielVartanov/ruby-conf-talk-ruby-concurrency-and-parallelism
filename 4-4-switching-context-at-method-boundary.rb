@bank_account = 0

#_from_bank_account

def read
  @bank_account
end

def write(value)
  @bank_account = value
end

100.times.map do
  Thread.new do
    10_000.times do
      value = read # <-- context switching
      # then context gets switches
      # and then they save the same valye incrementing the bank account only once instead of twice
      # now imagine a hundred threads do the same      value = value + 1
      write value # <-- context switching
    end
  end
end.each(&:join)

puts @bank_account
puts (@bank_account == 1_000_000) ? 'CORRECT' : 'ERROR'
