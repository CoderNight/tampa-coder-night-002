#!/usr/bin/env ruby

$: << 'lib'

require 'yajl'

require 'tiles'
require 'dictionary'
require 'board'
require 'position'

#   ____                 _     _     _      
#  / ___|  ___ _ __ __ _| |__ | |__ | | ___ 
#  \___ \ / __| '__/ _` | '_ \| '_ \| |/ _ \
#   ___) | (__| | | (_| | |_) | |_) | |  __/
#  |____/ \___|_|  \__,_|_.__/|_.__/|_|\___|
#

class Scrabble

  def run input_file, output_file
    input = read_input_json(input_file)
    output = process(input)
    write_output_board(output_file, output)
  end

  def read_input_json filename
    json = File.new(filename, 'r')
    parser = Yajl::Parser.new(:symbolize_keys => true)
    parser.parse(json)
  end

  def write_output_board filename, board
    output_file = File.open(filename, 'w')
    output_file.write board
    output_file.close
  end

  def process input
    parse input
    reset
    generate
  end

  def parse input
    @tiles=Tiles.new(input[:tiles])
    @dictionary=Dictionary.new(input[:dictionary])
    @board=Board.new(input[:board])
  end

  def reset
    @dictionary.use_tiles! @tiles
    @board.use_dictionary! @dictionary
  end

  def generate
    @board.render Position.find_optimal(@board, @dictionary)
  end

end

class Runner
  def self.run
    ARGV.size == 2 ? carousel : raise(usage)
  end

  def self.usage
    "Invalid Arguments\n\nUsage:\n  scrabble {input file} {output file}\n\n"
  end

  def self.carousel
    scrabble=Scrabble.new
    scrabble.run(ARGV[0], ARGV[1])
  end
end

Runner.run if __FILE__ == $0
