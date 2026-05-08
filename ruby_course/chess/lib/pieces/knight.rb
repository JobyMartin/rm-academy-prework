
# class to represent a Knight piece
class Knight < Piece
  attr_accessor :position

  def initialize(color, position)
    symbol = color == :white ? " \u2658" : " \u265E"
    super(color, position, symbol)
  end

  def valid_moves(board)
    moves = []
    row, col = position
  
    knight_moves = [
      [2, 1], [2, -1], [-2, 1], [-2, -1],
      [1, 2], [1, -2], [-1, 2], [-1, -2]
    ]
  
    knight_moves.each do |delta_row, delta_col|
      new_row, new_col = row + delta_row, col + delta_col
  
      next unless new_row.between?(0, 7) && new_col.between?(0, 7)
  
      target_piece = board[new_row][new_col]
      if target_piece.nil? || target_piece.color != color
        moves << [new_row, new_col]
      end
    end
  
    moves
  end
end
