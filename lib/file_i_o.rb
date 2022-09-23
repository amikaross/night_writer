class FileIO
  def self.read(filename)
    File.read(filename)
  end

  def self.write(filename, text)
    new_file = File.open(filename, "w")
    new_file.write(text)
    new_file.close
  end
end