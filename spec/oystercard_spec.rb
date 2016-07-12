#unitialized constant Oystercard (NameError)
require 'oystercard'

describe Oystercard do

  context 'balance' do
    it 'should initialize with 0' do
      expect(subject.balance).to eq 0
    end
  end

end
