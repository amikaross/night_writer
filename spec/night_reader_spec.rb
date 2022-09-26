require "./spec_helper"

RSpec.describe NightReader do 
  let(:night_reader) { NightReader.new }

  describe "#initialize" do 
    it "exists" do 
      allow(night_reader).to receive(:filename).and_return("./spec/fixtures/braille_test.txt")
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
  end

  describe "#decode_message" do 
    it "takes braille text and converts it to plain text - single character" do 
      allow(night_reader).to receive(:filename).and_return("./spec/fixtures/braille_single_letter.txt")
      expect(night_reader.decode_message).to eq("a")
    end

    it "takes plain text and converts it into braille - multiple characters" do 
      allow(night_reader).to receive(:filename).and_return("./spec/fixtures/braille_multi_letter.txt")
      expect(night_reader.decode_message).to eq("abc")
    end 

    it "takes plain text and converts it into braille - multiple lines" do
      allow(night_reader).to receive(:filename).and_return("./spec/fixtures/braille_multi_line.txt")
      expected_output = "we meet in an hour of change and challenge, in a decade"
      expect(night_reader.decode_message).to eq(expected_output)
    end
  end

  describe "#terminal_output" do 
    it "returns a string with the correct filename and number of characters" do 
      allow(night_reader).to receive(:filename).and_return("./spec/fixtures/braille_test.txt") 
      allow(night_reader).to receive(:new_filename).and_return("original_message.txt")
      expect(night_reader.terminal_output).to eq("Created 'original_message.txt' containing 14 characters.") 
      File.delete("original_message.txt")
    end
  end
end