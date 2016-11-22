module Exceptions
  class FileDoesNotExists < StandardError
    def initialize
      super 'The pointed file does not exists'
    end
  end
end
