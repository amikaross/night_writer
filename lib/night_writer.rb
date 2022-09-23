require "./lib/file_reader"
require "./lib/encoder"

class NightWriter
  attr_reader :message,
              :filename

  def initialize(file)
    @message = FileReader.new.read(file)
    @filename = ARGV[1]
  end

  def encode_to_braille
    # array_of_lines = by_lines(@message.downcase)
    Encoder.encode_line(@message)
  end

  def by_lines(string)
    (0..(string.length-1)/40).map { |i| string[i * 40, 40] }
  end

  def cli 
    "Created '#{filename}' containing #{message.length} characters"
  end
end

# runner code that has to be commented out when running test suite 
# night_writer = NightWriter.new(ARGV[0])
# puts night_writer.cli

# require 'pry'; binding.pry

