require 'oystercard'
#Test for day two
describe Oystercard do

  it "has default balance of 0" do
    expect(subject.balance).to eq(0)
  end

  describe "#top_up" do

    it "tops up balance" do
      subject.top_up(5)
      expect(subject.balance).to eq(5)
    end

    it "has upper limit" do
      subject.top_up(90)
      expect{subject.top_up(1)}.to raise_error("Limit has been reached")
    end
  end
end
