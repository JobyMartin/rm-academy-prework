
# class to represent a Queen piece
class Queen < Piece
  attr_accessor :position

  def initialize(color, position)
    symbol = color == :white ? " \u2655" : " \u265B"
    super(color, position, symbol)
  end

  def valid_moves(board)
    directions = [
      [-1, 0], 
      [1, 0], 
      [0, -1], 
      [0, 1],
      [1, 1],
      [1, -1],
      [-1, 1],
      [-1, -1]
    ]

    ray_moves(board, directions)
  end
end