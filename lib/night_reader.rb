require "./lib/file_i_o"
require "./lib/encoder"

class NightReader 
  attr_reader :braille_message,
              :filename
  
  def initialize(file)
    @braille_message = FileIO.read(file)
    @filename = ARGV[1]
  end

  def decode_from_braille
    
  end
end