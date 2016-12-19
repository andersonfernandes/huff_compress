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

    extension = File.extname file
    basename  = File.basename file, extension

    dest_file = File.new  "tmp/#{basename}.huff", 'w+b'

    byte_1 = extension.size << 2
    byte_2 = 0

    if tree_size > 255
      byte_1 = set_bit(byte_1, 0) if is_bit_i_set?(tree_size, 8)
      byte_1 = set_bit(byte_1, 1) if is_bit_i_set?(tree_size, 9)

      byte_2 = 255
    else
      byte_2 = tree_size
    end

    dest_file.putc byte_1.chr
    dest_file.putc byte_2.chr
    dest_file.write extension

    huff_tree.each { |e| dest_file.putc e.byte }
    trash_size = write_compressed_data file, dest_file, bit_map

    dest_file.rewind
    byte_1 = byte_1 | (trash_size << 5)
    dest_file.putc byte_1.chr

    dest_file.close
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
    file.each_byte { |b| frequencies[b] += 1 }

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

  # This method will write the new bytes on the destination file and will the trash size on the last byte
  def write_compressed_data src_file, dest_file, bit_map
    src_file.rewind

    byte = 0
    bit_count = 7
    src_file.each_byte do |b|

      if src_file.eof?
        dest_file.putc byte.chr
        return bit_count+1
      end

      new_byte = bit_map[b.chr]

      new_byte.each_char do |c|
        if bit_count < 0
          dest_file.putc byte.chr
          bit_count = 7
          byte = 0
        end

        byte = set_bit(byte, bit_count) if c.to_i == 1
        bit_count -= 1
      end
    end
  end

  def is_bit_i_set? byte, i
    mask = 1 << i
    mask & byte
  end

  def set_bit byte, i
    mask = 1 << i
    mask | byte
  end
end
