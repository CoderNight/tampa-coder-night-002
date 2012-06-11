class ScrabblePrinter
  def initialize(game)
    @game      = game
    @max_score = game.max_score
  end

  def to_s
    fill_max_score_word
    game_board_as_array.map { |board_row| board_row.join(" ") }.join("\n")
  end

  protected

  def fill_max_score_word
    x_multiplier = @max_score.direction == :horizontal ? 1 : 0
    y_multiplier = @max_score.direction == :vertical ? 1 : 0

    @max_score.word.length.times do |index|
      game_board_as_array[@max_score.y + index * y_multiplier][@max_score.x + index * x_multiplier] = @max_score.word[index]
    end
  end

  def game_board_as_array
    @game_board_as_array ||= @game.board.to_a
  end
end
