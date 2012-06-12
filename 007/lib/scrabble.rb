require 'yaml'

module Scrabble
  HORIZONTAL = 0
  VERTICAL   = 1

  class << self

    def run(input)
      data = load_data(input)
    end

    # A 2D array representing multipliers for each space on the board.
    def game_board(board_source)
      board_source.map { |r| r.split(/\s/).map(&:to_i) }
    end

    # An array of the available letters
    def available_letters(tile_source)
      tile_source.map { |tile| /(\w)/.match(tile)[1] }.sort
    end

    # A list of the words that can be formed from the dictionary for the given tiles
    def possible_words(dictionary, tiles)
      dictionary.reduce([]) do |words, word|
        if can_form?(word, tiles)
          words << word
        else
          words
        end
      end
    end

    # Test if a given word can be formed with the given tiles
    def can_form?(word, available_tiles)
      remaining_tiles = available_tiles.dup
      word.each_char do |character|
        if index = remaining_tiles.index(character)
          remaining_tiles.delete_at(index)
        else
          return false
        end
      end
      true
    end

    # A lookup hash for the values of each tile's letter
    def tile_values(tile_source)
      tile_source.reduce(Hash.new(0)) do |hash, tile|
        _, k, v = */(\w)(\d+)/.match(tile)
        hash[k] = v.to_i
        hash
      end
    end

    # Gives the multiplier for the space on the given board.
    # The row & column aren't the position of the tile; the are starting position
    # of the word, which is then offset by the index in the given direction.
    def multiplier(board, row, column, direction, index)
      if direction == VERTICAL
        board[row + index][column]
      else
        board[row][column + index]
      end
    end

    # Tests if a word fits on the board in the given position and direction.
    def fits?(word, row, column, direction, board)
      if direction == VERTICAL
        word.length + row <= board.length
      else
        word.length + column <= board[0].length
      end
    end

    # Score an opening move.
    def score(word, row, column, direction, values, board)
      word.length.times.reduce(0) do |score, index|
        score + values[word[index]] * multiplier(board, row, column, direction, index)
      end
    end

    # Print a move.
    def format(word, row, column, direction, board)
      formatted = Marshal.load( Marshal.dump(board)) # Here there be hacks.
      word.length.times do |index|
        if direction == VERTICAL
          formatted[row + index][column] = word[index]
        else
          formatted[row][column + index] = word[index]
        end
      end
      formatted.map { |row| row.join(" ") }.join("\n")
    end

    def load_data(input)
      YAML.load(input)
    end
  end
end





