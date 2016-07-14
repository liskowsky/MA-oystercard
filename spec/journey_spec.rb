require 'journey'

describe Journey do

  let(:station1) { double(name: "some station", zone: 1)}
  let(:station2) { double(name: "some other station", zone: 2)}

  it "knows if a journey is not complete" do
    expect(subject).not_to be_complete
  end

  it "has a panalty fare by default" do
    expect(subject.fare).to eq Journey::PENALTY_FARE
  end

  it "returns itself when exiting a journey" do
   expect(subject.finish(station2)).to eq(subject)
  end

  context 'given an entry station' do
    subject {described_class.new(station1)}

    it 'has an entry station' do
      expect(subject.entry_station).to eq station1
    end

    it "returns a penalty fare if no exit station given" do
      expect(subject.fare).to eq Journey::PENALTY_FARE
    end

    context 'given an exit station' do

      before do
        subject.finish(station2)
      end

      it 'calculates a fare' do
        expect(subject.fare).to eq station2.zone
      end

      it "knows if a journey is complete" do
        expect(subject).to be_complete
      end
    end
  end

end
