#Test for day two
class Oystercard
  attr_reader :balance, :entry_station, :journey_history
  MAX_LIMIT = 90
  MIN_FARE = 1

  def initialize
    @balance = 0
    @entry_station = nil
    @journey_history = {}
  end

  def touch_in(entry_station)
    fail "insufficient balance" if @balance < MIN_FARE
    @entry_station = entry_station
  end

  def touch_out(exit_station)
    deduct(MIN_FARE)
    @entry_station = nil
  end

  def in_journey?
    !!@entry_station
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
