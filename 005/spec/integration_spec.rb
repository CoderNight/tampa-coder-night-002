require_relative '../lib/scrabble'

describe "Integration" do
  it "should evalute the board correctly" do
    reader = ScrabbleReader.new(File.read("EXAMPLE_INPUT.json"))
    game = ScrabbleGame.new(reader.board, reader.dictionary, reader.tiles)

    ScrabblePrinter.new(game).to_s.should == File.read("EXAMPLE_OUTPUT.txt")
  end
end