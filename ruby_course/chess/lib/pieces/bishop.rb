
# class to represent a Bishop piece
class Bishop < Piece
  attr_accessor :position

  def initialize(color, position)
    symbol = color == :white ? " \u2657" : " \u265D"
    super(color, position, symbol)
  end

  def valid_moves(board)
    directions = [
      [1, 1],
      [1, -1],
      [-1, 1],
      [-1, -1]
    ]

    ray_moves(board, directions)
  end
end