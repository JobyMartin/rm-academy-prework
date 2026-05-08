require_relative 'board'
require_relative 'player'

class Game
  attr_reader :players, :board
  attr_accessor :current_player

  def initialize
    @players = []
    @current_player = nil
    @board = Board.new
  end

  def create_player(name, symbol)
    @players << Player.new(name, symbol)
  end

  def set_current_player
    current_player == players[0] ? @current_player = players[1] : @current_player = players[0]
  end

  def get_move
    print "#{current_player.name} (#{current_player.symbol == 'R' ? 'Red' : 'Yellow'}), enter your move: "
    gets.chomp.to_i
  end

  def turn
    set_current_player
    @board.display
    move = get_move

    until move.between?(1, 7)
      puts 'Invalid move, try again.'
      move = get_move
    end

    until !@board.column_full?(move - 1)
      puts 'That column is full, try another one.'
      move = get_move
    end

    @board.drop_piece((move - 1), current_player.symbol)
  end

  def setup
    colors = ['Y', 'R']

    2.times do
      print "Enter a players name: "
      name = gets.chomp
      create_player(name, colors.pop)
    end
  end

  def play
    setup
    @current_player = players.sample

    until @board.full? || @board.four_in_a_row?
      turn
    end

    @board.display

    if @board.full?
      puts "It's a tie! The board is full."
    elsif @board.four_in_a_row?
      puts "#{current_player.name} (#{current_player.symbol == 'R' ? 'Red' : 'Yellow'}) won! Play again!"
    end
  end
end
