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

    it "takes plain text and converts it into braille - multiple characters" do 
      night_reader = NightReader.new("./spec/fixtures/braille_multi_letter.txt")
      expect(night_reader.decode_from_braille).to eq("abc")
    end 

    it "takes plain text and converts it into braille - multiple lines" do
      night_reader = NightReader.new("./spec/fixtures/braille_multi_line.txt")
      expected_output = "we meet in an hour of change and challenge, in a decade"
      expect(night_reader.decode_from_braille).to eq(expected_output)
    end
  end
end