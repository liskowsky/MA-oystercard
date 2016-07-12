require 'oystercard'

describe Oystercard do

  subject(:oystercard) { described_class.new }

  it "has a balance of 0" do
    expect(subject.balance).to eq 0
  end
  it "adds money to current balance" do
    subject.top_up(100)
    expect(subject.balance).to eq 100
  end

end
