module Exceptions
  class FileNotFound < StandardError
    def initialize
      super 'The given file was not found'
    end
  end
end
