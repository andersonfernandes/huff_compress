module Util
  module Compress

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
end
