class Oystercard

  attr_reader :balance, :journey, :journeys

  DEFAULT_LIMIT = 90.00
  MINIMUM_BALANCE = 1.00
  FARE = 1.00

  def initialize
    @balance = 0.00
    @journey = {}
    @journeys = []
  end

  def top_up(money)
    fail "Top up amount pushes you over your maximum oyster card limit of £#{DEFAULT_LIMIT}. Your current balance is £#{@balance}" if limit_reached?(money)
    @balance += money
  end

  def in_journey?
    !!@entry_station
  end

  def touch_in(station)
    fail "Please top up, not enough credit" if not_enough_credit?
    @entry_station = station
    @journey[:entry] = station
  end

  def touch_out(station)
    @journey[:exit] = station
    @journeys << @journey
    deduct
  end



private

  def not_enough_credit?
    @balance < MINIMUM_BALANCE
  end

  def limit_reached?(money)
    @balance + money > DEFAULT_LIMIT
  end

  def deduct
    @balance -= FARE
  end
end
