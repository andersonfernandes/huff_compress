require_relative 'node'

module Base
  class PQueue
    attr_accessor :elements

    def initialize
      @elements = [nil]
    end

    def enqueue element
      @elements << element

      heapify @elements.size - 1
    end

    private

    def heapify index
      parent = index / 2

      return if index <= 1
      return if @elements[parent].frequency >= @elements[index].frequency 

      exchange index, parent

      heapify parent
    end

    def exchange source, target
      @elements[source], @elements[target] = @elements[target], @elements[source]
    end
  end
end
