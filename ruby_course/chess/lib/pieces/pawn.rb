require_relative "../piece"

# class to represent a Pawn piece
class Pawn < Piece
  attr_accessor :position

  def initialize(color, position)
    symbol = color == :white ? " \u2659" : " \u265F"
    super(color, position, symbol)
  end

  def valid_moves(board)
    moves = []
    row, col = position

    direction = color == :white ? -1 : 1
    start_row = color == :white ? 6 : 1

    # forward one
    forward_one = [row + direction, col]
    if forward_one[0].between?(0, 7) && board[forward_one[0]][forward_one[1]].nil?
      moves << forward_one

      # forward two from starting row
      forward_two = [row + 2 * direction, col]
      if row == start_row && board[forward_two[0]][forward_two[1]].nil?
        moves << forward_two
      end
    end

    # diagonal captures
    [[row + direction, col - 1], [row + direction, col + 1]].each do |r, c|
      next unless r.between?(0, 7) && c.between?(0, 7)
      target = board[r][c]
      moves << [r, c] if target && target.color != color
    end

    moves
  end
end