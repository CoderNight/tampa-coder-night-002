require 'ostruct'

class ScrabbleWordPlacement < OpenStruct
  include Comparable

  ILLEGAL = :illegal_word

  def <=>(other)
    score <=> other.score
  end

  def illegal?
    score == ILLEGAL
  end
end
