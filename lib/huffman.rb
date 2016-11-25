$LOAD_PATH.unshift(File.dirname(__FILE__))
require 'exceptions/file_not_found'

class Huffman
  attr_accessor :filename

  def initialize filename
    @filename = filename

    validate_file_presence
  end

  def compress
    file = File.open(filename, "rb")
    frequencies = count_frequencies file

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
end
