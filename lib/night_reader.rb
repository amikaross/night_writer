require "./lib/file_i_o"
require "./lib/translator"

class NightReader < Translator
  attr_reader :filename,
              :new_filename
  
  def initialize
    super
  end

  def by_lines(string)
    string.split("\n\n")
  end

  def decode_char(string)
    plain_char = dictionary.key(string.split("\n"))
  end

  def decode_line(line)
    nested_array = line.split("\n").map { |row| row.chars.each_slice(2).map(&:join) }
    row_length = nested_array[0].length
    (0..row_length - 1).each_with_object("") do |i, string| 
      if nested_array[0][i] == ".." && nested_array[1][i] == ".." && nested_array[2][i] == ".0"
        next
      elsif nested_array[0][i - 1] == ".." && nested_array[1][i - 1] == ".." && nested_array[2][i - 1] == ".0"
        string << decode_char("#{nested_array[0][i]}\n#{nested_array[1][i]}\n#{nested_array[2][i]}").upcase
      else 
        string << decode_char("#{nested_array[0][i]}\n#{nested_array[1][i]}\n#{nested_array[2][i]}")
      end
    end
  end

  def decode_message
    braille_message = FileIO.read(filename)
    by_lines(braille_message).each_with_object("") do |line, string|
      string << "#{decode_line(line)}"
    end
  end

  def terminal_output
    FileIO.write(new_filename, decode_message)
    "Created '#{new_filename}' containing #{decode_message.length} characters."
  end
end


night_reader = NightReader.new
puts night_reader.terminal_output unless ARGV[0] == "spec"