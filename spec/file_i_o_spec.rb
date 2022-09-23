require "./spec_helper"

RSpec.describe FileIO do 
  it "exists" do 
    file_reader = FileIO.new 
  end

  it "can read a file" do 
    file_reader = FileIO.new 
    expect(file_reader.read("./spec/fixtures/test.txt")).to eq "this is a test"
  end

  it "can write a file" do 
    file_writer = FileIO.new
    file_writer.write("test.txt", "This is a test.")
    expect(File.read("test.txt")).to eq("This is a test.")
  end
end