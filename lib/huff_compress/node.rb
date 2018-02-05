module HuffCompress
  class Node
    include Enumerable 

    attr_accessor :byte, :frequency, :right, :left

    def initialize byte, frequency, right: nil, left: nil
      @byte       = byte
      @frequency  = frequency
      @right      = right
      @left       = left
    end

    def each &block
      left.each &block if left
      block.call self
      right.each &block if right
    end

    def leaf?
      right.nil? && left.nil?
    end
  end
end
