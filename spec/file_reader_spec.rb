require "./spec_helper"

RSpec.describe FileReader do 
  it "exists" do 
    file_reader = FileReader.new 
  end

  it "can read a file" do 
    file_reader = FileReader.new 
    expect(file_reader.read("./spec/fixtures/test.txt")).to eq "this is a test"
  end
end