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
    print "Enter the names of the 2 players and their colors (R for red, Y for yellow) separated by a comma (Joby R, Josh Y): "
    names = gets.chomp.split(',')
    create_player(names[0].split(' ')[0], names[0].split(' ')[1])
    create_player(names[1].split(' ')[0], names[1].split(' ')[1])
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
