require "./spec_helper"

RSpec.describe Encoder do 
  it "exists" do
    encoder = Encoder.new 
    expect(encoder).to be_an_instance_of(Encoder)
  end

  it "has a dictionary" do 
    dictionary = {"a" => ["0.", "..", ".."],
                  "b" => ["0.", "0.", ".."],
                  "c" => ["00", "..", ".."],
                  "d" => ["00", ".0", ".."],
                  "e" => ["0.", ".0", ".."],
                  "f" => ["00", "0.", ".."],
                  "g" => ["00", "00", ".."],
                  "h" => ["0.", "00", ".."],
                  "i" => [".0", "0.", ".."],
                  "j" => [".0", "00", ".."],
                  "k" => ["0.", "..", "0."],
                  "l" => ["0.", "0.", "0."],
                  "m" => ["00", "..", "0."],
                  "n" => ["00", ".0", "0."],
                  "o" => ["0.", ".0", "0."],
                  "p" => ["00", "0.", "0."],
                  "q" => ["00", "00", "0."],
                  "r" => ["0.", "00", "0."],
                  "s" => [".0", "0.", "0."],
                  "t" => [".0", "00", "0."],
                  "u" => ["0.", "..", "00"],
                  "v" => ["0.", "0.", "00"],
                  "w" => [".0", "00", ".0"],
                  "x" => ["00", "..", "00"],
                  "y" => ["00", ".0", "00"],
                  "z" => ["0.", ".0", "00"],
                  " " => ["..", "..", ".."],
                  "," => ["..", "0.", ".."],
                  "." => ["..", "00", ".0"],
                  "'" => ["..", "..", "0."]
                }
    expect(Encoder.dictionary).to eq(dictionary)
  end

  it "can encode a given lowercase plain character to an array of braille" do
    expect(Encoder.encode_char("a")).to eq(["0.", "..", ".."])
    expect(Encoder.encode_char(" ")).to eq(["..", "..", ".."])
    expect(Encoder.encode_char(",")).to eq(["..", "0.", ".."])
  end

  it "can encode a given uppercase plain character to an array of braille" do 
    expect(Encoder.encode_char("A")).to eq(["..0.", "....", ".0.."])
  end

  it "can encode a given plain-text line into braille" do 
    expected_output = "0.0.0.0.0....00.0.0.00\n00.00.0..0..00.0000..0\n....0.0.0....00.0.0...\n"
    expect(Encoder.encode_line("hello world")).to eq(expected_output)
  end

  it "can decode a given braille char into plain text (regardless of trailing new lines" do
    expect(Encoder.decode_char("0.\n..\n..")).to eq("a")
    expect(Encoder.decode_char("0.\n..\n..\n\n")).to eq("a")
  end

  it "can decode a given braille line into plain text" do 
    input = "0.0.0.0.0....00.0.0.00\n00.00.0..0..00.0000..0\n....0.0.0....00.0.0...\n"
    expect(Encoder.decode_line(input)).to eq("hello world")
  end
end