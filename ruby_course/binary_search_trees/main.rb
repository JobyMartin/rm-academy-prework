require_relative 'src/tree'

# create tree
tree = Tree.new(Array.new(15) { rand(1..100) })

# display treer
tree.pretty_print

# check balance status
puts "\nBalanced? #{tree.balanced?}"

# display all orders
puts "\nLevel order : #{tree.level_order.to_a.inspect}"
puts "Preorder    : #{tree.preorder.to_a.inspect}"
puts "Postorder   : #{tree.postorder.to_a.inspect}"
puts "Inorder     : #{tree.inorder.to_a.inspect}"

# unbalance the tree
unbalancing = [101, 105, 110, 115, 120, 125]
puts "\nInserting #{unbalancing.inspect} to unbalance tree..."
unbalancing.each { |n| tree.insert(n) }

# display the tree
tree.pretty_print

# check balance status
puts "\nBalanced? #{tree.balanced?}"

# rebalance the tree
puts "\nRebalancing..."
tree.rebalance
tree.pretty_print

# check balance status
puts "\nBalanced? #{tree.balanced?}"

# display all orders
puts "\nLevel order : #{tree.level_order.to_a.inspect}"
puts "Preorder    : #{tree.preorder.to_a.inspect}"
puts "Postorder   : #{tree.postorder.to_a.inspect}"
puts "Inorder     : #{tree.inorder.to_a.inspect}"
