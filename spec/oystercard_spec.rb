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
      expect{subject.deduct 10}.to change{subject.balance}.by -10

    end

  it "error emerges when oystercard exceeds 90 pounds" do
    subject.top_up( described_class::MAX_LIMIT )
    expect{subject.top_up 10}.to raise_error "Oystercard's limit reached"

  end

end
