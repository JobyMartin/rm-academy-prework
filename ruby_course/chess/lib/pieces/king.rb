
# class to represent a King piece
class King < Piece
  attr_accessor :position

  def initialize(color, position)
    symbol = color == :white ? " \u2654" : " \u265A"
    super(color, position, symbol)
  end

  def valid_moves(board)
    moves = []
    row, col = position
    opponent_color = color == :white ? :black : :white
    opponent_pieces = board.flatten.compact.select { |p| p.color == opponent_color }

    each_candidate(board) do |new_row, new_col|
      next if opponent_pieces.any? { |p| p.attacked_squares(board).include?([new_row, new_col]) }
      moves << [new_row, new_col]
    end

    moves
  end

  def attacked_squares(board)
    moves = []
    each_candidate(board) { |r, c| moves << [r, c] }
    moves
  end

  private

  def each_candidate(board)
    row, col = position
    directions = [
      [-1, -1], [-1, 0], [-1, 1], [0, -1],
      [0, 1], [1, -1], [1, 0], [1, 1]
    ]

    directions.each do |row_offset, col_offset|
      new_row, new_col = row + row_offset, col + col_offset
      next unless new_row.between?(0, 7) && new_col.between?(0, 7)
      target = board[new_row][new_col]
      next if target && target.color == color
      yield new_row, new_col
    end
  end
end
