class Oystercard
attr_reader :balance, :entry_station, :journey_history, :exit_station
MAXIMUM_LIMIT = 90
MINIMUM_BALANCE = 1
MINIMUM_FARE = 1

  def initialize
    @balance = 0
    @entry_station = nil
    @exit_station = []
    @journey_history = {}

  end

  def top_up(amount)
    fail "The maximum limit is #{MAXIMUM_LIMIT}" if amount + @balance > MAXIMUM_LIMIT
    @balance += amount
  end

  def in_journey?
    !!@entry_station #anything but nil or false is 'true'
  end

  def touch_in(station)
    fail "Insufficient funds" if @balance < MINIMUM_BALANCE
    @entry_station = station
  end

  def touch_out(station)
    deduct(MINIMUM_FARE)
    @exit_station = station
    @journey_history.store(@entry_station,@exit_station)
    @entry_station = nil
  end

  private
  def deduct(amount)
    @balance -= amount
  end
end
