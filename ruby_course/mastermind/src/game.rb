require_relative 'board'
require_relative 'player'

class Game
  def initialize
    @board = Board.new
    @player = nil
    @start_time = nil
    @end_time = nil
  end

  def create_player
    print 'Please enter your name: '
    name = gets.chomp
    @player = Player.new(name)
  end

  def get_guess(turn_number)
    print "\nEnter your guess number #{turn_number}, #{@player.name} (R, G, B, Y, W, K): "
    gets.chomp.upcase.chars
  end

  def get_user_code
    print "Enter your secret code (R G B Y W K): "
    input = gets.chomp.upcase.chars

    until valid_guess?(input)
      puts "Invalid code"
      input = gets.chomp.upcase.chars
    end

    @board.combo = input
  end

  def computer_guess
    %w(R G B Y W K).sample(4)
  end

  def turn(turn_number)
    combo_guess = get_guess(turn_number)

    until valid_guess?(combo_guess)
      puts 'Error: invalid guess'
      combo_guess = get_guess(turn_number)
    end

    @board.combo_guess = combo_guess
    @board.give_combo_feedback
    puts "\n#{'⚫' * @board.black_pegs} #{'⚪' * @board.white_pegs}"
  end

  def valid_guess?(input)
    return false unless input.length == 4
    return false if input.include?(' ')

    allowed_colors = %w(R G B Y W K)

    input.all? { |char| allowed_colors.include?(char) }
  end

  def print_instructions
    puts <<-INSTRUCTIONS

    ----------INSTRUCTIONS----------
    Welcome to Mastermind!
    In this program the computer
    will create a secret code
    consisting of 4 colors.

    The color options are:
    Red - "R"
    Green - "G"
    Blue - "B"
    Yellow - "Y"
    White - "W"
    Black - "K"

    You have 12 tries to guess the
    secret code.

    Enter your input seperated by
    no spaces. -- "RBGK"

    The computer will return black &
    white pegs. 

    A black peg means that one of
    your suspected colors is correct
    AND in the CORRECT position.

    A white peg means that one of 
    your suspected colors is correct
    BUT in the INCORRECT position.

    Try to beat the computer!
    -------------ENJOY--------------
    
    INSTRUCTIONS
  end

  def win?
    @board.black_pegs == 4
  end

  def lose?(turn_number)
    turn_number == 12 && @board.black_pegs < 4
  end

  def play
    print_instructions
    create_player

    puts "Play as (1) Code Breaker or (2) Code Maker? (Enter 1 or 2): "
    choice = gets.chomp

    @start_time = Time.now
    puts "\nTimer started"

    if choice == "1"
      play_human_guesses
    else
      play_computer_guesses
    end
  end

  def play_human_guesses
    (1..12).to_a.each do |turn_number|
      turn(turn_number)
      if win?
        @end_time = Time.now
        puts "Correct, the colors were #{@board.combo.join(' ')}! It took you #{(@end_time - @start_time).round(1)} seconds, and #{turn_number} turn#{turn_number > 1 ? 's' : ''}!"
        break
      elsif lose?(turn_number)
        @end_time = Time.now
        puts "You lose! The colors were #{@board.combo.join(' ')}. You spent #{(@end_time - @start_time).round(1)} seconds."
        break
      else
        next
      end
    end
  end

  def play_computer_guesses
    get_user_code

    (1..12).each do |turn_number|
      guess = computer_guess

      @board.combo_guess = guess
      @board.give_combo_feedback

      puts "\nComputer guesses: #{guess.join(' ')}"
      puts "\n#{'⚫' * @board.black_pegs} #{'⚪' * @board.white_pegs}"

      if win?
        puts "Computer wins in #{turn_number} turns!"
        break
      elsif lose?(turn_number)
        puts "Computer loses! Secret was #{@board.combo.join(' ')}"
        break
      end
    end
  end
end
