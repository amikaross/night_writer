require "./spec_helper"

RSpec.describe NightWriter do 
  describe "#initialize" do 
    it "exists" do 
      night_writer = NightWriter.new("./spec/fixtures/test.txt") 
      expect(night_writer).to be_an_instance_of(NightWriter)
    end
  end

  describe "#encode_to_braille" do 
    it "takes plain text and converts it into braille" do 
      night_writer = NightWriter.new("./spec/fixtures/single_letter.txt")
      expect(night_writer.encode_to_braille).to eq("0.\n..\n..")
    end
  end

  describe "#by_lines" do 
    it "returns an array of strings of 40 characters (until final one which may be less)" do 
      night_writer = NightWriter.new("message.txt")
      input = "we meet in an hour of change and challenge, in a decade of hope and fear."
      expected_output = ["we meet in an hour of change and challen",
                         "ge, in a decade of hope and fear."]
        
      expect(night_writer.by_lines(input)).to eq(expected_output)
    end
  end

  describe "#cli" do 
    it "outputs a string with the correct filename and number of characters" do 
      night_writer = NightWriter.new("./spec/fixtures/test.txt") 
      allow(night_writer).to receive(:filename).and_return("braille.txt")
      expect(night_writer.cli).to eq("Created 'braille.txt' containing 14 characters") 
    end
  end
end
