require 'huffman'

describe Huffman do
  describe 'Initialization validations' do
    context 'When an existent file is given' do
      it { expect{Huffman.new 'spec/support/files/sample_file.txt'}.not_to raise_error }
    end

    context 'When an nonexistent file is given' do
      it { expect{Huffman.new 'some_file'}.to raise_error Exceptions::FileDoesNotExists }
    end
  end
end
