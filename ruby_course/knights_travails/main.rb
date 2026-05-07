require_relative 'src/knight'

def knight_moves(start, finish)
  path = Knight.new.shortest_path(start, finish)
  puts "You made it in #{path.length - 1} move(s)! Here's your path:"
  path.each { |position| puts "#{position}" }
  path
end

# example usage
knight_moves([3, 3], [4, 3])
