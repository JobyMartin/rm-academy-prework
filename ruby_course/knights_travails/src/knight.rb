
# class to represent a Knight piece
class Knight
  def initialize
    @moves = [
      [2, 1], [2, -1], [-2, 1], [-2, -1],
      [1, 2], [1, -2], [-1, 2], [-1, -2]
    ]
  end

  def shortest_path(current_position, end_position)
    queue = [[current_position, []]]
    visited = Set.new

    until queue.empty?
      position, path = queue.shift
      return path + [position] if position == end_position

      next if visited.include?(position)

      visited.add(position)

      @moves.each do |move|
        new_position = [position[0] + move[0], position[1] + move[1]]
        next unless on_board?(new_position)
        queue << [new_position, path + [position]] unless visited.include?(new_position)
      end
    end

    nil
  end

  def on_board?(position)
    position.all? { |coord| coord.between?(0, 7) }
  end
end
