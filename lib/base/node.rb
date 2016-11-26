module Base
  class Node
    attr_accessor :byte, :frequency, :right, :left

    def initialize byte, frequency, childs = {}
      @byte       = byte
      @frequency  = frequency

      @right  = childs[:right]
      @left   = childs[:left]
    end

  end
end
