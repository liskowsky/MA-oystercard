


class Oystercard

MAX_LIMIT = 90

  attr_accessor :balance

  def initialize
    @balance = 0
  end

  def top_up(amount)
    fail "Oystercard's limit reached" if exceeds_limit?(amount)
    self.balance = amount + balance
  end

  def deduct(amount)
    self.balance = balance - amount
  end

  def exceeds_limit?(amount)
    self.balance + amount > MAX_LIMIT
  end



end
