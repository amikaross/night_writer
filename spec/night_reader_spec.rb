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

    xit "takes plain text and converts it into braille - multiple lines" do
      night_reader = NightReader.new("./spec/fixtures/braille_multi_line.txt")
      expected_output = ".00...000.0..0...000..0.00..0.0.0.0...0.00..000.0.00000...0.0000..000.0.0.0.0.00\n00.0.....0.000..0..0.....0..00.0..00...00.....00...000.0.....0.0....00..0.0..0.0\n.0....0.....0.....0.....0.....0.000...0...........0.........0...........0.0...0.\n\n000......000..0...000.000.000.\n00.00...0..0.......0.0.....0.0\n..........0...................\n\n"
      expect(night_reader.decode_from_braille).to eq(expected_output)
    end
  end
end