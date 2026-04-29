
class Board
  ROWS = 6
  COLS = 7

  attr_reader :grid

  def initialize
    # 6 rows x 7 columns
    @grid = Array.new(ROWS) { Array.new(COLS, nil) }
  end

  def drop_piece(col, piece)
    raise "Invalid column" unless (0...COLS).include?(col)

    (ROWS - 1).downto(0) do |row|
      if @grid[row][col].nil?
        @grid[row][col] = piece
        return true
      end
    end

    false
  end

  # Pretty print the board in terminal
  def display
    system("clear") || system("cls")
    puts (1..COLS).to_a.join("   ")
    @grid.each do |row|
      row_display = row.map do |cell|
        case cell
        when "R" then "🔴"
        when "Y" then "🟡"
        else "⚪"
        end
      end
      puts row_display.join("  ")
    end
    puts "-" * (COLS * 4 - 2)
  end

  def four_in_a_row?
    # check horizontal
    (0..5).each do |row|
      (0..3).each do |col|
        piece = grid[row][col]
        next if piece.nil?
        return true if (1..3).all? { |i| grid[row][col + i] == piece }
      end
    end

    # check vertical
    (0..2).each do |row|
      (0..6).each do |col|
        piece = grid[row][col]
        next if piece.nil?
        return true if (1..3).all? { |i| grid[row + i][col] == piece }
      end
    end

    # check diagonal down-right
    (0..2).each do |row|
      (0..3).each do |col|
        piece = grid[row][col]
        next if piece.nil?
        return true if (1..3).all? { |i| grid[row + i][col + i] == piece }
      end
    end

    # check diagonal down-left
    (0..2).each do |row|
      (3..6).each do |col|
        piece = grid[row][col]
        next if piece.nil?
        return true if (1..3).all? { |i| grid[row + i][col - i] == piece }
      end
    end

    false
  end

  def full?
    grid.each do |row|
      return false if row.any? { |piece| piece.nil? }
    end
    true
  end

  def column_full?(col)
    grid.each do |row|
      return false if row[col].nil?
    end
    true
  end
end
