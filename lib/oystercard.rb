class Oystercard

  MAX_LIMIT = 90
  attr_reader :balance, :in_journey

  def initialize
    @balance = 0
    @in_journey = false
  end

  def top_up(amount)
    fail "Oystercard's limit reached" if exceeds_limit?(amount)
    @balance = amount + @balance
  end

  def deduct(amount)
    @balance = @balance - amount
  end

  def touch_in
    @in_journey = true
  end

  def touch_out
    @in_journey = false
  end

  private

  def exceeds_limit?(amount)
    @balance + amount > MAX_LIMIT
  end

end
