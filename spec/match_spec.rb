require_relative '../team'
require_relative '../match'

describe Match do


  describe 'winner' do
    subject { described_class.new(Team.new("Lions",0), 4, Team.new('Real Madrid',0), 3) }

    it "expect to be an instance of Team" do
      expect(subject).to be_instance_of(Match)
    end

    it "have have a winner" do
      expect(subject.winner).to eq(Team.new('Lions',0))
    end

    it "have have a looser" do
      expect(subject.looser).to eq(Team.new('Real Madrid',0))
    end

    it 'knows if there is a tie' do
      expect(subject.is_tie?).to eq(false)
    end

  end

  describe 'tie' do
    subject { described_class.new(Team.new("Lions",0), 4, Team.new('Real Madrid',0), 4) }

    it 'knows if there is a tie' do
      expect(subject.is_tie?).to eq(true)
    end

    it 'have have a nil winner' do
      expect(subject.winner).to be_nil
    end

    it 'have have a nil looser' do
      expect(subject.looser).to be_nil
    end

  end

end
