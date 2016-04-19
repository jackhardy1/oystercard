#Test for day two
class Oystercard
  attr_reader :balance
  MAX_LIMIT = 90

  def initialize
    @balance = 0
  end

  def top_up(num)
    fail "Limit of #{MAX_LIMIT} has been reached" if num + @balance > MAX_LIMIT
    @balance += num
  end

  def deduct(num)
    @balance -= num
  end

end
