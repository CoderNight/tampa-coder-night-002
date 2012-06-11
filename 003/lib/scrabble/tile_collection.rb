module Scrabble
  class TileCollection
    def initialize(args)
      self.tiles = args.map {|arg| Tile.new(arg)}
    end

    def self.tiles
      @@tiles
    end

    def self.letters
      @@tiles.map {|tile| tile.letter}
    end

    def tiles=(tile_arr)
      @@tiles = tile_arr
    end

    def tiles
      self.class.tiles
    end

    def letters
      self.class.letters
    end

    def self.find(letter)
      @@tiles.select {|tile| tile.letter == letter}.first
    end
  end
end