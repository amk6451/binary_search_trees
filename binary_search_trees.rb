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
        @root = build_tree(array.uniq.sort)
    end

    def build_tree(array)

        return nil if array.empty?
        mid = (array.length/ 2)
        root = Node.new(array[mid])
        root.left = build_tree(array[0...mid])
        root.right = build_tree(array[(mid + 1)..-1])
        root
    end

    def pretty_print(node = @root, prefix = '', is_left = true)
        pretty_print(node.right, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right
        puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.value}"
        pretty_print(node.left, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left
    end

    def find(key, node = @root)
        # Base Cases: root is null or key is present at root
        return nil if node.nil?
        return node.value if key == node.value

        # Key is greater than root's key
        if node.value < key
            return find(key, node.right)
        elsif node.value > key
        # Key is smaller than root's key
            return find(key, node.left)
        end
    end



    def insert(key, node = @root)
        return Node.new(key) if node.nil?
            
        if node.value == key
            return node
        elsif node.value < key
            node.right = insert(key, node.right,)
        else
            node.left = insert(key,node.left)
        end
        return node
    end


    def delete(key, node = @root)
        return node if node.nil?
            
        if node.value == key

            #move either the left or right nodes to the deleted spot
            if node.left.nil?
                temp = node.right
                node = nil
                return temp
            end
            if node.right.nil?
                temp = node.left
                node = nil
                return temp
            end
            #condition with nodes in both right and left parts of tree
            #getting the inorder successor (smallest in the right subtree) and removing
            #it from the end of the tree in place of the deleted node
            temp = minValueNode(node.right)

            #copying the inorder successor's content to this node
            node.value = temp.value
     
            #deleting the inorder successor
            node.right = delete(temp.value, node.right)

            return node

        #searches left and right side of subtrees
        elsif node.value < key
            node.right = delete(key, node.right)
        else
            node.left = delete(key,node.left)
        end
        return node
    end

    def minValueNode(node)
        # loop down to find the leftmost leaf
        node = node.left until node.left.nil?
        return node
    end
end

# a = Tree.new([1, 7, 4, 23, 8, 9, 4, 3, 5, 7, 9, 67, 6345, 324])
a = Tree.new([1, 3, 4, 5, 7, 8, 9, 23, 67, 324, 6345])

a.delete(8)
a.pretty_print