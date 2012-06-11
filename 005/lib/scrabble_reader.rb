require 'json'
require_relative 'scrabble_board'

class ScrabbleReader
  def initialize(data)
    @json_data = JSON.parse(data)
  end

  def board_json
    @json_data["board"]
  end

  def dictionary
    @json_data["dictionary"].uniq
  end

  def tiles
    tiles = ScrabbleTiles.new

    @json_data["tiles"].each do |tile_string|
      tiles.add_tile(tile_string[0], tile_string[1..-1].to_i)
    end

    tiles
  end

  def board
    board = ScrabbleBoard.new
    populate_multiplication_factors(board)
    board
  end

  def populate_multiplication_factors(board)
    board_json.each.with_index do |row, y|
      row.split.each.with_index do |cell, x|
        board[x,y] = cell.to_i
      end
    end
  end
end
