require 'oystercard'

describe Oystercard do

  let(:station1) { double(name: "some station", zone: 1)}
  let(:station2) { double(name: "some other station", zone: 2) }
  #let(:journey){ double(entry_station: station1, exit_station: station2) }
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
      expect{ subject.touch_in(station1) }.to raise_error("Insufficient founds!")
    end

  end

  describe "#Touch functionality in/out" do

    before do
      subject.top_up(default_topup)
      subject.touch_in(station1)
    end

    it "is getting charged on touch out" do
      expect{ subject.touch_out(station2) }.to change{ subject.balance }.by -station2.zone
    end

  end

  describe "#Journeys" do

    it "has an empty journey history" do
      expect(subject.journeys).to be_empty
    end

    it "stores entry and exit stations" do
      subject.top_up(default_topup)
      subject.touch_in(station1)
      subject.touch_out(station2)
      expect(subject.journeys).to include ({entry_station: station1, exit_station: station2})
    end

  end

end
