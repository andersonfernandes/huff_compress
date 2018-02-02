module Base
  class Node
    include Enumerable

    attr_accessor :byte, :frequency, :right, :left

    def initialize byte, frequency, childs = {}
      @byte       = byte
      @frequency  = frequency

      @right  = childs[:right]
      @left   = childs[:left]
    end

    def each &block
      left.each &block if left
      block.call self
      right.each &block if left
    end

    def leaf?
      @right.nil? && @left.nil?
    end

  end
end
