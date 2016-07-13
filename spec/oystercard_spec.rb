require 'oystercard'

describe Oystercard do

  let(:station) { double(:station) }
  let(:station_2) { double(:station) }
  let(:journey){ {:entry_station => station, :exit_station => station_2} }
  default_topup = 10

  describe "#Balance" do

    it 'returns the initial balance of 0' do
      expect(subject.balance).to eq 0
    end

    it "adds money to current balance" do
      subject.top_up default_topup
      expect(subject.balance).to eq default_topup
    end

    it "raises error when oystercard exceeds top up limit" do
      expect{ subject.top_up (Oystercard::BALANCE_LIMIT + 1)}.to raise_error "Over the limit!"
    end

    it 'not be able to touch in when balance is below £1' do
      expect{ subject.touch_in(station) }.to raise_error("Insufficient founds!")
    end

  end

  describe "#Touch functionality in/out" do

    before do
      subject.top_up(default_topup)
      subject.touch_in(station)
    end

    it "should set card to in journey when touched in" do
      expect(subject).to be_in_journey    end

    it "should set card to NOT be in journey when touched out" do
      subject.touch_out(station)
      expect(subject).not_to be_in_journey
    end

    it "is getting charged on touch out" do
      expect{ subject.touch_out(station) }.to change{ subject.balance }.by -(Oystercard::MIN_FARE)
    end

    it "sets current station to nil on touch out" do
      expect{ subject.touch_out(station) }.to change{ subject.station }.from(station).to(nil)
    end

  end

  describe "#Journeys" do

    it "has an empty journey history" do
      expect(subject.journeys).to be_empty
    end

    it "stores entry and exit stations" do
      subject.top_up(default_topup)
      subject.touch_in(station)
      subject.touch_out(station_2)
      expect(subject.journeys).to include journey
    end

  end

end
