
class Board 
  attr_accessor :white_pegs, :black_pegs, :combo_guess, :combo
  def initialize
    @colors = %w(R G B Y W K)
    @combo = @colors.sample(4)
    @combo_guess = nil
    @white_pegs = 0
    @black_pegs = 0
  end

  def create_combo
    @combo = @colors.sample(4)
  end

  def give_combo_feedback
    @black_pegs = 0
    @white_pegs = 0
  
    # count black pegs
    combo.each_with_index do |color, i|
      if combo_guess[i] == color
        @black_pegs += 1
      end
    end
  
    # count color matches (regardless of position)
    combo_counts = combo.tally
    guess_counts = combo_guess.tally
  
    total_color_matches = combo_counts.sum do |color, count|
      [count, guess_counts[color] || 0].min
    end
  
    # count white pegs
    @white_pegs = total_color_matches - @black_pegs
  end
end
