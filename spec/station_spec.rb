require 'station'

describe Station do

  subject(:station) { described_class.new(name: "London", zone: 1)}

  it "has a neme" do
    expect(subject.name).to eq("London")
  end

  it "has a zone" do
    expect(subject.zone).to eq(1)
  end

end
