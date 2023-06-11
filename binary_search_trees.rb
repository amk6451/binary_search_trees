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
        return node if key == node.value

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


    def level_order(node = @root)
        return if node.nil?
        array = []
        answer = []
        array.push(node.value)
        puts array
        while array.any?
            current = find(array[0], node)
            answer.append(array.shift())
            if current.left != nil
                array.push(current.left.value)
            end
            if current.right != nil
                array.push(current.right.value)
            end
        end
        return answer

    end

    def inorder(node = @root, array = [])
        return array if node.nil?
        inorder(node.left, array)
        array.append(node.value)
        inorder(node.right, array)
    end

    def preorder(node = @root,array = [])
        return array if node.nil?
        array.append(node.value)
        preorder(node.left, array)
        preorder(node.right, array)
    end

    def postorder(node = @root, array = [])
        return array if node.nil?
        postorder(node.left, array)
        postorder(node.right, array)
        array.append(node.value)
    end

    def height(node = @root)
        return -1 if node.nil?
        return [height(node.left), height(node.right)].max + 1
    end


    def depth(key, node = @root, depth = 0)
        return depth if node.value == key
        depth += 1
        if key < node.value
            return depth(key, node.left, depth)
        end
        if key > node.value
            return depth(key, node.right, depth)
        end
    end

    def balanced?(node = @root)
        return true if node.nil?
        left_height = height(node.left)
        right_height = height(node.right)

        return false if (left_height - right_height).abs > 1
        balanced?(node.right) && balanced?(node.left)
    end

    def rebalance
        return @root = build_tree(inorder)
    end
end

# a = Tree.new([1, 7, 4, 23, 8, 9, 4, 3, 5, 7, 9, 67, 6345, 324])
# a.insert(7000)
# a.insert(300)
# a.insert(500)
# a.insert(900)
# a.pretty_print
# p a.balanced?
# p a.rebalance
# p a.pretty_print
# p a.balanced?

# p a.level_order