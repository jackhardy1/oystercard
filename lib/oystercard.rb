require_relative 'journey'

class Oystercard

  attr_reader :balance

  DEFAULT_LIMIT = 90

  def initialize
    @balance = 0.00
    @journeys = []
    @current_journey = nil
  end

  def top_up(money)
    fail top_up_fail_message if limit_reached?(money)
    @balance += money
  end

  def in_journey?
    !!@current_journey
  end

  def touch_in(station, journey_class = Journey)
    charge_and_log if in_journey?
    fail insufficient_funds if not_enough_credit? journey_class
    @current_journey = journey_class.new station
  end

  def touch_out(station, journey_class = Journey)
    @current_journey = journey_class.new unless in_journey?
    @current_journey.finish(station)
    charge_and_log
  end

private
  def not_enough_credit? journey_class = Journey
    @balance < journey_class::MIN_FARE
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

  def insufficient_funds
    "Please top up, not enough credit"
  end

  def charge_and_log
    @journeys << @current_journey
    deduct @current_journey
    @current_journey = nil
  end

end
