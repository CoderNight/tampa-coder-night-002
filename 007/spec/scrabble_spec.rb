require 'scrabble'

describe Scrabble do
  let(:fixtures)       { File.dirname(__FILE__) + '/fixtures/' }
  let(:example_input)  { File.open(fixtures + 'EXAMPLE_INPUT.json') }
  let(:example_output) { File.open(fixtures + 'EXAMPLE_OUTPUT.txt') }
  let(:example_data)   { Scrabble.load_data(example_input) }

  it "has a board" do
    given    = ["1 1 2 1", "2 1 1 1"]
    expected = [[1, 1, 2, 1], [2, 1, 1, 1]]

    Scrabble.game_board(given).should == expected
  end

  it "has tiles available" do
    given    = %w[c2 b1 c2 e1 a1]
    expected = %w[a b c c e]

    Scrabble.available_letters(given).should == expected
  end

  it "has values" do
    given    = %w[c2 b1 c2 e1 a1]
    expected = { "a" => 1, "b" => 1, "c" => 2, "e" => 1 }

    Scrabble.tile_values(given).should == expected
  end

  context "checking tiles" do
    let(:dictionary) { %w[gyre gimble wabe mimsy borogoves] }
    let(:tiles)      { %w[b g e i l m o o o r s v y] }

    it "has possible dictionary words" do
      expected = %w[gyre gimble borogoves]
      Scrabble.possible_words(dictionary, tiles).should == expected
    end

    it "can test if tiles form a word" do
      Scrabble.can_form?("borogoves", tiles).should be_true
    end

    it "can test if tiles don't form a word" do
      Scrabble.can_form?("mimsy", tiles).should be_false
    end

    context "and thier scores" do
      let(:values) { Scrabble.tile_values(example_data["tiles"]) }
      let(:board)  { Scrabble.game_board(example_data["board"]) }
      let(:word)   { "whiffling" }

      it "can test if a word doesn't fit on the board" do |variable|
        Scrabble.fits?(word, 2, 4, Scrabble::HORIZONTAL, board).should be_false
      end

      it "can sum a word's value on the board horizontally" do
        score = Scrabble.score(word, 2, 2, Scrabble::HORIZONTAL, values, board)
        score.should == 65
      end

      it "can sum a word's value on the board vertically" do
        score = Scrabble.score(word, 0, 0, Scrabble::VERTICAL, values, board)
        score.should == 52
      end
    end
  end

  context "with the given example input" do

    it "should match the example output" do
      pending "End Game"
      Scrabble.run(example_input).should equal(example_output.read)
    end
  end
end
