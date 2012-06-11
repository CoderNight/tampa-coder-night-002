require_relative 'lib/scrabble'

if ARGV.size < 1
  puts "Usage: scrabble /path/to  /input"
else
  reader = ScrabbleReader.new(File.read(ARGV[0]))
  game = ScrabbleGame.new(reader.board, reader.dictionary, reader.tiles)

  puts ScrabblePrinter.new(game)
end