class FileReader
  def read(arg)
    filename = arg
    File.read(filename)
  end
end