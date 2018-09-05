class Match
  attr_accessor :left_team, :points_left_team, :right_team, :points_right_team

  def initialize(left_team, points_left_team, right_team, points_right_team)
      @left_team = left_team
      @points_left_team = points_left_team
      @right_team = right_team
      @points_right_team = points_right_team
  end

  def winner
    if points_left_team > points_right_team
      left_team
    elsif points_right_team > points_left_team
      right_team
    end
  end

  def looser
    if points_left_team < points_right_team
      left_team
    elsif points_right_team < points_left_team
      right_team
    end
  end

  def is_tie?
    points_left_team == points_right_team
  end

end
