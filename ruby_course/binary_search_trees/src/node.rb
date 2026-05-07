
# class to represent a node
class Node
  attr_accessor :value, :left, :right

  def initialize(value = nil)
    @value = value
    @left = nil
    @right = nil
  end
end
