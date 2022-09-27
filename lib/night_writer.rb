require "./lib/file_i_o"
require "./lib/translator"

class NightWriter < Translator
  def initialize
    super
  end

  def total_lines(string)
    total_caps = string.scan(/[A-Z]/).length
    total_numbers = string.scan(/[0-9]/).length
    number_of_braille_chars = string.length + total_caps + total_numbers
    number_of_braille_chars / 40 
  end

  def by_lines(string)
    line_number = 0
    counter = 0 
    string.chars.each_with_object((0..total_lines(string)).map { |i| "" }) do |char, array|
      if counter >= 40 then counter = 0 and line_number += 1 end 
      array[line_number] << char 
      if ("A".."Z").include?(char) || ("0".."9").include?(char)
        counter += 2 
      else 
        counter += 1 
      end 
    end
  end

  def encode_char(char)
    if ("A".."Z").include?(char)
      char = char.downcase
      ["..", "..", ".0"].zip(dictionary[char]).map(&:join)
    elsif ("0".."9").include?(char)
      [".0", ".0", "00"].zip(dictionary[to_alpha(char)]).map(&:join)
    else 
      braille_char = dictionary[char]
    end
  end

  def encode_line(line)
    braille_arrays = line.chars.map { |char| encode_char(char) }
    lines = ["", "", ""]
    braille_arrays.each do |array|
      lines[0] << array[0]
      lines[1] << array[1]
      lines[2] << array[2]
    end
    braille_line = lines.join("\n") + "\n"
  end

  def encode_message
    message = FileIO.read(filename).delete("\n") 
    @message_length = message.length
    by_lines(message).each_with_object("") do |line, string|
      string << "#{encode_line(line)}\n"
    end
  end

  def run 
    terminal_output(encode_message)
  end
end


night_writer = NightWriter.new
puts night_writer.run unless ARGV[0] == "spec"

