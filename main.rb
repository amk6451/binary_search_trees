require_relative 'binary_search_trees.rb'

# Create a binary search tree from an array of random numbers (Array.new(15) { rand(1..100) })
random_array = Array.new(15) { rand(1..100) }
puts "Random Array: #{random_array}"
tree = Tree.new(random_array)
p tree.pretty_print
# Confirm that the tree is balanced by calling #balanced?
puts tree.balanced?

# Print out all elements in level, pre, post, and in order
p tree.level_order
p tree.preorder
p tree.postorder
p tree.inorder
# Unbalance the tree by adding several numbers > 100
tree.insert(200)
tree.insert(201)
tree.insert(300)
tree.insert(246)
# Confirm that the tree is unbalanced by calling #balanced?
p tree.pretty_print
puts tree.balanced?
# Balance the tree by calling #rebalance
tree.rebalance
p tree.pretty_print
# Confirm that the tree is balanced by calling #balanced?
puts tree.balanced?
# Print out all elements in level, pre, post, and in order
p tree.level_order
p tree.preorder
p tree.postorder
p tree.inorder