class Journey

  PENALTY_FARE = 6
  attr_reader :entry_station, :exit_station, :fare

  def initialize(entry_station = nil)
    @entry_station = entry_station
  end

  def finish(exit_station)
    @exit_station = exit_station
    self
  end

  def complete?
    !!entry_station && !!exit_station
  end

  def fare
    calculate_fare
  end

  private

  def calculate_fare
    complete? ? @fare = exit_station.zone : @fare = PENALTY_FARE
  end

end
