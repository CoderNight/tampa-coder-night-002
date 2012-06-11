require 'json'

module Scrabble

  def new_game(input)
    input = JSON.parse(File.read(input)) if input.is_a? String
    Game.new(input)
  end

  def available_words(words, tiles)
    letters = tiles.map { |t| t[0] }
    words.select do |word|
      _letters = letters.dup
      word.chars.all? {|c| _letters.slice!(_letters.index(c)) if _letters.index(c)}
    end
  end

  module_function :new_game, :available_words

  class Game
    attr_accessor :tile_scores, :tiles, :dictionary, :available_words, :original_board

    def initialize(json)
      if json['board'].nil? || json['tiles'].nil? || json['dictionary'].nil?
        raise InvalidInputError, 'Must pass valid JSON with board, tiles, and dictionary'
      end
      @original_board = json['board']
      @board = @original_board.map { |row| row.split(/\s/) }
      @tiles = json['tiles']
      @dictionary = json['dictionary']
      @available_words = Scrabble.available_words(@dictionary, @tiles)
      @tile_scores = {}
      @tiles.each do |tile|
        tile_scores[tile[0]] = tile[1].to_i
      end
    end

    def to_s
      @board.map { |row| row.join(' ') }
    end

    def play(move)
      word, row, pos, score = move
      word.chars.each_with_index do |c, i|
        @board[row][pos+i] = c
      end
    end

    def best_move
      best_row = best_pos = best_score = 0
      best_word = @available_words[0]
      @available_words.each do |word|
        best_word_row = best_word_pos = best_word_score = 0
        @board.each_with_index do |row, index|
          score, pos = best_score_and_position_for_row(row, word)
          if score > best_word_score
            best_word_score = score
            best_word_row = index
            best_word_pos = pos
          end
        end
        if best_word_score > best_score
          best_score = best_word_score
          best_row = best_word_row
          best_pos = best_word_pos
          best_word = word
        end
      end
      [best_word, best_row, best_pos, best_score]
    end

    def best_score_and_position_for_row(row, word)
      best_score_pos = current_pos = best_score = 0
      row.each_with_index do |c, i|
        current_pos = i
        if word.length <= row.length - current_pos
          spaces = row[current_pos, word.length + current_pos]
          score = calculate_score_for_spaces_and_word(spaces, word)
          if score > best_score
            best_score = score
            best_score_pos = current_pos
          end
        end
      end
      [best_score, best_score_pos]
    end

    def calculate_score_for_spaces_and_word(spaces, word)
      score = 0
      word.chars.each_with_index do |c, i|
        char_score = @tile_scores[c].to_i
        score += char_score * spaces[i].to_i
      end
      score
    end

    class InvalidInputError < ArgumentError; end

  end

end
