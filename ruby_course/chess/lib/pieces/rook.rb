
# class to represent a Rook piece
class Rook < Piece
  attr_accessor :position

  def initialize(color, position)
    symbol = color == :white ? " \u2656" : " \u265C"
    super(color, position, symbol)
  end

  def valid_moves(board)
    directions = [
      [-1, 0],
      [1, 0],
      [0, -1],
      [0, 1]
    ]

    ray_moves(board, directions)
  end
end
