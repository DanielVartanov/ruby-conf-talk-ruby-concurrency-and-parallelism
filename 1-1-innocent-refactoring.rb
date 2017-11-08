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
      value = read() # Extracted to a method
      value = value + 1
      write(value) # Extracted to a method
    end
  end
end.each(&:join)

puts @bank_account
puts (@bank_account == 1_000_000) ? 'CORRECT' : 'ERROR'
