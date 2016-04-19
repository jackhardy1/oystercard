#Test for day two
class Oystercard
  attr_reader :balance, :in_journey
  MAX_LIMIT = 90
  MIN_FARE = 1

  def initialize
    @balance = 0
    @in_journey
  end

  def touch_in
    fail "insufficient balance" if @balance < MIN_FARE
    @in_journey = true
  end

  def touch_out
    @in_journey = false
  end

  def in_journey?
    @in_journey
  end

  def top_up(num)
    fail "Limit of #{MAX_LIMIT} has been reached" if num + @balance > MAX_LIMIT
    @balance += num
  end

  def deduct(num)
    @balance -= num
  end

end
