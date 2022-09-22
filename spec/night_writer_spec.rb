require "./spec_helper"

RSpec.describe NightWriter do 
  describe "#initialize" do 
    it "exists" do 
      night_writer = NightWriter.new 
      expect(night_writer).to be_an_instance_of(NightWriter)
    end
  end
end
