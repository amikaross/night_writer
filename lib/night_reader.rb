require "./lib/file_i_o"
require "./lib/encoder"

class NightReader 
  attr_reader :braille_message,
              :filename
  
  def initialize(file)
    @braille_message = FileIO.read(file)
    @filename = ARGV[1]
  end

  def decode_from_braille
    by_lines(@braille_message).each_with_object("") do |line, string|
      string << "#{Encoder.decode_line(line)}"
    end
  end

  def by_lines(string)
    string.split("\n\n")
  end
end