require "oystercard"

describe Oystercard do


  describe "#initalize" do
    it "starts with a balance of zero" do
      expect(subject.balance).to eq 0
    end
  end

  describe "#top_up" do
    it "increase balance by set amount" do
      expect{ subject.top_up 1 }.to change{ subject.balance }.by 1
    end
  end

  describe "#limit_reached" do
    it "raise error if #top_up(amount) puts balance over maximum limit." do

      message = "Top up amount pushes you over your maximum oyster card limit of £#{Oystercard::DEFAULT_LIMIT}. Your current balance is £#{Oystercard::BALANCE}"
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
    it 'changes the journey status to true' do
      subject.top_up Oystercard::MINIMUM_BALANCE
      subject.touch_in(station)
      expect(subject).to be_in_journey
      end
    it 'raises an error if balance below minimun limit' do
      expect{ subject.touch_in(station) }.to raise_error "Please top up, not enough credit"
    end
    it ' remembers the station we touched in' do
      subject.top_up Oystercard::MINIMUM_BALANCE
      expect(subject).to respond_to(:touch_in).with(1).argument
    end
  end

  describe "#touch_out" do
    let (:station) {double :station}
    it 'changes the journey statis to false' do
      subject.top_up Oystercard::MINIMUM_BALANCE
      subject.touch_in(station)
      subject.touch_out
      expect(subject).not_to be_in_journey
    end
    it "deducts the fare from the oystercard" do
      subject.top_up Oystercard::MINIMUM_BALANCE
      subject.touch_in(station)
      expect{ subject.touch_out }.to change { subject.balance }.by -Oystercard::FARE
    end
  end

end
