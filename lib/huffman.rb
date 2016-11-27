require 'exceptions/file_not_found'
require 'base/heap'

class Huffman
  attr_accessor :filename

  def initialize filename
    @filename = filename

    validate_file_presence
  end

  def compress
    file = File.open(filename, "rb")
    frequencies = count_frequencies file

    bytes_heap = Base::Heap.new
    frequencies.each_with_index do |frequency, index|
      bytes_heap.push(Base::Node.new index.chr, frequency) if frequency > 0
    end

    huff_tree = bytes_heap.to_tree    
    tree_size = huff_tree.inject(0) do |sum, e|
      sum += 1 if e.leaf? && (e.byte == '*' || e.byte == '\\')

      sum += 1
    end
    
    bit_map = map_bits huff_tree, {}
    # require "pry"; binding.pry

    file.close
  end

  def decompress

  end

  private

  def validate_file_presence
    raise Exceptions::FileNotFound.new unless File.exist? filename
  end

  def count_frequencies file 
    frequencies = Array.new(256) { |i| 0 }

    file.each do |line| 
      line.each_byte { |b| frequencies[b] += 1 }
    end

    frequencies
  end

  def map_bits tree, map, bits = ""
    if tree.leaf?
      map[tree.byte] = bits
      return
    end
    
    map_bits tree.left, map, bits+'0'
    map_bits tree.right, map, bits+'1'

    return map
  end
end
