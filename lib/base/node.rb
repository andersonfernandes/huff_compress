module Base
  class Node
    attr_accessor :byte, :frequency, :right, :left

    def self.new_queue_node byte, frequency
      node = Base::Node.new

      node.byte       = byte
      node.frequency  = frequency

      node
    end

    def self.new_tree_node byte, right, left
      node = Base::Node.new

      node.byte   = byte
      node.right  = right
      node.left   = left

      node
    end
  end
end
