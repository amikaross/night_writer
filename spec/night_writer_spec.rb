require "./spec_helper"

RSpec.describe NightWriter do
  let(:night_writer) { NightWriter.new }

  describe "#initialize" do 
    it "exists" do 
      allow(night_writer).to receive(:filename).and_return("./spec/fixtures/test.txt")
      expect(night_writer).to be_an_instance_of(NightWriter)
    end
  end

  describe "#by_lines" do 
    it "returns an array of strings of 40 characters (until final one which may be less)" do 
      allow(night_writer).to receive(:filename).and_return("./spec/fixtures/test.txt")
      input = "we meet in an hour of change and challenge, in a decade of hope and fear."
      expected_output = ["we meet in an hour of change and challen",
                        "ge, in a decade of hope and fear."]
        
      expect(night_writer.by_lines(input)).to eq(expected_output)
    end

    it "counts capitalized characters as two characters (per braille)" do 
      allow(night_writer).to receive(:filename).and_return("./spec/fixtures/test.txt")
      input = "We meet in an hour of change and challenge, in a decade of hope and fear."
      expected_output = ["We meet in an hour of change and challe",
                        "nge, in a decade of hope and fear."]
        
      expect(night_writer.by_lines(input)).to eq(expected_output)
    end
  end

  describe "#encode_char" do 
    it "can encode a given lowercase plain character to an array of braille" do
      expect(night_writer.encode_char("a")).to eq(["0.", "..", ".."])
      expect(night_writer.encode_char(" ")).to eq(["..", "..", ".."])
      expect(night_writer.encode_char(",")).to eq(["..", "0.", ".."])
    end

    it "can encode a given uppercase plain character to an array of braille" do 
      expect(night_writer.encode_char("A")).to eq(["..0.", "....", ".0.."])
    end
  end 

  describe "#encode_line" do
    it "can encode a given plain-text line into braille" do 
      expected_output = "0.0.0.0.0....00.0.0.00\n00.00.0..0..00.0000..0\n....0.0.0....00.0.0...\n"
      expect(night_writer.encode_line("hello world")).to eq(expected_output)
    end
  end

  describe "#encode_message" do 
    it "takes plain text and converts it into braille - single character" do 
      allow(night_writer).to receive(:filename).and_return("./spec/fixtures/single_letter.txt")
      expect(night_writer.encode_message).to eq("0.\n..\n..\n\n")
    end 

    it "takes plain text and converts it into braille - multiple characters" do 
      allow(night_writer).to receive(:filename).and_return("./spec/fixtures/multi_letter.txt")
      expect(night_writer.encode_message).to eq("..0.0.00\n....0...\n.0......\n\n")
    end 

    it "takes plain text and converts it into braille - multiple lines" do
      allow(night_writer).to receive(:filename).and_return("./spec/fixtures/multi_line.txt")
      expected_output = ".00...000.0..0...000..0.00..0.0.0.0...0.00..000.0.00000...0.0000..000.0.0.0.0.00\n" +
                        "00.0.....0.000..0..0.....0..00.0..00...00.....00...000.0.....0.0....00..0.0..0.0\n" +
                        ".0....0.....0.....0.....0.....0.000...0...........0.........0...........0.0...0.\n\n" +
                        "000......000..0...000.000.000.\n" +
                        "00.00...0..0.......0.0.....0.0\n" +
                        "..........0...................\n\n"
      expect(night_writer.encode_message).to eq(expected_output)
    end

    it "accouts for capitalized letters" do 
      allow(night_writer).to receive(:filename).and_return("./spec/fixtures/capitalized.txt")
      expected_output = "0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.\n" +
                        "................................................................................\n" +
                        "................................................................................\n\n" +
                        "..0...0...0...0...0...0...0...0...0...0...0...0...0...0...0...0...0...0...0...0.\n" +
                        "..0...0...0...0...0...0...0...0...0...0...0...0...0...0...0...0...0...0...0...0.\n" +
                        ".0...0...0...0...0...0...0...0...0...0...0...0...0...0...0...0...0...0...0...0..\n\n" +
                        "..0...0...0...0...0...0...0...0...0...0...0...0...0...0...0...0...0...0...0...0.\n" +
                        "..0...0...0...0...0...0...0...0...0...0...0...0...0...0...0...0...0...0...0...0.\n" +
                        ".0...0...0...0...0...0...0...0...0...0...0...0...0...0...0...0...0...0...0...0..\n\n" +
                        "000000..00..00..00\n" +
                        "..................\n" +
                        ".......0...0...0..\n\n" 
      expect(night_writer.encode_message).to eq(expected_output)
    end
  end

  describe "#terminal_output" do 
    it "returns a string with the correct filename and number of characters" do 
      allow(night_writer).to receive(:filename).and_return("./spec/fixtures/test.txt")
      allow(night_writer).to receive(:new_filename).and_return("braille.txt")
      expect(night_writer.terminal_output).to eq("Created 'braille.txt' containing 14 characters.")
      File.delete("braille.txt")
    end
  end
end
