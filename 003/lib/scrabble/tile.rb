module Scrabble
  class Tile
    attr_accessor :letter, :value

    def initialize(val)
      self.letter = val.scan(/.{1}/).first
      self.value = val.scan(/\d+/).first.to_i
    end
  end
end