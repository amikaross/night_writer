class Encoder
  def self.encode_char(char)
    if ("A".."Z").include?(char)
      char = char.downcase
      ["..", "..", ".0"].zip(self.dictionary[char]).map(&:join)
    else 
      self.dictionary.keys.include?(char)
      braille_char = self.dictionary[char]
    end
  end

  def self.decode_char(string)
    plain_char = self.dictionary.key(string.split("\n"))
  end

  def self.encode_line(line)
    braille_chars = line.chars.map { |char| self.encode_char(char) }
    lines = ["", "", ""]
    braille_chars.each do |char_array|
      lines[0] << char_array[0]
      lines[1] << char_array[1]
      lines[2] << char_array[2]
    end
    braille_line = "#{lines[0]}\n#{lines[1]}\n#{lines[2]}\n"
  end

  def self.decode_line(line)
    nested_array = line.split("\n").map { |row| row.chars.each_slice(2).map(&:join) }
    row_length = nested_array[0].length
    (0..row_length - 1).each_with_object("") do |i, string|  
      string << self.decode_char("#{nested_array[0][i]}\n#{nested_array[1][i]}\n#{nested_array[2][i]}")
    end
  end

  def self.dictionary
    dictionary = {
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
                  "'" => ["..", "..", "0."]
                }
  end
end

