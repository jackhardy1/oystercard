#Test for day two
class Oystercard
  attr_reader :balance, :in_journey, :entry_station
  MAX_LIMIT = 90
  MIN_FARE = 1

  def initialize
    @balance = 0
    @in_journey = false
    @entry_station = nil
  end

  def touch_in(entry_station)
    fail "insufficient balance" if @balance < MIN_FARE
    @entry_station = entry_station
    @in_journey = true
  end

  def touch_out
    @in_journey = false
    deduct(MIN_FARE)
  end

  def in_journey?
    @in_journey
  end

  def top_up(num)
    fail "Limit of #{MAX_LIMIT} has been reached" if num + @balance > MAX_LIMIT
    @balance += num
  end

  private
  def deduct(num)
    @balance -= num
  end

end
