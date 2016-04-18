require 'oystercard'

describe Oystercard do
  let (:station) {double :station}

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

    describe "#in_journey?" do
      it "starts outside of a journey" do
        expect(subject.in_journey?).to eq false
      end
    end

    describe "#touch_in" do
      it "should change value of in_journey to be true" do
        subject.top_up(5)
        subject.touch_in(station)
        expect(subject.in_journey?).to eq true
      end

      it "it raises an error on 'touch_in', if balance is less than £1" do
        expect{subject.touch_in(station)}.to raise_error "Insufficient funds"
      end

      it "it stores the entry station" do
        subject.top_up(1)
        subject.touch_in(station)
        expect(subject.entry_station).to eq station
      end
    end

    describe "#touch_out" do
      it "should change value of in_journey to be false" do
        subject.top_up(5)
        subject.touch_in(station)
        subject.touch_out
        expect(subject.in_journey?).to eq false
      end

      it "should deduct the minimum fare" do
        subject.top_up(5)
        subject.touch_in(station)
        expect{subject.touch_out}.to change{subject.balance}.by(-Oystercard::MINIMUM_FARE)
      end

      it "deducts an amount from balance for a journey" do
        subject.top_up(10)
        expect{subject.touch_out}.to change{subject.balance}.by(-1)
      end

      it "sets the entry station to nil" do
        subject.top_up(5)
        subject.touch_in(station)
        subject.touch_out
        expect(subject.entry_station).to eq nil
      end
    end
end
