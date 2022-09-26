require "./lib/file_i_o"
require "./lib/translator"

class NightWriter < Translator
  attr_reader :filename,
              :new_filename

  def initialize
    @filename = ARGV[0]
    @new_filename = ARGV[1]
    @message_length = nil
    super
  end

  def by_lines(string)
    number_of_braille_chars = string.length + string.scan(/[A-Z]/).length
    number_of_lines = number_of_braille_chars / 40 
    line_number = 0
    counter = 0 
    string.chars.each_with_object((0..number_of_lines).map { |i| "" }) do |char, array|
      if counter == 40 then counter = 0 and line_number += 1 end 
      array[line_number] << char 
      ("A".."Z").include?(char) ? counter += 2 : counter += 1 
    end
  end

  def encode_char(char)
    if ("A".."Z").include?(char)
      char = char.downcase
      ["..", "..", ".0"].zip(self.dictionary[char]).map(&:join)
    else 
      dictionary.keys.include?(char)
      braille_char = dictionary[char]
    end
  end

  def encode_line(line)
    braille_chars = line.chars.map { |char| self.encode_char(char) }
    lines = ["", "", ""]
    braille_chars.each do |char_array|
      lines[0] << char_array[0]
      lines[1] << char_array[1]
      lines[2] << char_array[2]
    end
    braille_line = "#{lines[0]}\n#{lines[1]}\n#{lines[2]}\n"
  end

  def encode_message
    message = FileIO.read(filename).delete("\n") 
    @message_length = message.length
    by_lines(message).each_with_object("") do |line, string|
      string << "#{encode_line(line)}\n"
    end
  end

  def terminal_output
    FileIO.write(new_filename, encode_message)
    "Created '#{new_filename}' containing #{@message_length} characters."
  end
end


night_writer = NightWriter.new
puts night_writer.terminal_output unless ARGV[0] == "spec"

