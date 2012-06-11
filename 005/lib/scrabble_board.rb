class ScrabbleBoard
  attr_reader :width, :height

  def initialize
    @width  = 0
    @height = 0
    @multiplication_factors = {}
  end

  def to_a
    (0...@height).map { |y| (0...@width).map { |x| self[x,y] } }
  end

  def []=(x,y, multiplication_factor)
    @width = [@width, x + 1].max
    @height = [@height, y + 1].max
    @multiplication_factors[[x,y]] = multiplication_factor
  end

  def [](x,y)
    @multiplication_factors[[x,y]]
  end

  def legal_horizontal_placement?(word, x, y)
    x + word.length <= width
  end

  def legal_vertical_placement?(word, x, y)
    y + word.length <= height
  end

end
