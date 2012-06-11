require_relative '../lib/scrabble'
require 'json'

describe Scrabble do
  describe '#available_words' do
    it 'returns the list of usable words given a set of tiles' do
      words = ['foo', 'bar', 'foe']
      tiles = ['f', 'o', 'e']
      Scrabble.available_words(words, tiles).should == ['foe']
    end
  end

  describe Scrabble::Game do
    let(:game) {
      ex_input = File.join(File.dirname(__FILE__), '../support/ex_input.json')
      Scrabble.new_game(ex_input)
    }
    let(:ex_output) {
      output = File.read(File.join(File.dirname(__FILE__), '../support/ex_output.txt'))
      output.split("\n")
    }

    it 'plays the best first move' do
      game.play(game.best_move)
      game.to_s.should == ex_output
    end

    describe '#best_move' do
      it 'calculates the best first move' do
        game.best_move.should == ['whiffling', 2, 2, 65]
      end
    end

    describe '#best_score_and_position_for_row' do
      it 'returns the best position for a word' do
        row = ['1','2', '1', '1', '1', '3', '1', '1', '1', '1', '2', '1']
        word = 'whiffling'
        game.best_score_and_position_for_row(row, word).should == [65, 2]
      end
    end

    describe '#calculate_score_for_spaces_and_word' do
      it 'returns the score for the given spaces and word' do
        spaces = ['1', '2', '1', '1', '1', '3', '1', '1', '1']
        word = 'whiffling'
        game.calculate_score_for_spaces_and_word(spaces, word).should == 59
      end
    end
  end
end

