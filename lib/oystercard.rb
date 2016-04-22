require_relative 'journey'

class Oystercard

  attr_reader :balance, :journeys

  DEFAULT_LIMIT = 90
  MINIMUM_BALANCE = 1
  FARE = 1

  def initialize
    @balance = 0.00
    @journeys = []
    @journey = nil
  end

  def top_up(money)
    fail top_up_fail_message if limit_reached?(money)
    @balance += money
  end

  def in_journey?
    !!@journey
  end

  def touch_in(station)
    charge_and_log if in_journey?
    fail "Please top up, not enough credit" if not_enough_credit?
    @journey = Journey.new station
  end

  def touch_out(station)
    @journey = Journey.new unless in_journey?
    @journey.finish(station)
    charge_and_log
  end

private
  def not_enough_credit?
    @balance < MINIMUM_BALANCE
  end

  def limit_reached?(money)
    @balance + money > DEFAULT_LIMIT
  end

  def deduct item
    @balance -= item.fare
  end

  def top_up_fail_message
    "Maximum limit of £#{DEFAULT_LIMIT} exceeded"
  end

  def charge_and_log
    @journeys << @journey.log
    deduct @journey
    @journey = nil
  end



end
