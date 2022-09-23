require "./lib/file_i_o"
require "./lib/encoder"

class NightWriter
  attr_reader :filename,
              :new_filename

  def initialize
    @filename = ARGV[0]
    @new_filename = ARGV[1]
  end

  def message 
    FileIO.read(filename).delete("\n") 
  end

  def by_lines(string)
    (0..(string.length-1)/40).map { |i| string[i * 40, 40] }
  end

  def encode_to_braille
    by_lines(message.downcase).each_with_object("") do |line, string|
      string << "#{Encoder.encode_line(line)}\n"
    end
  end

  def terminal_output
    FileIO.write(new_filename, encode_to_braille)
    "Created '#{new_filename}' containing #{message.length} characters."
  end
end


night_writer = NightWriter.new
puts night_writer.terminal_output unless ARGV[0] == "spec"

