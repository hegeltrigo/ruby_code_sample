class Team
  attr_accessor :name, :points

  def initialize(name, points)
      @name = name
      @points = points
  end

  def ==(another_team)
    self.name == another_team.name
  end
end
