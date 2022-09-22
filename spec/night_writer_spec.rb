require "./spec_helper"

RSpec.describe NightWriter do 
  describe "#initialize" do 
    it "exists" do 
      night_writer = NightWriter.new("./spec/fixtures/test.txt") 
      expect(night_writer).to be_an_instance_of(NightWriter)
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
