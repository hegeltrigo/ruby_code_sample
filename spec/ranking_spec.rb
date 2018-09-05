require_relative '../team'
require_relative '../match'
require_relative '../ranking'

describe Ranking do

    describe 'File does not exist' do
      subject { described_class.new('file.txt') }

      it "expect a correct file" do
        expect(subject).to be_instance_of(Ranking)
      end

      it "have doesnt have a file" do
        expect(subject.exists_file).to eq(false)
      end
    end

    describe 'File exists' do
      subject { described_class.new('sample-input.txt') }

      it "have a file" do
        expect(subject.exists_file).to eq(true)
      end

    end

    # ...

end
