
class Board
  attr_accessor :letters, :attempt_count, :wrong_letters
  def initialize
    @letters = {}
    @wrong_letters = []
    @attempt_count = 8
  end

  def show
    puts <<-BOARD

    #{@letters.values.join(' ').upcase} (#{@letters.length})

    Wrong letters: #{@wrong_letters.join(', ').upcase}

    Attempts remaining: #{@attempt_count}
    
    BOARD
  end
end
