require 'oystercard'
#Test for day two
describe Oystercard do

  it "has default balance of 0" do
    expect(subject.balance).to eq(0)
  end

  # describe "#in_journey?" do
  #   it "checks card status" do
  #     expect
  #   end

  describe "#touch_in" do
    it "changes in_journey to true" do
      subject.touch_in
      expect(subject.in_journey).to be_truthy
    end
  end

  describe "#touch_out" do
    it "changes in_journey to be false" do
      subject.touch_out
      expect(subject.in_journey).to be_falsey
    end
  end

  describe "#in_journey?" do
    it "starts outside a journey" do
      expect(subject.in_journey?).to be_falsey
    end
  end

  describe "#top_up" do

    it "tops up balance" do
      subject.top_up(5)
      expect(subject.balance).to eq(5)
    end

    it "has upper limit" do
      subject.top_up(90)
      expect{subject.top_up(1)}.to raise_error("Limit of #{Oystercard::MAX_LIMIT} has been reached")
    end
  end

  describe "#deduct" do

    it "deducts money from balance" do
      subject.top_up(5)
      expect{subject.deduct(1)}.to change{subject.balance}.by(-1)
    end
  end
end
