module Scrabble
  class Game
    def initialize(params = {})
      @dictionary = Dictionary.new(params["dictionary"])
      @tiles = TileCollection.new(params["tiles"])
      @board = Board.new(params["board"])
    end

    def dictionary
      @dictionary
    end

    def tiles
      @tiles
    end

    def board
      @board
    end

    def best_word
      dictionary.most_valuable_word
    end

    def best_position(word)
      @board.place_in_best_position!(word)
    end

    def opening_move
      best_position(best_word)
    end
  end
end