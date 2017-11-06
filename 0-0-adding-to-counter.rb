@bank_account = 0

10_000.times do
  value = @bank_account
  value = value + 1
  @bank_account = value
end
