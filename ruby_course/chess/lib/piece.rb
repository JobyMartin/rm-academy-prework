
# class to represent a chess piece
class Piece
  attr_reader :color, :position, :symbol

  def initialize(color, position, symbol)
    @color = color
    @position = position
    @symbol = symbol
  end

  def ray_moves(board, directions)
    moves = []
    row, col = position

    directions.each do |row_step, col_step|
      new_row, new_col = row + row_step, col + col_step

      while new_row.between?(0, 7) && new_col.between?(0, 7)
        piece = board[new_row][new_col]

        if piece.nil?
          moves << [new_row, new_col]
        else
          moves << [new_row, new_col] if piece.color != color
          break
        end

        new_row += row_step
        new_col += col_step
      end
    end

    moves
  end

  def valid_moves(board)
    # To be implemented by subclasses
    []
  end

  def attacked_squares(board)
    valid_moves(board)
  end
end
