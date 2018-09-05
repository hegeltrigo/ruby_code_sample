require_relative 'team'
require_relative 'match'

class Ranking
  attr_accessor :teams, :matches, :exists_file

  def initialize(file_path)
    @file_path = file_path
    @teams = []
    @matches = []
    if File.file?(@file_path)
      @exists_file = true
      read_file
    else
      @exists_file = false
    end
  end

  def read_file
    f = File.open(@file_path)
    f.each_line do |line|
      left = read_team_from_match(line, 0)
      right = read_team_from_match(line, 1)
      match = Match.new(left[:team], left[:team_points], right[:team], right[:team_points])
      matches << match
    end
    f.close
  end

  def read_team_from_match(line, side)
    team = Team.new(line.split(',')[side].rpartition(' ').first.strip,0)
    team_points = (line.split(',')[side].rpartition(' ').last.strip).to_i
    teams << team if !teams.any?{|a| a.name == team.name }
    {team: team, team_points: team_points}
  end

  def write_file
    data = create_rows
    File.open("output.txt", "w") do |f|
      data.each do |row|
        f.puts row
      end
    end
  end

  def calculate_points(team, points = 0)
    matches.each do |match|
      if(match.left_team == team || match.right_team == team)
        points += get_result(match,team)
      end
    end
    points
  end

  def get_result(match,team)
    if match.is_tie?
      1
    elsif match.winner == team
      3
    else
      0
    end
  end

  def update_team_points
    teams.each_with_index do |team, index|
      teams[index].points = calculate_points(team)
    end
  end

  def order_teams
    ordered_teams = teams.sort_by(&:name).reverse.sort_by(&:points).reverse
  end

  def create_rows(count=0,position=0, rows=[])
    teams = order_teams
    while  count < teams.size  do
      team = teams[count]
      position +=1 unless teams[count-1].points == teams[count].points if count > 0
      rows << "#{position+1}. #{team.name}, #{team.points} #{points_text_format(team.points)}"
      count +=1
    end
    rows
  end

  def show_data(count=0,position=0, rows=[])
    teams = order_teams
    while  count < teams.size  do
      team = teams[count]
      position +=1 unless teams[count-1].points == teams[count].points if count > 0
      p "#{position+1}. #{team.name}, #{team.points} #{points_text_format(team.points)}"
      count +=1
    end
    rows
  end

  def points_text_format(points)
    points == 1 ? 'pt' : 'pts'
  end

end



loop do
  prompt = "> "
  puts "Please write a file name to read ex: sample-input.txt or q to exit"
  print prompt

  input = gets.chomp
  exit if input == 'q'

  ranking = Ranking.new(input)
  if ranking.exists_file
    ranking.update_team_points
    ranking.write_file
    ranking.show_data
    p "The file has been created successfully!, check file in root folder as output.txt"
    print prompt

  else
    p 'File does not exists, please introduce a valid name file'
    print prompt
  end
end
