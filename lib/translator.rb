require "./lib/file_i_o"

class Translator
  attr_reader :dictionary,
              :filename,
              :new_filename,
              :message_length

  def initialize
    @filename = ARGV[0]
    @new_filename = ARGV[1]
    @message_length = nil
    @dictionary = {
                    "a" => ["0.", "..", ".."],
                    "b" => ["0.", "0.", ".."],
                    "c" => ["00", "..", ".."],
                    "d" => ["00", ".0", ".."],
                    "e" => ["0.", ".0", ".."],
                    "f" => ["00", "0.", ".."],
                    "g" => ["00", "00", ".."],
                    "h" => ["0.", "00", ".."],
                    "i" => [".0", "0.", ".."],
                    "j" => [".0", "00", ".."],
                    "k" => ["0.", "..", "0."],
                    "l" => ["0.", "0.", "0."],
                    "m" => ["00", "..", "0."],
                    "n" => ["00", ".0", "0."],
                    "o" => ["0.", ".0", "0."],
                    "p" => ["00", "0.", "0."],
                    "q" => ["00", "00", "0."],
                    "r" => ["0.", "00", "0."],
                    "s" => [".0", "0.", "0."],
                    "t" => [".0", "00", "0."],
                    "u" => ["0.", "..", "00"],
                    "v" => ["0.", "0.", "00"],
                    "w" => [".0", "00", ".0"],
                    "x" => ["00", "..", "00"],
                    "y" => ["00", ".0", "00"],
                    "z" => ["0.", ".0", "00"],
                    " " => ["..", "..", ".."],
                    "," => ["..", "0.", ".."],
                    "." => ["..", "00", ".0"],
                    "'" => ["..", "..", "0."],
                    "1" => "a",
                    "2" => "b",
                    "3" => "c",
                    "4" => "d",
                    "5" => "e",
                    "6" => "f",
                    "7" => "g",
                    "8" => "h",
                    "9" => "i",
                    "0" => "j"
                  }
  end

  def to_alpha(number)
    dictionary[number]
  end

  def terminal_output(new_message)
    FileIO.write(new_filename, new_message)
    "Created '#{new_filename}' containing #{message_length} characters."
  end
end

