require "./spec_helper"

RSpec.describe NightReader do 
  describe "#initialize" do 
    it "exists" do 
      night_reader = NightReader.new("./spec/fixtures/braille_test.txt")
      expect(night_reader).to be_an_instance_of(NightReader)
    end
  end

  describe "#decode_from_braille" do 
    it "takes braille text and converts it to plain text - single character" do 
      night_reader = NightReader.new("./spec/fixtures/braille_single_letter.txt") 
      expect(night_reader.decode_from_braille).to eq("a")
    end
  end
end