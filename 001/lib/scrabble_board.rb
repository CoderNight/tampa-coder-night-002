require 'json'
require_relative 'output'
class ScrabbleBoard

attr_accessor :board
 def initialize filename
   scrabble = JSON.parse(File.read(filename))
   @board = scrabble[          "board"]
 end

 def to_s
   @board
 end
 
 def convert_to_strings
   @array_of_strings = @board.collect do |string|
     string = string.split
   end
 end
 
 def convert_board_to_array
   @board_of_integers = convert_to_strings.map do |array_array|
      array_array.map do |number_string|
        number_string.to_i
      end
   end
 end 
end
