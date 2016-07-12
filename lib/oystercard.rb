class Oystercard

  MAX_LIMIT = 90
  MIN_FARE = 1
  DEFAULT_TOPUP = 10
  attr_reader :balance, :in_journey, :entry_station, :exit_station
  attr_accessor :journeys

  def initialize
    @balance = DEFAULT_TOPUP
    @journeys = {}
  end

  def top_up(amount)
    fail "Over the limit!" if exceeds_limit?(amount)
    @balance = amount + @balance
  end

  def touch_in(entry_station)
    fail "Insufficient founds!" if no_founds?
    @entry_station = entry_station
  end

  def touch_out(exit_station)
    deduct(MIN_FARE)
    @exit_station = exit_station
    save_journey
  end

  def in_journey?
    @entry_station != nil
  end

  private

  def exceeds_limit?(amount)
    @balance + amount > MAX_LIMIT
  end

  def no_founds?
    @balance < MIN_FARE
  end

  def deduct(amount)
    @balance = @balance - amount
  end

  def save_journey
    @journeys = [@entry_station => @exit_station]
    @entry_station = nil
  end

end
