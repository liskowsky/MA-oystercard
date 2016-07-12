class Oystercard

  MAX_LIMIT = 90
  MIN_FARE = 1
  DEFAULT_TOPUP = 10
  attr_reader :balance, :in_journey, :entry_station

  def initialize(default = DEFAULT_TOPUP)
    @balance = default
  end

  def top_up(amount)
    fail "Oystercard's limit reached" if exceeds_limit?(amount)
    @balance = amount + @balance
  end

  def touch_in(entry_station)
    fail "Insufficient founds!" if no_founds?
    @entry_station = entry_station
  end

  def touch_out(amount = MIN_FARE)
    @entry_station = nil
    deduct(amount)
  end

  def in_journey?
    @entry_station
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

end
