require "./spec_helper"

RSpec.describe NightReader do 
  let(:night_reader) { NightReader.new }

  describe "#initialize" do 
    it "exists" do 
      expect(night_reader).to be_an_instance_of(NightReader)
    end
  end

  describe "#decode_char" do 
    it "can decode a given lowercase braille char into plain text (regardless of trailing new lines)" do
      expect(night_reader.decode_char("0.\n..\n..")).to eq("a")
      expect(night_reader.decode_char("0.\n..\n..\n\n")).to eq("a")
    end

    it "can decode a given uppercase braille char into plain text" do 
      expect(night_reader.decode_line("..0.\n....\n.0..")).to eq("A")
    end
  end

  describe "#decode_line" do 
    it "can decode a given lowercase braille line into plain text" do 
      input = "0.0.0.0.0....00.0.0.00\n00.00.0..0..00.0000..0\n....0.0.0....00.0.0...\n"
      expect(night_reader.decode_line(input)).to eq("hello world")
    end

    it "can decode a given uppercase braille line into plain text" do 
      input = "..0.0.0.0.0......00.0.0.00\n..00.00.0..0....00.0000..0\n.0....0.0.0....0.00.0.0...\n"
      expect(night_reader.decode_line(input)).to eq("Hello World")
    end

    it "can decode a given braille line with numbers into plain text" do 
      input = ".0.0.00..00..000.000.00..000.000.00..0.0...0.0.00..00..000.000.00..000.000.00..0.0\n" +
              ".000.0...00..0...0.0.0.0.00..000.000.00....000.0...00..0...0.0.0.0.00..000.000.00.\n" +
              "00..00..00..00..00..00..00..00..00..00....00..00..00..00..00..00..00..00..00..00..\n\n" 
      expect(night_reader.decode_line(input)).to eq("0123456789 0123456789")
    end
  end

  describe "#decode_message" do 
    it "takes braille text and converts it to plain text - single character" do 
      allow(night_reader).to receive(:filename).and_return("./spec/fixtures/braille_single_letter.txt")
      expect(night_reader.decode_message).to eq("a")
    end

    it "takes braille text and converts it into plain text - multiple characters" do 
      allow(night_reader).to receive(:filename).and_return("./spec/fixtures/braille_multi_letter.txt")
      expect(night_reader.decode_message).to eq("abc")
    end 

    it "takes braille text and converts it into plain text - multiple lines" do
      allow(night_reader).to receive(:filename).and_return("./spec/fixtures/braille_multi_line.txt")
      expected_output = "we meet in an hour of change and challenge, in a decade"
      expect(night_reader.decode_message).to eq(expected_output)
    end

    it "can account for braille messages that aren't split with a double newline ('\n\n')" do 
      allow(night_reader).to receive(:filename).and_return("./spec/fixtures/single_new_line_braille.txt")
      expected_output = "we meet in an hour of change and challenge, in a decade"
      expect(night_reader.decode_message).to eq(expected_output)
    end
  end

  describe "#run" do 
    it "returns a string with the correct filename and number of characters" do 
      allow(night_reader).to receive(:filename).and_return("./spec/fixtures/braille_test.txt")
      allow(night_reader).to receive(:new_filename).and_return("test.txt")
      expect(night_reader.run).to eq("Created 'test.txt' containing 14 characters.")
      File.delete("test.txt")
    end
  end
end