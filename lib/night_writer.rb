require "./lib/file_i_o"
require "./lib/encoder"

class NightWriter
  attr_reader :message,
              :new_filename

  def initialize(file)
    @message = FileIO.read(file)
    @new_filename = ARGV[1]
  end

  def by_lines(string)
    (0..(string.length-1)/40).map { |i| string[i * 40, 40] }
  end

  def encode_to_braille
    by_lines(@message.downcase).each_with_object("") do |line, string|
      string << "#{Encoder.encode_line(line)}\n"
    end
  end

  def terminal_output
    FileIO.write(new_filename, encode_to_braille)
    "Created '#{new_filename}' containing #{message.length} characters."
  end
end

# runner code that has to be commented out when running test suite 
# night_writer = NightWriter.new(ARGV[0])
# puts night_writer.terminal_output

