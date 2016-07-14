require_relative 'journey'

class Oystercard

  BALANCE_LIMIT = 90
  MIN_FARE = 1
  attr_reader :balance, :station, :journeys, :journey

  def initialize
    self.balance = 0
    self.journeys = []
  end

  def top_up(amount)
    raise "Over the limit!" if balance_exceeds_limit?(amount)
    self.balance += amount
  end

  def touch_in(entry_station)
    raise "Insufficient founds!" if no_founds?
    @journey = Journey.new(entry_station)
  end

  def touch_out(exit_station)
    journey.finish(exit_station)
    deduct(journey.fare)
    save_journey
  end

  private

  attr_accessor :entry_station, :exit_station
  attr_writer :balance, :station, :journeys

  def balance_exceeds_limit?(amount)
    balance + amount > BALANCE_LIMIT
  end

  def no_founds?
    balance < MIN_FARE
  end

  def deduct(amount)
    self.balance -= amount
  end

  def save_journey
    self.journeys << {entry_station: journey.entry_station, exit_station: journey.exit_station}
  end

end
