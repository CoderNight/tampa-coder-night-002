require_relative '../lib/scrabble'
require_relative '../lib/output'

describe ScrabbleBoard, "#scrabble board" do
  
  before do
    @game = Scrabble.new("bin/input.json")
    @board = ScrabbleBoard.new("bin/input.json")
    @array_board = @board.convert_board_to_array
  end
  
  it "has a class called ScrabbleBoard" do
   p @board.class.should == ScrabbleBoard
  end
  
  it "Prints out a board as an array" do
    @board.to_s.should ==
     
    ["1 1 1 1 2 1 1 1 3 1 1 1",
     "1 1 1 1 4 1 1 1 1 2 1 2",
     "1 1 1 1 1 1 1 1 1 1 1 1",
     "1 2 1 2 1 1 1 1 1 1 1 1",
     "1 1 1 1 1 1 1 1 1 3 1 3",
     "1 1 1 1 1 1 1 1 1 1 1 1", 
     "1 3 1 1 1 1 1 2 2 2 1 1", 
     "1 1 1 2 1 2 1 1 1 1 1 2", 
     "1 1 1 1 1 1 1 1 1 1 1 1"]
    
  end
  
  it "Becomes and array of arrays" do
    @array_board.should ==
    [[1, 1, 1, 1, 2, 1, 1, 1, 3, 1, 1, 1],
     [1, 1, 1, 1, 4, 1, 1, 1, 1, 2, 1, 2],
     [1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1],
     [1, 2, 1, 2, 1, 1, 1, 1, 1, 1, 1, 1],
     [1, 1, 1, 1, 1, 1, 1, 1, 1, 3, 1, 3],
     [1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1], 
     [1, 3, 1, 1, 1, 1, 1, 2, 2, 2, 1, 1], 
     [1, 1, 1, 2, 1, 2, 1, 1, 1, 1, 1, 2], 
     [1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1]]
  end

  it "places a word starting at [0][3] going right and calculates the value" do
    @game.place_a_word_horiz(@array_board,0,0,3).should == 56
  end
  
  it "places a word vertically" do
    @game.place_a_word_vert(@array_board,0,0,4).should == 62
  end
  
  it "returns 0 if it is off the board horizontally" do
    @game.place_a_word_horiz(@array_board,0,0,7).should == 0
  end
  
  it "returns 0 if it is off the board vertically" do
    @game.place_a_word_vert(@array_board,0,8,0).should == 0
  end
  
  context "the words are placed" do
    before do
      @game = Scrabble.new("bin/input.json")
      @board = ScrabbleBoard.new("bin/input.json")
      @array_board = @board.convert_board_to_array
      @final_array = @game.place_each_word_on_board(@array_board)
    end
    it "returns every possible word placement" do
      @final_array.size.should == 1080
    end
  
    it "doesn't return any results with a score of zero" do
      @game.remove_zero_scores(@final_array).sample.score.should_not == 0
    end
  end
end
