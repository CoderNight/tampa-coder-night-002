require_relative '../lib/scrabble_printer'

describe ScrabblePrinter do
  let(:game) do
    board = ScrabbleBoard.new
    board[0,0] = 1
    board[1,0] = 3
    board[0,1] = 2
    board[1,1] = 4

    dictionary = %w{by at xy}

    tiles = ScrabbleTiles.new
    tiles.add_tile("a", 5)
    tiles.add_tile("b", 12)
    tiles.add_tile("t", 13)
    tiles.add_tile("y", 22)

    ScrabbleGame.new(board, dictionary, tiles)
  end

  it "prints a scrabble board" do
    results = <<OUTPUT
1 b
2 y
OUTPUT
    ScrabblePrinter.new(game).to_s.should == results.chomp
  end
end
