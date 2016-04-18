require 'oystercard'

describe Oystercard do
    it "has a default balance of 0" do
      expect(subject.balance).to eq(0)
    end


    describe "#top_up" do
      it "increases the balance when the top_up method is called" do
        subject.top_up(5)
        expect(subject.balance).to eq(5)
      end
    end
end
