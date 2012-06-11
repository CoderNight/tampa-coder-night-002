#   ____                      _ 
#  | __ )  ___   __ _ _ __ __| |
#  |  _ \ / _ \ / _` | '__/ _` |
#  | |_) | (_) | (_| | | | (_| |
#  |____/ \___/ \__,_|_|  \__,_|
#
class Board

  attr_reader :dictionary

  def initialize board
    @board=board
  end

  def use_dictionary! dictionary
    @optimal_score=0
    @optimal_position=nil
    @dictionary=dictionary
  end

  def to_array
    @board.inject([]) { |board,row| board << split_row(row) }
  end

  def split_row row
    row.to_s.split(/ /).map { |cell| cell.to_i }
  end

  def optimal_position_for_word word
    [:horizontally, :vertically].each do |orientation|
      scan_board_orientation orientation, word
    end
    @optimal_position
  end

  def render position
    board_arrays=to_array
    board_arrays=rotate_board_arrays_to_orientation(board_arrays, position.orientation)
    board_arrays=apply_word_to_board_arrays(board_arrays, position)
    board_arrays=unrotate_board_arrays_to_orientation(board_arrays, position.orientation)
    board_arrays_to_board_text(board_arrays)
  end

private

  def scan_board_orientation orientation, word
    scan_board(orientation, word) do |position|
      keep_optimal_position position
    end
  end

  def keep_optimal_position position
    if position.score > @optimal_score
      @optimal_score = position.score
      @optimal_position = position
    end
  end

  def get_board_array_with_orientation orientation
    board=to_array
    board=rotate_counter_clockwise(board) if orientation == :vertically
    board
  end

  def scan_board orientation, word
    board=get_board_array_with_orientation(orientation)
    board.size.times do |y|
      find_word_scores_in_row(board[y], y, orientation, word) do |position|
        yield position
      end
    end
  end

  def find_word_scores_in_row row, y, orientation, word
    (row.size-word.length).times do |x|
      score=calculate_word_score(row, x, word)
      yield Position.new_parameterized(orientation, score, word, x, y)
    end
  end

  def calculate_word_score row, x, word
    calculate_segment_score(row[x,word.length],@dictionary.word_to_scores(word))
  end

  def calculate_segment_score board_segment_array, word_score_array
    score_final=board_segment_array.inject(0) do |score, board_multiplier|
      letter_score=word_score_array.shift
      score+=letter_score*board_multiplier
    end
  end


  def board_arrays_to_board_strings board_arrays
    board_arrays.map { |row| row.join "" }
  end

  def board_strings_to_board_arrays board_strings
    board_strings.map { |line| line.split // }
  end

  def apply_word_to_board_arrays board_arrays, position
    board_strings=board_arrays_to_board_strings(board_arrays)
    apply_word_to_board_strings board_strings, position
    board_strings_to_board_arrays(board_strings)
  end

  def apply_word_to_board_strings board_strings, position
    word=position.word
    x=position.x
    l=x+word.length-1
    board_strings[position.y][x..l]=word
  end

  def board_arrays_to_board_text board_arrays
    board_arrays.map { |row| row.join(" ") }.join("\n")
  end

  def rotate_board_arrays_to_orientation board_arrays, orientation
    return board_arrays if orientation == :horizontally
    rotate_counter_clockwise(board_arrays)
  end

  def unrotate_board_arrays_to_orientation board_arrays, orientation
    return board_arrays if orientation == :horizontally
    rotate_clockwise(board_arrays)
  end

  def rotate_counter_clockwise board
    board.transpose.reverse
  end

  def rotate_clockwise board
    board.reverse.transpose
  end

end
