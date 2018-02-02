require 'exceptions/file_not_found'
require 'util/compress'
require 'base/heap'

class Huffman
  include Util::Compress
  attr_accessor :filename

  def initialize filename
    @filename = filename

    validate_file_presence
  end

  def compress
    file = File.open(filename, "rb")
    frequencies = count_frequencies file

    bytes_heap = Base::Heap.new frequencies

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

end
