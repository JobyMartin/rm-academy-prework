require_relative 'pieces/pawn'
require_relative 'pieces/rook'
require_relative 'pieces/knight'
require_relative 'pieces/bishop'
require_relative 'pieces/queen'
require_relative 'pieces/king'

# class to represent a chess board
class Board
  WHITE_SQUARE_COLOR = "\e[47m"
  BLACK_SQUARE_COLOR = "\e[40m"
  RESET_COLOR = "\e[0m"

  def initialize
    @board = Array.new(8) { Array.new(8) }
    setup_initial_pieces
  end

  def setup_initial_pieces
    8.times do |i|
      @board[1][i] = Pawn.new(:black, [1, i])
      @board[6][i] = Pawn.new(:white, [6, i])
    end

    @board[0][0] = Rook.new(:black, [0, 0])
    @board[0][1] = Knight.new(:black, [0, 1])
    @board[0][2] = Bishop.new(:black, [0, 2])
    @board[0][3] = Queen.new(:black, [0, 3])
    @board[0][4] = King.new(:black, [0, 4])
    @board[0][5] = Bishop.new(:black, [0, 5])
    @board[0][6] = Knight.new(:black, [0, 6])
    @board[0][7] = Rook.new(:black, [0, 7])

    @board[7][0] = Rook.new(:white, [7, 0])
    @board[7][1] = Knight.new(:white, [7, 1])
    @board[7][2] = Bishop.new(:white, [7, 2])
    @board[7][3] = Queen.new(:white, [7, 3])
    @board[7][4] = King.new(:white, [7, 4])
    @board[7][5] = Bishop.new(:white, [7, 5])
    @board[7][6] = Knight.new(:white, [7, 6])
    @board[7][7] = Rook.new(:white, [7, 7])
  end

  def self.chess_to_coords(input)
    file = input[0].downcase
    rank = input[1].to_i

    col = file.ord - 'a'.ord
    row = 8 - rank

    [row, col]
  end

  def move_piece(start_pos, end_pos)
    start_coords = Board.chess_to_coords(start_pos)
    end_coords = Board.chess_to_coords(end_pos)

    piece = @board[start_coords[0]][start_coords[1]]
    raise "No piece at #{start_pos}" unless piece

    if piece.valid_moves(@board).include? end_coords
      @board[end_coords[0]][end_coords[1]] = piece
      @board[start_coords[0]][start_coords[1]] = nil
      piece.position = end_coords
    else
      raise 'Invalid move, try again.'
    end
  end

  def display
    system "clear"
    puts "  a b c d e f g h"
    @board.each_with_index do |row, r_idx|
      print "#{8 - r_idx} "
      row.each_with_index do |square, c_idx|
        piece_symbol = square ? square.symbol : "  "
        background_color = (r_idx + c_idx).even? ? WHITE_SQUARE_COLOR : BLACK_SQUARE_COLOR
        print "#{background_color}#{piece_symbol}#{RESET_COLOR}"
      end
      puts " #{8 - r_idx}"
    end
    puts "  a b c d e f g h"
  end

  def find_king(color)
    @board.each do |row|
      row.each do |piece|
        return piece.position if piece.is_a?(King) && piece.color == color
      end
    end
  end

  def piece_at(chess_pos)
    raise "Invalid input. Enter coordinates like 'e2 e4'." unless valid_chess_pos?(chess_pos)
    coords = Board.chess_to_coords(chess_pos)
    @board[coords[0]][coords[1]]
  end

  def check?(color)
    king_pos = find_king(color)
    opponent_color = color == :white ? :black : :white
    opponent_pieces = @board.flatten.compact.select { |piece| piece.color == opponent_color }
    opponent_pieces.any? { |piece| piece.valid_moves(@board).include?(king_pos) }
  end

  def checkmate?(color)
    return false unless check?(color)

    pieces = @board.flatten.compact.select { |piece| piece.color == color }

    pieces.each do |piece|
      piece.valid_moves(@board).each do |move|
        board_copy = Marshal.load(Marshal.dump(self))
        board = board_copy.instance_variable_get(:@board)

        start_row, start_col = piece.position
        end_row, end_col = move

        moving_piece = board[start_row][start_col]
        next if moving_piece.nil?

        board[end_row][end_col] = moving_piece
        board[start_row][start_col] = nil
        moving_piece.position = [end_row, end_col]

        return false unless board_copy.check?(color)
      end
    end

    true
  end

  def stalemate?(color)
    pieces = @board.flatten.compact.select { |piece| piece.color == color }
    !check?(color) && pieces.all? { |piece| piece.valid_moves(@board) == [] }
  end

  private

  def valid_chess_pos?(pos)
    return false unless pos.is_a?(String) && pos.length == 2
    col = pos[0].downcase
    row = pos[1]
    col.between?('a', 'h') && row.between?('1', '8')
  end
end
 