class Oystercard
attr_reader :balance
MAXIMUM_LIMIT = 90
MINIMUM_BALANCE = 1
  def initialize
    @balance = 0
    @in_journey = false
  end

  def top_up(amount)
    fail "The maximum limit is 90" if amount + @balance > MAXIMUM_LIMIT
    @balance += amount
  end

  def deduct(amount)
    @balance -= amount
  end

  def in_journey?
    @in_journey
  end

  def touch_in
    fail "Insufficient funds" if @balance < MINIMUM_BALANCE
    @in_journey = true
  end

  def touch_out
    @in_journey = false
  end
end
