require_relative 'lib/game'

# asks for game preferences, creates, and plays a game
print "Would you like to load a saved game? (y/n): "
if gets.chomp.downcase == 'y'
  game = Game.load_game
  if game.nil?
    puts "No saved games found. Starting a new game."
    game = Game.new
    game.play
  else
    game.play
  end
else
  game = Game.new
  game.play
end
