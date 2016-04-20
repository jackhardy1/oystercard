require_relative 'oystercard.rb'

class Journey
  attr_reader :entry_station, :exit_station, :journey_history

  def initialize
    @entry_station = nil
    @exit_station = nil
    @journey_history = {}
  end

  def touch_in(entry_station)
    fail "insufficient balance" if @balance < MIN_FARE
    @entry_station = entry_station
  end

  def touch_out(exit_station)
    deduct(MIN_FARE)
    @exit_station = exit_station
    @journey_history.store(@entry_station, @exit_station)
    @entry_station = nil
  end

  def in_journey?
    !!@entry_station
  end
  
end
