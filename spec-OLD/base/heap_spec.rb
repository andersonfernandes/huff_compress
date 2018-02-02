require 'base/heap'

describe Base::Heap do
  let(:node_1) { Base::Node.new 1, 100 }
  let(:node_2) { Base::Node.new 2, 1 }
  let(:node_3) { Base::Node.new 3, 50 }
  
  let(:push_nodes) do
    subject.push node_1
    subject.push node_2
    subject.push node_3
  end

  describe '#push' do
    before { push_nodes }

    it 'min element should be node_1' do
      expect(subject.min).to eq node_2 
    end

    it 'heap elements should be [nil, node_2, node_1, node_3]' do
      expect(subject.elements).to eq [nil, node_2, node_1, node_3]
    end
  end

  describe '#pop' do
    before do 
      push_nodes

      @pop_result = subject.pop
    end

    it 'should eq node_2' do
      expect(@pop_result).to eq node_2
    end

    it 'min element should eq node_3' do 
      expect(subject.min).to eq node_3
    end
  end
end
