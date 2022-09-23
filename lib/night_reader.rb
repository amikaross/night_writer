require "./lib/file_i_o"
require "./lib/encoder"

class NightReader 
  attr_reader :braille_message,
              :filename
  
  def initialize(file)
    @braille_message = FileIO.read(file)
    @new_filename = ARGV[1]
  end

  def decode_from_braille
    by_lines(@braille_message).each_with_object("") do |line, string|
      string << "#{Encoder.decode_line(line)}"
    end
  end

  def by_lines(string)
    string.split("\n\n")
  end

  def terminal_output
    FileIO.write(new_filename, decode_from_braille)
    "Created '#{new_filename}' containing #{decode_from_braille.length} characters"
  end
end

# runner code that has to be commented out when running test suite 
# night_reader = NightReader.new(ARGV[0])
# puts night_reader.terminal_output