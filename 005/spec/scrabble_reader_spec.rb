require_relative '../lib/scrabble_reader'

describe ScrabbleReader do
  let(:simple_input) { %-

      {
        "board": [
            "1 7 9 4 2",
            "5 3 8 3 4",
            "1 1 1 1 1",
            "1 2 1 2 6"
        ],
        "dictionary": [
          "word",
          "otherword",
          "word",
          "lastword"
        ],
        "tiles" : [
          "i4",
          "b1",
          "z9",
          "b1",
          "q8"
        ]
      }

    -
  }

  it "produces a game board of the correct width and height" do
    reader = ScrabbleReader.new(simple_input)

    reader.board.width.should == 5
    reader.board.height.should == 4
  end

  it "produces a game board with the correct multiplication_factors" do
    board = ScrabbleReader.new(simple_input).board

    board[0,0].should == 1
    board[1,0].should == 7
    board[4,0].should == 2
    board[0,1].should == 5
    board[2,1].should == 8
    board[4,3].should == 6
  end

  it "produces a unique list of words" do
    dictionary = ScrabbleReader.new(simple_input).dictionary

    dictionary.should =~ %w{word otherword lastword}
  end

  it "produces a hash of tile letter to scores" do
    tiles = ScrabbleReader.new(simple_input).tiles

    tiles.score_for("i").should == 4
    tiles.count_for("i").should == 1

    tiles.score_for("b").should == 1
    tiles.count_for("b").should == 2

    tiles.score_for("z").should == 9
    tiles.count_for("z").should == 1

    tiles.score_for("q").should == 8
    tiles.count_for("q").should == 1
  end
end
