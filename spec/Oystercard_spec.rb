require "oystercard"


describe Oystercard do

 # it {is_expected.to respond_to(:journey_log)}

  describe "#initalize" do
    it "starts with a balance of zero" do
      expect(subject.balance).to eq 0
    end
    # it 'starts at a nil station' do
    # expect(subject.entry_station).to eq nil
    # end
    # it 'should have an empty list of journeys' do
    #   expect(subject.journey_log).to eq({})
    # end
  end

  describe "#top_up" do
    it "increase balance by set amount" do
      expect{ subject.top_up 1 }.to change{ subject.balance }.by 1
    end
  end

  describe "#limit_reached" do
    it "raise error if #top_up(amount) puts balance over maximum limit." do

      message = "£#{Oystercard::DEFAULT_LIMIT} is the top up limit £#{Oystercard::BALANCE}"
      expect{ subject.top_up 91 }.to raise_error message
    end
end

  describe '#in_journey?' do
    it "returns current journey status of Oystercard" do
      expect(subject).not_to be_in_journey
    end
  end

  describe "#touch_in(station)" do

    let (:station) {double :station}

    # it 'changes the journey status to true' do
    #   subject.top_up Oystercard::MINIMUM_BALANCE
    #   subject.touch_in(station)
    #   expect(subject).to be_in_journey
    #   end
    it 'raises an error if balance below minimun limit' do
      expect{ subject.touch_in(station) }.to raise_error "Please top up, not enough credit"
    end
    # it 'remembers the station we touched in' do
    #   subject.top_up Oystercard::MINIMUM_BALANCE
    #   subject.touch_in(station)
    #   expect(subject.entry_station).to eq station
    # end
  end

  describe "#touch_out" do

    before(:each) do
      subject.top_up Oystercard::MINIMUM_BALANCE
      subject.touch_in(station)
    end

    let (:station) {double :station}
    let (:journey) {double :journey}

    # it 'changes the journey status to false' do
    #   subject.touch_out(station)
    #   expect(subject).not_to be_in_journey
    # end
    it "deducts the fare from the oystercard" do
      allow(journey).to receive(:fare_calculator).and_return(described_class::MIN_FARE)
      subject.top_up(10)
      subject.touch_in(station)
      expect{ subject.touch_out(station) }.to change { subject.balance }.by -described_class::MIN_FARE
    end


    # it "forgets entry station upon touch_out" do
    #   subject.touch_out(station)
    #   expect(subject.entry_station).to eq nil
    # end
    # it "remembers exit station" do
    #   subject.touch_out(station)
    #   expect(subject.exit_station).to eq nil
    # end
    # it "should add the journey to the list" do
    #   expect{subject.touch_out(station)}.to change{subject.journey_log.length}.by 1
    # end

  end

end
