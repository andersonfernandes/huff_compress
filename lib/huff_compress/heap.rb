module HuffCompress
  class Heap

    def initialize frequencies = []
      @elements = [nil]

      create_frequencies_heap frequencies unless frequencies.empty?
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

        node = Node.new '*', frequency, left: left, right: right

        if heap_size == 0
          tree = node
        else
          push node
        end
      end

      tree
    end

    private

    def create_frequencies_heap frequencies
      frequencies.each_with_index do |frequency, index|
        push(Node.new index.chr, frequency) if frequency > 0
      end
    end

    def bubble_up position
      parent = (position / 2)

      return if position <= 1
      return if @elements[parent].frequency <= @elements[position].frequency

      exchange position, parent

      bubble_up parent
    end

    def bubble_down position
      child = (position * 2)

      return if child > @elements.size - 1

      not_the_last_element = child < @elements.size - 1
      left_element = @elements[child]
      right_element = @elements[child + 1]
      child += 1 if not_the_last_element && right_element.frequency < left_element.frequency

      return if @elements[position].frequency <= @elements[child].frequency

      exchange position, child

      bubble_down child
    end

    def exchange source, target
      @elements[source], @elements[target] = @elements[target], @elements[source]
    end
  end
end
