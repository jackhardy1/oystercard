class Oystercard
attr_reader :balance
MAXIMUM_LIMIT = 90

  def initialize
    @balance = 0
  end

  def top_up(amount)
    fail "The maximum limit is 90" if amount + @balance > MAXIMUM_LIMIT
    @balance += amount
  end
end
