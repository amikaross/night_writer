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
    braille_chars = @message.split("").each_with_object([]) do |char, array|
      array << Encoder.encode(char)
    end 
    line_1 = ""
    line_2 = ""
    line_3 = ""
    braille_chars.each do |char_array|
      line_1 << char_array[0]
      line_2 << char_array[1]
      line_3 << char_array[2]
    end
    braille_message = "#{line_1}\n#{line_2}\n#{line_3}"
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

