require_relative '../lib/scrabble_input'
describe ScrabbleInput, "#scrabble tiles input" do
  before do
   @game = Scrabble.new("bin/input.json")
   @tiles = @game.game_inputs["tiles"]
   @words = @game.game_inputs["dictionary"]
   @valued_tiles = @game.tiles_to_values(@tiles)
   @available_words = @game.pruned_words(@tiles, @words)
  end
  
    it "initializes a scrabble_tiles method" do
      @game.class.should == Scrabble
    end
  
    it "Properly interprets the JSON file" do
      @game.game_inputs["tiles"].should == [
        "a2", "a2", "a2", "i4", "w5", "n1", "r12", 
        "e1", "g6", "f7", "s2", "e1", "l7", "t8", 
        "r12", "l7", "h8", "n1", "f7", "b8", "r12", 
        "a2", "u9", "g6", "i4", "t8", "l7", "q9", 
        "o3", "d2", "s2", "f7", "n1", "u9"]
    end
end