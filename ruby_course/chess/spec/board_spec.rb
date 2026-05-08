require_relative '../lib/board'
require_relative '../lib/pieces/king'
require_relative '../lib/pieces/queen'
require_relative '../lib/pieces/rook'
require_relative '../lib/pieces/pawn'

describe Board do
  let(:board) { Board.new }

  def empty_board(board)
    board.instance_variable_set(:@board, Array.new(8) { Array.new(8) })
  end

  def place_piece(board, piece)
    board = board.instance_variable_get(:@board)
    row, col = piece.position
    board[row][col] = piece
  end

  describe '#check?' do
    context 'when the king is in check' do
      it 'returns true when king is attacked by a queen' do
        empty_board(board)
        place_piece(board, King.new(:white, [7, 4]))
        place_piece(board, King.new(:black, [0, 4]))
        place_piece(board, Queen.new(:black, [3, 4]))

        expect(board.check?(:white)).to be true
      end

      it 'returns true when king is attacked diagonally' do
        empty_board(board)
        place_piece(board, King.new(:white, [7, 4]))
        place_piece(board, King.new(:black, [0, 4]))
        place_piece(board, Queen.new(:black, [5, 2]))

        expect(board.check?(:white)).to be true
      end
    end

    context 'when the king is not in check' do
      it 'returns false when no pieces are attacking the king' do
        empty_board(board)
        place_piece(board, King.new(:white, [7, 4]))
        place_piece(board, King.new(:black, [0, 4]))
        place_piece(board, Queen.new(:black, [0, 0]))

        expect(board.check?(:white)).to be false
      end

      it 'returns false when an attack is blocked by another piece' do
        empty_board(board)
        place_piece(board, King.new(:white, [7, 4]))
        place_piece(board, King.new(:black, [0, 4]))
        place_piece(board, Queen.new(:black, [3, 4]))
        place_piece(board, Pawn.new(:white, [5, 4]))

        expect(board.check?(:white)).to be false
      end
    end
  end

  describe '#checkmate?' do
    context 'when the king is in checkmate' do
      it 'returns true for a back rank mate' do
        empty_board(board)
        place_piece(board, King.new(:white, [7, 0]))
        place_piece(board, King.new(:black, [0, 4]))
        place_piece(board, Rook.new(:black, [7, 7]))
        place_piece(board, Rook.new(:black, [6, 6]))

        expect(board.checkmate?(:white)).to be true
      end
    end

    context 'when the king is not in checkmate' do
      it 'returns false when the king can escape' do
        empty_board(board)
        place_piece(board, King.new(:white, [7, 4]))
        place_piece(board, King.new(:black, [0, 4]))
        place_piece(board, Rook.new(:black, [7, 0]))

        expect(board.checkmate?(:white)).to be false
      end

      it 'returns false when a piece can block the check' do
        empty_board(board)
        place_piece(board, King.new(:white, [7, 4]))
        place_piece(board, King.new(:black, [0, 4]))
        place_piece(board, Queen.new(:black, [3, 4]))
        place_piece(board, Rook.new(:white, [6, 0]))

        expect(board.checkmate?(:white)).to be false
      end

      it 'returns false when not in check' do
        empty_board(board)
        place_piece(board, King.new(:white, [7, 4]))
        place_piece(board, King.new(:black, [0, 4]))

        expect(board.checkmate?(:white)).to be false
      end
    end
  end

  describe '#stalemate?' do
    context 'when the position is stalemate' do
      it 'returns true when the king has no legal moves and is not in check' do
        empty_board(board)
        place_piece(board, King.new(:white, [7, 7]))
        place_piece(board, King.new(:black, [0, 0]))
        place_piece(board, Queen.new(:black, [5, 6]))

        b = board.instance_variable_get(:@board)
        king = b[7][7]

        expect(board.stalemate?(:white)).to be true
      end
    end

    context 'when the position is not stalemate' do
      it 'returns false when the king is in check' do
        empty_board(board)
        place_piece(board, King.new(:white, [7, 4]))
        place_piece(board, King.new(:black, [0, 4]))
        place_piece(board, Queen.new(:black, [3, 4]))

        expect(board.stalemate?(:white)).to be false
      end

      it 'returns false when the king has legal moves' do
        empty_board(board)
        place_piece(board, King.new(:white, [7, 4]))
        place_piece(board, King.new(:black, [0, 4]))

        expect(board.stalemate?(:white)).to be false
      end
    end
  end
end
