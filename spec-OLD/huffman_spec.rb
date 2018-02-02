require 'huffman'

describe Huffman do
  describe 'Initialization validations' do
    context 'When an existent file is given' do
      it { expect{Huffman.new 'spec/support/sample_file.txt'}.not_to raise_error }
    end

    context 'When an nonexistent file is given' do
      it { expect{Huffman.new 'some_file'}.to raise_error Exceptions::FileNotFound }
    end
  end

  describe '#compress' do
    subject { Huffman.new 'spec/support/sample_file.txt' }

    it '...' do
      expect(subject.compress).to eq nil
    end
  end
end
