#   ____           _ _   _             
#  |  _ \ ___  ___(_) |_(_) ___  _ __  
#  | |_) / _ \/ __| | __| |/ _ \| '_ \ 
#  |  __/ (_) \__ \ | |_| | (_) | | | |
#  |_|   \___/|___/_|\__|_|\___/|_| |_|
#
class Position

  attr_accessor :orientation, :score, :word, :x, :y

  def self.new_parameterized orientation, score, word, x, y
    Position.new({
        :orientation => orientation,
              :score => score,
               :word => word,
                  :x => x,
                  :y => y
    })
  end

  def self.find_optimal board, dictionary
    dictionary.words.inject(Position.new) do |position, word|
      position=board.optimal_position_for_word(word)
    end
  end

  def initialize position = {}
    @position=position
    position.each_pair do |key, value|
      self.send "#{key.to_s}=".to_sym, value
    end
  end

  def attributes
    @position
  end

end
