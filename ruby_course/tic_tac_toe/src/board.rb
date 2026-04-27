# A class to represent a tic tac toe board
class Board
  attr_reader :quadrants

  def initialize
    # 9 quadrants of the board 
    @quadrants = {
      1 => ' ',
      2 => ' ',
      3 => ' ',
      4 => ' ',
      5 => ' ',
      6 => ' ',
      7 => ' ',
      8 => ' ',
      9 => ' ',
    }
  end

  def show
    puts <<-PRETTY_BOARD

     #{quadrants[1]} | #{quadrants[2]} | #{quadrants[3]}            1 | 2 | 3
    ---+---+---          ---+---+---
     #{quadrants[4]} | #{quadrants[5]} | #{quadrants[6]}            4 | 5 | 6
    ---+---+---          ---+---+---
     #{quadrants[7]} | #{quadrants[8]} | #{quadrants[9]}            7 | 8 | 9

    PRETTY_BOARD
  end

  def three_in_a_row?(player_1_symbol, player_2_symbol)
    # winning combinations of quadrants
    winning_combos = [
      [quadrants[1], quadrants[2], quadrants[3]],
      [quadrants[4], quadrants[5], quadrants[6]],
      [quadrants[7], quadrants[8], quadrants[9]],
      [quadrants[1], quadrants[4], quadrants[7]],
      [quadrants[2], quadrants[5], quadrants[8]],
      [quadrants[3], quadrants[6], quadrants[9]],
      [quadrants[1], quadrants[5], quadrants[9]],
      [quadrants[3], quadrants[5], quadrants[7]],
    ]

    # loop to check board for 3 in a row
    winning_combos.each do |combo|
      return true if combo.all?(player_1_symbol) or combo.all?(player_2_symbol)
    end
  end

  def full?
    # logic to check if the board is full (tie game)
    true if @quadrants.values.all? { |symbol| symbol != ' '}
  end
end