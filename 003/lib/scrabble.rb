require 'RubyGems'
require 'JSON'

require "#{File.dirname(__FILE__)}/scrabble/game"
require "#{File.dirname(__FILE__)}/scrabble/dictionary"
require "#{File.dirname(__FILE__)}/scrabble/word"
require "#{File.dirname(__FILE__)}/scrabble/tile"
require "#{File.dirname(__FILE__)}/scrabble/tile_collection"
require "#{File.dirname(__FILE__)}/scrabble/board"

input = File.read "#{File.dirname(__FILE__)}/../INPUT.json"
@g = Scrabble::Game.new JSON.parse input
@g.opening_move.each {|row| p row}