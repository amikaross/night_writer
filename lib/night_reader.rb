require "./lib/file_i_o"
require "./lib/translator"

class NightReader < Translator
  def initialize
    super
  end

  def by_lines(string)
    if string.include?("\n\n")
      string.split("\n\n") 
    else 
      string.split("\n").each_slice(3).map { |slice| slice.join("\n") }
    end
  end 

  def decode_char(string)
    plain_char = dictionary.key(string.split("\n"))
  end

  def split_into_rows(line)
    line.split("\n").map { |row| row.chars.each_slice(2).map(&:join) }
  end

  def capitalized_signal?(rows, index)
    rows[0][index] == ".." && rows[1][index] == ".." && rows[2][index] == ".0"
  end

  def after_capitalized_signal?(rows, index)
    capitalized_signal?(rows, index - 1)
  end

  def number_signal?(rows, index)
    rows[0][index] == ".0" && rows[1][index] == ".0" && rows[2][index] == "00"
  end

  def after_number_signal?(rows, index)
    number_signal?(rows, index - 1)
  end

  def after_signal(rows, index)
    if after_capitalized_signal?(rows, index)
      decode_char("#{rows[0][index]}\n#{rows[1][index]}\n#{rows[2][index]}").upcase
    else 
      dictionary.key(decode_char("#{rows[0][index]}\n#{rows[1][index]}\n#{rows[2][index]}"))
    end
  end

  def decode_line(line)
    rows = split_into_rows(line)
    (0..(rows[0].length - 1)).each_with_object("") do |i, string| 
      next if (capitalized_signal?(rows, i) || number_signal?(rows, i))
      if after_capitalized_signal?(rows, i) || after_number_signal?(rows, i)
        string << after_signal(rows, i)
      else 
        string << decode_char("#{rows[0][i]}\n#{rows[1][i]}\n#{rows[2][i]}")
      end
    end
  end

  def decode_message
    braille_message = FileIO.read(filename)
    message = by_lines(braille_message).each_with_object("") do |line, string|
      string << "#{decode_line(line)}"
    end
    @message_length = message.length
    message.scan(/.{1,80}/).join("\n")
  end

  def run 
    terminal_output(decode_message)
  end
end


night_reader = NightReader.new
puts night_reader.run unless ARGV[0] == "spec"