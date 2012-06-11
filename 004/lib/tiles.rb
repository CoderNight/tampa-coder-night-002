#   _____ _ _           
#  |_   _(_) | ___  ___ 
#    | | | | |/ _ \/ __|
#    | | | | |  __/\__ \
#    |_| |_|_|\___||___/
#
class Tiles

  def initialize tiles = []
    @tiles=tiles.inject({}) do |scores,tile|
      add_tile(scores,tile)
    end
  end

  def add_tile scores, tile
    letter=tile.slice!(0,1)
    scores[letter] = [] if ! scores[letter]
    scores[letter] << tile.to_i
    scores
  end

  def have? letter
    @tiles.has_key?(letter) && ! @tiles[letter].empty?
  end

  def use letter
    @tiles[letter].shift if have?(letter)
  end

  def scores letter
    @tiles[letter]
  end

  def add_score scores, letter
    score=use(letter)
    scores << score if score
    scores
  end

  def clone
    Marshal.load( Marshal.dump(self) )
  end

end
