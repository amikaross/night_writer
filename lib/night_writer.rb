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
    by_lines(@message.downcase).each_with_object("") do |line, string|
      string << "#{Encoder.encode_line(line)}\n"
    end
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

