class Oystercard

  BALANCE_LIMIT = 90
  MIN_FARE = 1
  attr_reader :balance, :station, :journeys

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
    self.station = entry_station
    self.entry_station = entry_station
  end

  def touch_out(exit_station)
    deduct(MIN_FARE)
    self.exit_station = exit_station
    save_journey
  end

  def in_journey?
    self.station != nil
  end

  def save_journey
    self.journeys << {:entry_station => entry_station, :exit_station => exit_station}
    self.station = nil
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

end
