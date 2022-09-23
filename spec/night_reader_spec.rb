require "./spec_helper"

RSpec.describe NightReader do 
  describe "#initialize" do 
    it "exists" do 
      night_reader = NightReader.new("./spec/fixtures/braille_test.txt")
      expect(night_reader).to be_an_instance_of(NightReader)
    end
  end
end