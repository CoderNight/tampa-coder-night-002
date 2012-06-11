class ScrabbleGame
  attr_accessor :board

  def initialize(board, dictionary, tiles)
    @board = board
    @dictionary = dictionary
    @tiles = tiles
  end

  def max_score
    @dictionary.map { |word| max_score_for_word(word) }.compact.max_by(&:score)
  end

  def max_score_for_word(word)
    scores(word).max
  end

  def scores(word)
    (0...@board.width).map { |x|
      (0...@board.height).map { |y|
        [
          ScrabbleWordPlacement.new(:word => word, :direction => :horizontal, :x => x, :y => y, :score => score_horizontal(word, x,y)),
          ScrabbleWordPlacement.new(:word => word, :direction => :vertical, :x => x, :y => y, :score => score_vertical(word, x, y)),
        ]
      }
    }.flatten.reject(&:illegal?)
  end

  def score_horizontal(word, x, y)
    if valid_word_in_horizontal_position?(word, x, y)
      sum_of_title_score_for_word(word) { |index| @board[x + index, y] }
    else
      ScrabbleWordPlacement::ILLEGAL
    end
  end

  def score_vertical(word, x, y)
    if valid_word_in_vertical_position?(word, x, y)
      sum_of_title_score_for_word(word) { |index| @board[x, y + index] }
    else
      ScrabbleWordPlacement::ILLEGAL
    end
  end

  def legal_horizontal_placement?(word, x, y)
    board.legal_horizontal_placement?(word,x,y)
  end

  def legal_vertical_placement?(word, x, y)
    board.legal_vertical_placement?(word, x, y)
  end

  def composed_of_legal_tiles?(word)
    word_chars_count = word.chars.group_by { |char| char }

    word.chars.all? { |char| word_chars_count[char].size <= @tiles.count_for(char) }
  end

  def in_dictionary?(word)
    @dictionary.include?(word)
  end

  protected

  def valid_word_in_vertical_position?(word, x, y)
    in_dictionary?(word) && legal_vertical_placement?(word, x, y) && composed_of_legal_tiles?(word)
  end

  def valid_word_in_horizontal_position?(word, x, y)
    in_dictionary?(word) && legal_horizontal_placement?(word, x, y) && composed_of_legal_tiles?(word)
  end

  def sum_of_title_score_for_word(word)
    sum = 0
    word.chars.each.with_index { |char, index| sum += @tiles.score_for(char) * yield(index) }
    sum
  end
end
