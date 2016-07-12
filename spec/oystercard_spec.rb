require 'oystercard'

describe Oystercard do

  subject(:oystercard) { described_class.new }
  let(:station) { double(:station) }

  it { is_expected.to respond_to(:touch_in).with(1).argument }

  describe "#Balance" do
    context "when default balance is set" do
      it "has a default balance" do
        expect(subject.balance).to eq Oystercard::DEFAULT_TOPUP
      end
      it "adds money to current balance" do
        subject.top_up 50
        expect(subject.balance).to eq 60
      end
      it "deducts money from current balance" do
        expect{ subject.touch_out 10 }.to change{ subject.balance }.by -10
      end
      it "raises error when oystercard exceeds #{Oystercard::MAX_LIMIT}" do
        expect{ subject.top_up Oystercard::MAX_LIMIT }.to raise_error "Oystercard's limit reached"
      end
      it "deducts the minimum fare from current balance after the journey" do
        subject.touch_in(station)
          expect{ subject.touch_out }.to change{ subject.balance }.by -Oystercard::MIN_FARE
      end
    end
  end

  describe "#Card usage" do
    context "when card has founds" do
      before do
        allow(subject).to receive(:no_founds?).and_return(false)
      end
      it { is_expected.to respond_to :touch_in }
      it { is_expected.to respond_to :touch_out }
      xit "in journey when touched in" do
        expect(subject.touch_in(station)).to be_in_journey
      end
      xit "not in journey when touched out" do
        subject.touch_out
        expect(subject).not_to be_in_journey
      end
    end
    context "when card doesn't have founds" do
      before do
        allow(subject).to receive(:no_founds?).and_return(true)
      end
      it "raises an error on touch in if the balance is below 1£" do
        expect{ subject.touch_in(station) }.to raise_error "Insufficient founds!"
      end
    end
  end

end
