require 'huff_compress/node'

RSpec.describe HuffCompress::Node do

  describe '::new' do

    context 'should set node attributes' do
      let(:byte) { 'a' }
      let(:frequency) { 2 }
      let(:node) { HuffCompress::Node.new byte, frequency }

      context 'when no childs is given' do
        it 'all attributes should be set with right and left nil' do
          expect(node.byte).to eq byte
          expect(node.frequency).to eq frequency
          expect(node.right).to eq nil
          expect(node.left).to eq nil
        end
      end

      context 'when right and left is given' do
        let(:right) { HuffCompress::Node.new 'b', 5 }
        let(:left) { HuffCompress::Node.new 't', 3 }
        let(:node) { HuffCompress::Node.new byte, frequency, right: right, left: left }

        it 'right and left should be set' do
          expect(node.right).to eq right
          expect(node.left).to eq left
        end
      end

    end
  end

  describe '#each' do
    let(:left)  { HuffCompress::Node.new 'a', 1 }
    let(:right) { HuffCompress::Node.new 'b', 2 }
    let(:tree)  { HuffCompress::Node.new 'c', 3, left: left, right: right }

    before do
      @result = []

      tree.each do |node|
        @result << node.byte 
      end
    end

    context 'when right and left is given' do
      it 'result should be [a, c, b]' do
        expect(@result).to eq ['a', 'c', 'b']
      end     
    end

    context 'when only right is given' do
      let(:tree)  { HuffCompress::Node.new 'c', 3, right: right }

      it 'result should be [c, b]' do
        expect(@result).to eq ['c', 'b']
      end     
    end

    context 'when only left is given' do
      let(:tree)  { HuffCompress::Node.new 'c', 3, left: left }

      it 'result should be [a, c]' do
        expect(@result).to eq ['a', 'c']
      end     
    end
  end

  describe '#leaf?' do
    let(:left)  { nil }
    let(:right) { nil }
    let(:node)  { HuffCompress::Node.new 'a', 4, left: left, right: right }

    context 'when the node is a leaf' do
      it { expect(node.leaf?).to be_truthy } 
    end

    context 'when the node is not a leaf' do
      let(:left)  { HuffCompress::Node.new 'a', 1 }
      let(:right) { HuffCompress::Node.new 'b', 2 }

      it { expect(node.leaf?).to be_falsey }
    end
  end

end
