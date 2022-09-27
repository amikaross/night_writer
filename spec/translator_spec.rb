require "./spec_helper"

RSpec.describe Translator do 
  it "exists" do
    translator = Translator.new 
    expect(translator).to be_an_instance_of(Translator)
  end

  it "has a dictionary" do 
    translator = Translator.new
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
                  "'" => ["..", "..", "0."],
                  "1" => "a",
                  "2" => "b",
                  "3" => "c",
                  "4" => "d",
                  "5" => "e",
                  "6" => "f",
                  "7" => "g",
                  "8" => "h",
                  "9" => "i",
                  "0" => "j"
                }
    expect(translator.dictionary).to eq(dictionary)
  end

  it "returns the alphabetical character associated with a number" do 
    translator = Translator.new
    expect(translator.to_alpha("1")).to eq("a")
  end

  it "can produce terminal output" do 
    translator = Translator.new
    allow(translator).to receive(:new_filename).and_return("test.txt")
    new_message = "This is a test"
    allow(translator).to receive(:message_length).and_return(new_message.length)
    expect(translator.terminal_output(new_message)).to eq("Created 'test.txt' containing 14 characters.")
    File.delete("test.txt")
  end
end