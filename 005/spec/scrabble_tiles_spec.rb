require_relative '../lib/scrabble_tiles'

describe ScrabbleTiles do
  it "records scores and counts for tiles" do
    tiles = ScrabbleTiles.new
    tiles.add_tile("i", 4)
    tiles.add_tile("b", 1)
    tiles.add_tile("b", 1)
    tiles.add_tile("z", 9)
    tiles.add_tile("q", 8)

    tiles.score_for("i").should == 4
    tiles.count_for("i").should == 1

    tiles.score_for("b").should == 1
    tiles.count_for("b").should == 2

    tiles.score_for("z").should == 9
    tiles.count_for("z").should == 1

    tiles.score_for("q").should == 8
    tiles.count_for("q").should == 1

    tiles.count_for("o").should == 0
  end
end
