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
      value = read_from_bank_account() # Extracted to a method
      value = value + 1
      write_to_bank_account(value) # Extracted to a method
    end
  end
end.each(&:join)

puts @bank_account
puts (@bank_account == 1_000_000) ? 'CORRECT' : 'ERROR'



# Refactoring by definition is change the code in a way that it does not change externally observable behaviour of that code
