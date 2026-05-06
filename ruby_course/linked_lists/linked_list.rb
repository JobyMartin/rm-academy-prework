require_relative 'node'

class LinkedList
  def initialize
    @head = nil
  end

  def append(value)
    value_node = Node.new(value)
    if @head.nil?
      @head = value_node
    else
      current_node = @head
      until current_node.next_node.nil?
        current_node = current_node.next_node
      end
      current_node.next_node = value_node
    end
  end

  def prepend(value)
    value_node = Node.new(value)
    value_node.next_node = @head
    @head = value_node
  end

  def size
    count = 0
    current_node = @head
    while current_node
      count += 1
      current_node = current_node.next_node
    end
    count
  end

  def head
    @head
  end

  def tail
    current_node = @head
    while current_node && !current_node.next_node.nil?
      current_node = current_node.next_node
    end
    current_node
  end

  def at(index)
    current_node = @head
    index.times do
      return nil if current_node.nil?
      current_node = current_node.next_node
    end
    current_node
  end

  def pop
    return nil if @head.nil?
    if @head.next_node.nil?
      popped = @head
      @head = nil
      return popped.value
    end
    current_node = @head
    while current_node.next_node && !current_node.next_node.next_node.nil?
      current_node = current_node.next_node
    end

    popped = current_node.next_node
    current_node.next_node = nil
    popped.value
  end

  def contains?(value)
    current_node = @head
    while current_node
      return true if current_node.value == value
      current_node = current_node.next_node
    end
    false
  end

  def find(value)
    current_node = @head
    index = 0
    while current_node
      return index if current_node.value == value
      current_node = current_node.next_node
      index += 1
    end
    nil
  end

  def to_s
    values = []
    current_node = @head
    while current_node
      values << "( #{current_node.value} )"
      current_node = current_node.next_node
    end
    values << 'nil'
    values.join(" -> ")
  end
end

# example usage:
list = LinkedList.new

list.append('dog')
list.append('cat')
list.append('parrot')
list.append('hamster')
list.append('snake')
list.append('turtle')

puts list
