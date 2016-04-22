require "oystercard"

describe Oystercard do

  let (:entry_station) {double :entry_station, name: "stn1", zone: 1}
  let (:exit_station) {double :exit_station, name: "stn2", zone: 5}

  describe "#initalize" do
    it "zero balance" do
      expect(subject.balance).to eq 0
    end
  end

  describe "#top_up" do
    it "increase balance by set amount" do
      expect{ subject.top_up 1 }.to change{ subject.balance }.by 1
    end

    it "raise error if balance over limit." do
      err_msg = "Maximum limit of £#{described_class::DEFAULT_LIMIT} exceeded"
      expect{ subject.top_up 91 }.to raise_error err_msg
    end
end

  describe "#touch_in" do
    let(:journey) {{entry: ["stn1", 1]}}
    it 'in journey' do
      subject.top_up Oystercard::DEFAULT_LIMIT
      subject.touch_in(entry_station)
      expect(subject).to be_in_journey
    end

    it 'raises an error if balance below minimun fare' do
      expect{ subject.touch_in(entry_station) }.to raise_error "Please top up, not enough credit"
    end

    it 'no money deducted' do
      subject.top_up Oystercard::DEFAULT_LIMIT
      expect(subject).not_to receive(:deduct)
      subject.touch_in entry_station
    end

    context 'already touched in' do
      let(:journey) {{entry: entry_station, exit: nil}}
      before {subject.top_up Oystercard::DEFAULT_LIMIT}
      before {subject.touch_in entry_station}
      it "charges fare for previous journey" do
        expect(subject).to receive(:deduct)
        subject.touch_in entry_station
      end
    end
  end

  describe "#touch_out" do
    let(:journey) {{entry: entry_station, exit: exit_station}}
    it "charges fare" do
      expect(subject).to receive(:deduct)
      subject.touch_out exit_station
    end
    context "when touched in" do
      before {subject.top_up Oystercard::DEFAULT_LIMIT}
      before {subject.touch_in(entry_station)}
    end
  end
end
