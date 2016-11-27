require_relative 'node'

module Base
  class Heap

    def initialize
      @elements = [nil]
    end

    def push element
      @elements << element

      bubble_up @elements.size - 1
    end

    def pop
      exchange 1, @elements.size - 1
      max = @elements.pop

      bubble_down 1 
      max
    end

    def min
      @elements[1]
    end

    def elements
      @elements.clone
    end

    def heap_size
      @elements.size - 1
    end

    def to_tree
      tree = nil

      while heap_size > 0
        left = pop
        right = pop
        frequency = left.frequency
        frequency += right.frequency if left

        node = Base::Node.new '*', frequency, left: left, right: right
        
        if heap_size == 0
          tree = node
        else
          push node
        end
      end

      tree
    end

    private

    def bubble_up index
      parent = (index / 2)

      return if index <= 1
      return if @elements[parent].frequency <= @elements[index].frequency 

      exchange index, parent

      bubble_up parent
    end

    def bubble_down index
      child = (index * 2)

      return if child > @elements.size - 1

      not_the_last_element = child < @elements.size - 1
      left_element = @elements[child]
      right_element = @elements[child + 1]
      child += 1 if not_the_last_element && right_element.frequency < left_element.frequency

      return if @elements[index].frequency <= @elements[child].frequency

      exchange index, child

      bubble_down child
    end

    def exchange source, target
      @elements[source], @elements[target] = @elements[target], @elements[source]
    end
  end
end
