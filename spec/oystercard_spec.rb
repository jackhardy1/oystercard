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
        expect{subject.top_up(91)}.to raise_error("The maximum limit is 90")
      end
    end
end
