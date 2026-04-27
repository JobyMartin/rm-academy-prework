require_relative 'player.rb'
require_relative 'board.rb'

# A class for the tic tac toe game
class TicTacToeGame
  def initialize
    @board = Board.new
    @player_1 = nil
    @player_2 = nil
    @current_player = nil
  end

  def get_player_input(error = '')
    puts error
    print 'Enter a player\'s name and desired symbol separated by a space ("Bob X"): '
    gets.chomp.split(' ')
  end

  def create_player
    player_attributes = get_player_input
    validation_results = validate_input(player_attributes)

    until validation_results[:valid]
      player_attributes = get_player_input(validation_results[:error])
      validation_results = validate_input(player_attributes)
    end

    Player.new(player_attributes[0], player_attributes[1].upcase)
  end

  def validate_input(input)
    return { valid: false, error: 'Please enter a name and a symbol' } if input.length < 2
    return { valid: false, error: 'Too many values entered' } if input.length > 2
    return { valid: false, error: 'Symbol must be one character' } if input[1].length > 1

    { valid: true }
  end

  def set_current_player
    # logic to set current player each turn
    @current_player = @current_player == @player_1 ? @player_2 : @player_1
  end

  def turn(quadrant)
    @board.quadrants[quadrant] = @current_player.symbol
    @board.show
  end

  def get_turn_input
    print "Enter quadrant you where wish to place a piece, #{@current_player.name}: "
    quadrant = gets.chomp.to_i
    
    # check for invalid input
    until quadrant >= 1 && quadrant <= 9
      print "Uh oh. It appears you've entered invalid input. Please enter a number 1-9: "
      quadrant = gets.chomp.to_i
    end
    quadrant
  end

  def print_instructions
    puts <<-INSTRUCTIONS

    --------INSTRUCTIONS-------- 
    Welcome to Tic Tac Toe!
    In this program two people
    will play against each other
    in the game of Tic Tac Toe.
    ----------------------------
    Taking turns you will enter
    the number corresponding to
    the quadrant you choose.
    ----------THE BOARD---------
    The board will look like so:
  
     1 | 2 | 3 
    ---+---+---
     4 | 5 | 6 
    ---+---+---
     7 | 8 | 9 
  
    The numbers listed mark the
    quadrants accordingly.
    They will be removed.
    ------------ENJOY-----------

    INSTRUCTIONS
  end

  def setup
    # create some players
    @player_1 = create_player
    @player_2 = create_player

    # decide who's going first
    print "\nWho's going first? #{@player_1.name} or #{@player_2.name}? Enter name: "
    first_player = gets.chomp.downcase!
    @current_player = first_player == @player_1.name.downcase ? @player_1 : @player_2
  end

  def play
    print_instructions
    setup
    @board.show

    # main game loop to take turns
    until @board.three_in_a_row?(@player_1.symbol, @player_2.symbol) == true or @board.full? == true # is "== true" needed?
      quadrant = get_turn_input

      # check for invalid input
      until @board.quadrants[quadrant] == ' '
        print 'That quadrant is already taken. Enter a different one: '
        quadrant = gets.chomp.to_i
      end

      # take turn and set new current player
      turn(quadrant)
      set_current_player
    end

    # check if the game is over 
    if @board.three_in_a_row?(@player_1.symbol, @player_2.symbol) == true
      puts "Game over! The winner is: #{@current_player == @player_2 ? @player_1.name : @player_2.name}!"
    elsif @board.full? == true
      puts "Game over! It's a tie!"
    end
  end
end