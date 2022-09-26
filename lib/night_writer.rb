require "./lib/file_i_o"
require "./lib/encoder"

class NightWriter
  attr_reader :filename,
              :new_filename

  def initialize
    @filename = ARGV[0]
    @new_filename = ARGV[1]
    @message_length = nil
  end

  def by_lines(string)
    number_of_braille_chars = string.length + string.scan(/[A-Z]/).length
    number_of_lines = number_of_braille_chars / 40 
    lines = (0..number_of_lines).map { |i| "" }
    line_number = 0
    counter = 0 
    string.chars.each do |char|
      if counter == 40 
        counter = 0
        line_number += 1
      end
      lines[line_number] << char 
      ("A".."Z").include?(char) ? counter += 2 : counter += 1 
    end
    lines
  end
  # def by_lines(string)
  #   (0..(string.length-1)/40).map { |i| string[i * 40, 40] }
  # end

  def encode_to_braille
    message = FileIO.read(filename).delete("\n") 
    @message_length = message.length
    by_lines(message).each_with_object("") do |line, string|
      string << "#{Encoder.encode_line(line)}\n"
    end
  end

  def terminal_output
    FileIO.write(new_filename, encode_to_braille)
    "Created '#{new_filename}' containing #{@message_length} characters."
  end
end


night_writer = NightWriter.new
puts night_writer.terminal_output unless ARGV[0] == "spec"

