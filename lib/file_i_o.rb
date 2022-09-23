class FileIO
  def read(filename)
    File.read(filename)
  end

  def write(filename, text)
    new_file = File.open(filename, "w")
    new_file.write(text)
    new_file.close
  end
end