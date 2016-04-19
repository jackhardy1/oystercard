require 'station'

describe Station do

  describe "initialize" do
    it "sets a name" do
      holborn = Station.new('holborn',2)
      expect(holborn.name).to eq('holborn')
    end

    it "sets the zone" do
      holborn = Station.new('holborn',2)
      expect(holborn.zone).to eq(2)
    end

  end

end
