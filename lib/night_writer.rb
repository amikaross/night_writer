#write a ruby program that prints a line to the terminal:
#ruby ./lib/night_writer.rb message.txt braille.txt 
#Created 'braille.txt' containing 256 characters


message = File.read(ARGV[0])

puts "Created '#{ARGV[1]}' containing #{message.length} characters"



