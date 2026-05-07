require_relative 'node'

# class to represent a tree
class Tree
  def initialize(arr)
    @root = build_tree(arr)
  end

  def pretty_print(node = @root, prefix = '', is_left: true)
    return unless node

    pretty_print(node.right, "#{prefix}#{is_left ? '│   ' : '    '}", is_left: false)
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.value}"
    pretty_print(node.left, "#{prefix}#{is_left ? '    ' : '│   '}", is_left: true)
  end

  def include?(value, node = @root)
    return false if node.nil?
    return true if node.value == value

    if value < node.value
      include?(value, node.left)
    else
      include?(value, node.right)
    end
  end

  def insert(value)
    @root = insert_node(value, @root)
    self
  end

  def delete(value, node = @root)
    return nil if node.nil?

    if value < node.value
      node.left = delete(value, node.left)
    elsif value > node.value
      node.right = delete(value, node.right)
    else
      return node.right if node.left.nil?
      return node.left  if node.right.nil?

      successor = min_node(node.right)
      node.value = successor.value
      node.right = delete(successor.value, node.right)
    end

    node
  end

  def level_order
    return enum_for(:level_order) unless block_given?

    queue = [@root]

    until queue.empty?
      node = queue.shift
      yield node.value

      queue << node.left unless node.left.nil?
      queue << node.right unless node.right.nil?
    end

    self
  end

  def inorder(node = @root, &block)
    return enum_for(:inorder) unless block_given?

    inorder(node.left, &block) unless node.left.nil?
    block.call(node.value)
    inorder(node.right, &block) unless node.right.nil?

    self
  end

  def preorder(node = @root, &block)
    return enum_for(:preorder) unless block_given?

    block.call(node.value)
    preorder(node.left, &block) unless node.left.nil?
    preorder(node.right, &block) unless node.right.nil?

    self
  end

  def postorder(node = @root, &block)
    return enum_for(:postorder) unless block_given?

    postorder(node.left, &block) unless node.left.nil?
    postorder(node.right, &block) unless node.right.nil?
    block.call(node.value)

    self
  end

  def height(value)
    node = find_node(value)
    return nil if node.nil?
    calculate_height(node)
  end

  def depth(value, node = @root, current_depth = 0)
    return nil if node.nil?
    return current_depth if node.value == value

    if value < node.value
      depth(value, node.left, current_depth + 1)
    else
      depth(value, node.right, current_depth + 1)
    end
  end

  def balanced?(node = @root)
    return true if @root.nil?

    check_balance(node) != -1
  end

  def rebalance
    sorted = inorder.to_a
    @root = build_balanced(sorted, 0, sorted.length - 1)
    self
  end

  private

  def build_tree(arr)
    arr = arr.sort.uniq
    build_balanced(arr, 0, arr.length - 1)
  end

  def build_balanced(arr, start_idx, end_idx)
    return nil if start_idx > end_idx

    mid = (start_idx + end_idx) / 2
    node = Node.new(arr[mid])

    node.left  = build_balanced(arr, start_idx, mid - 1)
    node.right = build_balanced(arr, mid + 1, end_idx)

    node
  end

  def insert_node(value, node)
    return Node.new(value) if node.nil?
    return node if node.value == value

    if value < node.value
      node.left = insert_node(value, node.left)
    else
      node.right = insert_node(value, node.right)
    end

    node
  end

  def min_node(node)
    node = node.left until node.left.nil?
    node
  end

  def find_node(value, node = @root)
    return nil if node.nil?
    return node if node.value == value

    if value < node.value
      find_node(value, node.left)
    else
      find_node(value, node.right)
    end
  end

  def calculate_height(node)
    return 0 if node.left.nil? && node.right.nil?

    left_height = node.left.nil? ? -1 : calculate_height(node.left)
    right_height = node.right.nil? ? -1 : calculate_height(node.right)

    1 + [left_height, right_height].max
  end

  def check_balance(node)
    return 0 if node.nil?

    left_height = check_balance(node.left)
    return -1 if left_height == -1

    right_height = check_balance(node.right)
    return -1 if right_height == -1

    return -1 if (left_height - right_height).abs > 1

    1 + [left_height, right_height].max
  end
end
