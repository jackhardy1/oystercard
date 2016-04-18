require 'oystercard'

describe Oystercard do
    it "has a default balance of 0" do
      expect(subject.balance).to eq(0)
    end

    describe "#top_up" do
      it "increases the balance when the top_up method is called" do
        expect{subject.top_up(5)}.to change{subject.balance}.by 5
      end

      it "raises an error if amount + balance exceeds maximum limit" do
        max = Oystercard::MAXIMUM_LIMIT
        subject.top_up(max)
        expect{subject.top_up(1)}.to raise_error("The maximum limit is #{max}")
      end
    end

    describe "#deduct" do
      it "deducts an amount from balance for a journey" do
        subject.top_up(10)
        expect{subject.deduct(5)}.to change{subject.balance}.by(-5)
      end
    end

    describe "in_journey?" do
      it "starts outside of a journey" do
        expect(subject.in_journey?).to eq false
      end
    end



end
