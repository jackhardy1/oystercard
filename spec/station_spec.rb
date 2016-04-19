require 'station'

describe Station do

  describe "initialize" do
    it "starts with a name" do
      holborn = Station.new('holborn',2)
      expect(holborn.name).to eq('holborn')
    end
  end
end
