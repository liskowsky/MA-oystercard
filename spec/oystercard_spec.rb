require 'oystercard'

describe Oystercard do

  subject(:oystercard) { described_class.new }

  it "has a balance of 0" do
    expect(subject.balance).to eq 0
  end
  it "adds money to current balance" do
    subject.top_up 50
    expect(subject.balance).to eq 50
  end
  it "deducts money from current balance" do
    subject.top_up 20
    expect{ subject.deduct 10 }.to change{ subject.balance }.by -10
  end
  it "error emerges when oystercard exceeds 90 pounds" do
    subject.top_up( described_class::MAX_LIMIT )
    expect{ subject.top_up 10 }.to raise_error "Oystercard's limit reached"
  end

  describe "#Card usage" do
    context "when card has founds" do
      before do
        allow(subject).to receive(:no_founds?).and_return(false)
      end
      it { is_expected.to respond_to :touch_in }
      it { is_expected.to respond_to :touch_out }
      it "in journey when touched in" do
        subject.touch_in
        expect(subject.in_journey).to eq true
      end
      it "not in journey when touched out" do
        subject.touch_out
        expect(subject.in_journey).to eq false
      end
    end
    context "when card doesn't have founds" do
      before do
        allow(subject).to receive(:no_founds?).and_return(true)
      end
      it "raises an error on touch in if the balance is below 1£" do
        expect{ subject.touch_in }.to raise_error "Insufficient founds!"
      end
    end
  end

end
