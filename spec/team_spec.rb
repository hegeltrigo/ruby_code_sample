require_relative '../team'

describe Team do
  subject { described_class.new('Lions', 0) }

  it "expect to be an instance of Team" do
    expect(subject).to be_instance_of(Team)
  end

  it "have points param" do
    expect(subject.points).to eq(0)
  end

  it "have a name param" do
    expect(subject.name).to eq('Lions')
  end

  it "have initialize params" do
    expect { Team.new }.to raise_error(ArgumentError, "wrong number of arguments (given 0, expected 2)")
  end

  it 'compares two instance if are equals only by name' do
    a = Team.new("Lions", 0)
    b = Team.new("Lions", 60)
    expect(a).to eq(b)

  end

end
