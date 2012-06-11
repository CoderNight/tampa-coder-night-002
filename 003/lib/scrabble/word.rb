module Scrabble
  class Word < String
    def letters
      scan(/.{1}/)
    end

    def tiles
      letters.map {|letter| TileCollection.find(letter)}
    end

    def value
      tiles.inject(0) {|sum, tile| sum += tile.value}
    end

    def invalid?
      !(letters - TileCollection.letters).empty?
    end
  end
end