require 'journey'

describe Journey do

  # it {is_expected.to respond_to(:finish)}
  # it {is_expected.to respond_to(:complete)}
  # it {is_expected.to respond_to(:fare)}
  # it {is_expected.to respond_to(:show_journey)}

 let(:entry_station) {double :entry_station}
 let(:exit_station) {double :exit_station}
 subject(:journey) {Journey.new entry_station}

 it "starts with entry station" do
   expect(journey.entry_station).to eq entry_station
 end

 it 'no entry station supplied, defaults to nil' do
   journey = Journey.new
   expect(journey.entry_station).to be_nil
 end

it 'exit station is "nil"' do
  expect(journey.exit_station).to be_nil
end

describe'#finish' do

 it "finishes with an exit station" do
   journey.finish(exit_station)
   expect(journey.exit_station).to eq exit_station
 end
end

describe '#complete' do

  it 'new journey is not complete' do
    expect(journey).not_to be_complete
  end

  it 'journey with no beginning is not complete' do
    journey = Journey.new
    journey.finish(exit_station)
    expect(journey).not_to be_complete
  end

  it 'journey with a start and finish is a complete journey' do
    journey.finish(exit_station)
    expect(journey).to be_complete
  end

    context "when not completed" do
      it "charge penalty fare" do
        expect(journey.fare).to eq described_class::PEN_FARE
      end
    end

    context "when completed" do
      it "charge min fare" do
        journey.finish exit_station
        expect(subject.fare).to eq described_class::MIN_FARE
      end
    end
  end
end
