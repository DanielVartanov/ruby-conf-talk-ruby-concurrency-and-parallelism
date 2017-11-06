@bank_account = 0

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
      value = value + 1
      write value # <-- context switching
    end
  end
end.each(&:join)

puts @bank_account
puts (@bank_account == 1_000_000) ? 'CORRECT' : 'ERROR'
