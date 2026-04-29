require './src/board'

RSpec.describe Board do
  let(:board) { Board.new }

  describe '#drop_piece' do
    it 'places a piece in the correct column' do
      board.drop_piece(1, 'R')
      expect(board.grid[5][1]).to eq('R')

      board.drop_piece(1, 'R')
      expect(board.grid[4][1]).to eq('R')

      board.drop_piece(6, 'Y')
      expect(board.grid[5][6]).to eq('Y')

      board.drop_piece(6, 'R')
      expect(board.grid[4][6]).to eq('R')
    end
  end

  describe "#four_in_a_row?" do
    context "when there are four in a row horizontally" do
      it "returns true" do
        4.times { |i| board.grid[5][i] = "R" }
        expect(board.four_in_a_row?).to eq(true)
      end
    end

    context "when there are four in a row vertically" do
      it "returns true" do
        4.times { |i| board.grid[5 - i][0] = "Y" }
        expect(board.four_in_a_row?).to eq(true)
      end
    end

    context "when there are four in a row diagonally (down-right)" do
      it "returns true" do
        4.times { |i| board.grid[2 + i][i] = "R" }
        expect(board.four_in_a_row?).to eq(true)
      end
    end

    context "when there are four in a row diagonally (down-left)" do
      it "returns true" do
        4.times { |i| board.grid[2 + i][6 - i] = "Y" }
        expect(board.four_in_a_row?).to eq(true)
      end
    end

    context "when there are no four in a row" do
      it "returns false" do
        board.grid[5][0] = "R"
        board.grid[5][1] = "Y"
        board.grid[5][2] = "R"
        board.grid[5][3] = "Y"
        expect(board.four_in_a_row?).to eq(false)
      end
    end
  end

  describe '#full' do
    context 'when the board is full' do
      it 'returns true' do
        6.times do |row|
          7.times do |col|
            board.grid[row][col] = (row + col).even? ? "R" : "Y"
          end
        end
        expect(board.full?).to eq(true)
      end
    end

    context "when the board isn't full" do
      it 'returns false' do
        board.grid[0][0] = 'R'
        board.grid[3][3] = 'Y'
        expect(board.full?).to eq(false)
      end
    end
  end

  describe '#column_full?' do
    context 'when the column is full' do
      it 'returns true' do
        6.times { |row| board.grid[row][0] = 'R' } 
        expect(board.column_full?(0)).to eq(true)
      end
    end

    context 'when the column is not full' do
      it 'returns false' do
        5.times { |row| board.grid[row][1] = 'Y' }
        expect(board.column_full?(1)).to eq(false)
      end
    end
  end
end