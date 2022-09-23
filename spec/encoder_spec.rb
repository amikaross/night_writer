require "./spec_helper"

RSpec.describe Encoder do 
  it "exists" do
    encoder = Encoder.new 
    expect(encoder).to be_an_instance_of(Encoder)
  end

  it "has a dictionary" do 
    dictionary = {"a" => "0.\n..\n..",
                  "b" => "0.\n0.\n..",
                  "c" => "00\n..\n..",
                  "d" => "00\n.0\n..",
                  "e" => "0.\n.0\n..",
                  "f" => "00\n0.\n..",
                  "g" => "00\n00\n..",
                  "h" => "0.\n00\n..",
                  "i" => ".0\n0.\n..",
                  "j" => ".0\n00\n..",
                  "k" => "0.\n..\n0.",
                  "l" => "0.\n0.\n0.",
                  "m" => "00\n..\n0.",
                  "n" => "00\n.0\n0.",
                  "o" => "0.\n.0\n0.",
                  "p" => "00\n0.\n0.",
                  "q" => "00\n00\n0.",
                  "r" => "0.\n00\n0.",
                  "s" => ".0\n0.\n0.",
                  "t" => ".0\n00\n0.",
                  "u" => "0.\n..\n00",
                  "v" => "0.\n0.\n00",
                  "w" => ".0\n00\n.0",
                  "x" => "00\n..\n00",
                  "y" => "00\n.0\n00",
                  "z" => "0.\n.0\n00",
                  " " => "..\n..\n..",
                  "," => "..\n0.\n..",
                  "." => "..\n00\m.0"
                }
    expect(Encoder.dictionary).to eq(dictionary)
  end

  it "can encode a given plain character to braille" do
    expect(Encoder.encode("a")).to eq("0.\n..\n..")
    expect(Encoder.encode(" ")).to eq("..\n..\n..")
    expect(Encoder.encode(",")).to eq("..\n0.\n..")
    expect(Encoder.encode("z")).to eq("0.\n.0\n00")
  end
end