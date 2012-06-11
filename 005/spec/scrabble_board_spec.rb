require_relative '../lib/scrabble_board'

describe ScrabbleBoard do
  subject do
    board = ScrabbleBoard.new

    board[0,0] = 1
    board[1,0] = 3
    board[0,1] = 2
    board[1,1] = 4

    board
  end

  it "can convert itself to an array" do
    subject.to_a.should == [[1,3],[2,4]]
  end

  it "has a specific width and height of squares" do
    subject.width.should  == 2
    subject.height.should == 2
  end

  it "has a multiplication factor for each square" do
    subject[0,1].should == 2
    subject[1,1].should == 4
  end

  it "determines a horizontal placed word within the board is valid" do
    subject.legal_horizontal_placement?("at", 0, 0).should be_true
  end

  it "determines a horizontal placed word that extends beyond the board is valid" do
    subject.legal_horizontal_placement?("at", 1, 0).should be_false
  end

  it "determines a vertically placed word within the board is valid" do
    subject.legal_vertical_placement?("at", 0, 0).should be_true
  end

  it "determines a vertically placed word that extends beyond the board is valid" do
    subject.legal_vertical_placement?("at", 0, 1).should be_false
  end
end
