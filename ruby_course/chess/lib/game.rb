require_relative 'board'
require_relative 'player'
require 'time'

# class to represent a chess game
class Game
  def initialize
    @players = []
    @board = Board.new
    @current_player = nil
    @loaded = false
    @save_file = nil
  end

  def create_players
    colors = ['black', 'white']
    2.times.map do
      print "Enter the player's first name who will be playing #{colors.last}: "
      name = gets.chomp
      Player.new(name, colors.pop)
    end
  end

  def get_move
    print "#{@current_player.name} (#{@current_player.color}), enter your move (e.g. e2 e4) or SAVE to save the game: "
    gets.chomp.split(' ')
  end

  def setup
    @players = create_players
    @current_player = @players.find { |player| player.color == 'white' }
  end
  
  def switch_players
    @current_player = @current_player == @players[0] ? @players[1] : @players[0]
  end

  def game_over?
    @board.checkmate?(@current_player.color.to_sym) || @board.stalemate?(@current_player.color.to_sym)
  end

  def save_game
    @loaded = true
    if @save_file.nil?
      white = @players.find { |p| p.color == 'white' }.name
      black = @players.find { |p| p.color == 'black' }.name
      timestamp = Time.now.strftime('%b%d_%I%M%p')
      @save_file = "chess_#{white}vs#{black}_#{timestamp}.marshal"
    end
    File.open(@save_file, 'wb') { |f| f.write(Marshal.dump(self)) }
    puts "Game saved as #{@save_file}!"
  end

  def self.load_game
    saves = Dir.glob("chess_*.marshal").sort
    return nil if saves.empty?

    puts "Available saves:"
    saves.each_with_index { |f, i| puts "#{i + 1}. #{f}" }
    print "Choose a save (1-#{saves.length}): "
    file = saves[gets.chomp.to_i - 1]
    game = File.open(file, 'rb') { |f| Marshal.load(f.read) }
    game.instance_variable_set(:@save_file, file)
    game
  end

  def play
    setup unless @loaded
    @board.display

    until game_over? do
      move = get_move

      next if handle_save(move)

      valid = false
      begin
        raise "Invalid input. Enter coordinates like 'e2 e4'." unless move.length == 2

        piece = @board.piece_at(move.first)
        raise "That's not your piece!" if piece.nil? || piece.color != @current_player.color.to_sym

        @board.move_piece(move.first, move.last)
        valid = true

      rescue => e
        puts e.message
      end

      next unless valid

      @board.display
      switch_players
      puts 'Check!' if @board.check?(@current_player.color.to_sym)
    end

    checkmate = @board.checkmate?(@current_player.color.to_sym)
    stalemate = @board.stalemate?(@current_player.color.to_sym)
    
    switch_players
    puts "Checkmate! #{@current_player.name} won!" if checkmate
    puts "Stalemate. Play again!" if stalemate
  end
  
  def handle_save(move)
    return false unless move.length == 1 && move.first.upcase == 'SAVE'
    save_game
    exit
  end
end
