class Oystercard
attr_reader :balance, :entry_station
MAXIMUM_LIMIT = 90
MINIMUM_BALANCE = 1
MINIMUM_FARE = 1

  def initialize
    @balance = 0
    @in_journey = false
    @entry_station = nil
  end

  def top_up(amount)
    fail "The maximum limit is #{MAXIMUM_LIMIT}" if amount + @balance > MAXIMUM_LIMIT
    @balance += amount
  end

  def in_journey?
    @in_journey
  end

  def touch_in(station)
    fail "Insufficient funds" if @balance < MINIMUM_BALANCE
    @entry_station = station
    @in_journey = true
  end

  def touch_out
    @in_journey = false
    deduct(MINIMUM_FARE)
  end

  private
  def deduct(amount)
    @balance -= amount
  end
end
