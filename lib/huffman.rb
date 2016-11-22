$LOAD_PATH.unshift(File.dirname(__FILE__))
require 'exceptions/file_does_not_exists'

class Huffman
  attr_accessor :filename

  def initialize filename
    @filename = filename

    validate_file_presence
  end

  def compress

  end

  def decompress

  end

  private

  def validate_file_presence
    raise Exceptions::FileDoesNotExists.new unless File.exist? filename
  end
end
