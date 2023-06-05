class Node
    include Comparable
    attr_accessor :value, :left, :right
    def initialize(value,right = nil, left = nil)
        @value = value
        @right = right
        @left = left
    end
end

class Tree
    # include "Node"
    def initialize(array)
        @root = build_tree(array)
    end

    def build_tree(array)
        return nil if array.empty?
        mid = (array.length / 2)
        root = Node.new(array[mid])
        root.left = build_tree(array[0...mid])
        root.right = build_tree(array[mid + 1..-1])
        return root
    end

    def pretty_print(node = @root, prefix = '', is_left = true)
        pretty_print(node.right, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right
        puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.value}"
        pretty_print(node.left, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left
    end
end

a = Tree.new([1, 7, 4, 23, 8, 9, 4, 3, 5, 7, 9, 67, 6345, 324])
# a.root
a.pretty_print