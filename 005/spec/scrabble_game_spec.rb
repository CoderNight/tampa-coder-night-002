require_relative '../lib/scrabble_game'
require_relative '../lib/scrabble_board'
require_relative '../lib/scrabble_tiles'

describe ScrabbleGame do
  subject do
    board = ScrabbleBoard.new
    board[0,0] = 1
    board[1,0] = 3
    board[0,1] = 2
    board[1,1] = 4

    dictionary = %w{by at xy aa}

    tiles = ScrabbleTiles.new
    tiles.add_tile("a", 5)
    tiles.add_tile("b", 12)
    tiles.add_tile("t", 13)
    tiles.add_tile("y", 22)

    ScrabbleGame.new(board, dictionary, tiles)
  end

  it "can determine if a word is in the dictionary" do
    subject.in_dictionary?("at").should be_true
    subject.in_dictionary?("notexist").should be_false
  end

  it "can determine if a word is made up of legal tiles" do
    subject.composed_of_legal_tiles?("at").should be_true
    subject.composed_of_legal_tiles?("aa").should be_false
    subject.composed_of_legal_tiles?("xy").should be_false
  end

  describe "scoring" do
    it "rejects a word comprised of more tiles than exist to be used" do
      subject.score_horizontal("aa", 0, 0).should == ScrabbleWordPlacement::ILLEGAL
      subject.score_vertical("aa", 0, 0).should == ScrabbleWordPlacement::ILLEGAL
    end

    it "rejects a word containing characters not in the list of tiles" do
      subject.score_horizontal("xy", 0, 0).should == ScrabbleWordPlacement::ILLEGAL
      subject.score_vertical("xy", 0, 0).should == ScrabbleWordPlacement::ILLEGAL
    end

    it "rejects a word not in the dictionary" do
      subject.score_horizontal("notexist", 0, 0).should == ScrabbleWordPlacement::ILLEGAL
      subject.score_vertical("notexist", 0, 0).should == ScrabbleWordPlacement::ILLEGAL
    end

    it "rejects a legal word that doesn't fit on the board horizontally" do
      subject.score_horizontal("at", 1, 0).should == ScrabbleWordPlacement::ILLEGAL
    end

    it "rejects a legal word that doesn't fit on the board vertically" do
      subject.score_vertical("at", 0, 1).should == ScrabbleWordPlacement::ILLEGAL
    end

    it "can score a word placed horizontally on the board" do
      # 1 * 5 + 3 * 13
      subject.score_horizontal("at", 0, 0).should == 44

      # 2 * 12 + 4 * 22
      subject.score_horizontal("by", 0, 1).should == 112
    end

    it "can score a word placed vertically on the board" do
      # 1 * 5 + 2 * 13
      subject.score_vertical("at", 0, 0).should == 31

      # 3 * 12 + 4 * 22
      subject.score_vertical("by", 1, 0).should == 124
    end

    it "can return all valid scores for a word" do
      word = "at"
      subject.scores(word).should =~ [ScrabbleWordPlacement.new(:word => word, :direction => :horizontal, :x => 0, :y => 0, :score => subject.score_horizontal(word,0,0)),
                                      ScrabbleWordPlacement.new(:word => word, :direction => :horizontal, :x => 0, :y => 1, :score => subject.score_horizontal(word,0,1)),
                                      ScrabbleWordPlacement.new(:word => word, :direction => :vertical,   :x => 0, :y => 0, :score => subject.score_vertical(word,0,0)),
                                      ScrabbleWordPlacement.new(:word => word, :direction => :vertical,   :x => 1, :y => 0, :score => subject.score_vertical(word,1,0)),
                                    ]
    end

    it "can return the maximum score for a word" do
      subject.max_score_for_word("at").should == ScrabbleWordPlacement.new(:word => "at", :direction => :vertical, :x => 1, :y => 0, :score => 67)
      subject.max_score_for_word("by").should == ScrabbleWordPlacement.new(:word => "by", :direction => :vertical, :x => 1, :y => 0, :score => 124)
      subject.max_score_for_word("xy").should == nil
    end

    it "can return the max score for all words" do
      subject.max_score.should == ScrabbleWordPlacement.new(:word => "by", :direction=>:vertical, :x => 1, :y => 0, :score => 124)
    end
  end
end
