class ScrabbleTiles
  def initialize
    @tile_scores = {}
    @tile_counts = Hash.new(0)
  end

  def add_tile(letter, score)
    @tile_scores[letter] = score
    @tile_counts[letter] += 1
  end

  def score_for(letter)
    @tile_scores[letter]
  end

  def count_for(letter)
    @tile_counts[letter]
  end
end
