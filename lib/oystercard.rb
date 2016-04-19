#Test for day two
class Oystercard
  attr_reader :balance, :in_journey
  MAX_LIMIT = 90

  def initialize
    @balance = 0
    @in_journey
  end

  def touch_in
    @in_journey = true
  end

  def top_up(num)
    fail "Limit of #{MAX_LIMIT} has been reached" if num + @balance > MAX_LIMIT
    @balance += num
  end

  def deduct(num)
    @balance -= num
  end

end
