class Oystercard

  MAX_LIMIT = 90
  MIN_FARE = 1
  DEFAULT_TOPUP = 10
  attr_reader :balance, :in_journey

  def initialize(default = DEFAULT_TOPUP)
    @balance = default
    @in_journey = false
  end

  def top_up(amount)
    fail "Oystercard's limit reached" if exceeds_limit?(amount)
    @balance = amount + @balance
  end

  def touch_in
    fail "Insufficient founds!" if no_founds?
    @in_journey = true
  end

  def touch_out(amount = MIN_FARE)
    @in_journey = false
    deduct(amount)
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
