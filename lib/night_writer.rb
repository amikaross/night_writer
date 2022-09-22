require "./lib/file_reader"

class NightWriter
  attr_reader :reader,
              :filename

  def initialize(file)
    @reader = FileReader.new.read(file)
    @filename = ARGV[1]
  end

  # def encode_file_to_braille

  # end

  # def encode_to_braille(input)

  # end

  def cli 
    "Created '#{filename}' containing #{reader.length} characters"
  end
end

night_writer = NightWriter.new(ARGV[0])
puts night_writer.cli
