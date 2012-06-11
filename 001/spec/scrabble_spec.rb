require_relative '../lib/scrabble'
describe Scrabble, "#scrabble" do
  
  before do
   @game = Scrabble.new("bin/input.json")
   @valued_tiles = @game.tiles_to_values
   @available_words = @game.pruned_words
  end
  
    it "initializes a scrabble class" do
      @game.class.should == Scrabble
    end
  
    it "Properly interprets the JSON file" do
      @game.tiles.should == [
        "a2", "a2", "a2", "i4", "w5", "n1", "r12", 
        "e1", "g6", "f7", "s2", "e1", "l7", "t8", 
        "r12", "l7", "h8", "n1", "f7", "b8", "r12", 
        "a2", "u9", "g6", "i4", "t8", "l7", "q9", 
        "o3", "d2", "s2", "f7", "n1", "u9"]
    end
    
    it "creates a hash of tile values" do 
      @valued_tiles["l"].should == 7
    end
    
    it "picks out the available letters" do
      @letters  = @game.available_letters
      @letters[0].should == ("a")
    end
    
    it "prunes the dictionary based on the available tiles" do
      @available_words[0].should == "sustalo"
    end
    
    it "converts possible words into arrays of values" do
      value_array = @game.words_as_values(@available_words, @valued_tiles)
      value_array[0] == [2,9,2,8,2,7,3]
    end    
end