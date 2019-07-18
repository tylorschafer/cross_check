module LeagueStats

  def convert_id_to_name(id)
    team = @teams.find {|team| team.team_id == id}
    team.team_name
  end

  def home_team_goals
    goals_home_team = Hash.new(0)
    @games.each do |game|
      goals_home_team[game.home_team_id] += game.home_goals
    end
    goals_home_team
  end

  def away_team_goals
    goals_away_team = Hash.new(0)
    @games.each do |game|
      goals_away_team[game.away_team_id] += game.away_goals
    end
    goals_away_team
  end

  def home_games_played
    games_home_played = Hash.new(0)
    @games.each do |game|
      games_home_played[game.home_team_id] += 1
    end
    games_home_played
  end

  def away_games_played
    games_away_played = Hash.new(0)
    @games.each do |game|
      games_away_played[game.away_team_id] += 1
    end
    games_away_played
  end

  def total_games_played
    total_games_played = away_games_played.merge!(home_games_played) do |id, ag, hg|
      ag + hg
    end
  end

  def highest_scoring_home_team
    high_team = home_team_goals.max_by do |team, goals|
          (goals.to_f / home_games_played[team])
      end
    convert_id_to_name(high_team[0])
  end

  def lowest_scoring_home_team
    low_team = home_team_goals.min_by do |team, goals|
          (goals.to_f / home_games_played[team])
      end
    convert_id_to_name(low_team[0])
  end

  def highest_scoring_away_team
    away_high = away_team_goals.max_by do |id, goals|
      (goals.to_f / away_games_played[id])
    end
    convert_id_to_name(away_high[0])
  end

  def lowest_scoring_away_team
    away_low = away_team_goals.min_by do |id, goals|
      (goals.to_f / away_games_played[id])
    end
    convert_id_to_name(away_low[0])
  end

  def count_of_teams
    @teams.count {|team| team.team_id}
  end

  def offense_helper
    total_goal_by_team = Hash.new(0)
    @game_teams.each do |game|
      total_goal_by_team[game.team_id] += game.goals.to_f
    end
    total_goal_by_team

     total_games_by_teams = Hash.new(0)
     @game_teams.each do |game|
      total_games_by_teams[game.team_id] += 1
    end
    total_games_by_teams


    avg_offense = Hash.new
    total_goal_by_team.map do |team_id, total_goals|
      avg_offense[team_id] = (total_goal_by_team[team_id]/total_games_by_teams[team_id]).round(2)
    end
    avg_offense
  end

  def best_offense
    avg_offense = offense_helper
    best_offense_team = avg_offense.max_by {|team_id, avg_goals| avg_goals}
    convert_id_to_name(best_offense_team[0])
  end

  def worst_offense
    avg_offense = offense_helper
    best_offense_team = avg_offense.min_by {|team_id, avg_goals| avg_goals}
    convert_id_to_name(best_offense_team[0])
  end

  def home_team_goals_against
    goals_against_home_team = Hash.new(0)
    @games.each do |game|
      goals_against_home_team[game.home_team_id] += game.away_goals
    end
    goals_against_home_team
  end

  def away_team_goals_against
    goals_against_away_team = Hash.new(0)
    @games.each do |game|
      goals_against_away_team[game.away_team_id] += game.home_goals
    end
    goals_against_away_team
  end

  def total_goals_against
    total_goals_against = away_team_goals_against.merge!(home_team_goals_against) do |id, aga, hga|
      aga + hga
    end
    total_goals_against
  end

  def best_defense
    top_defense = total_goals_against.min_by do |team_id, goals|
      (goals.to_f/ total_games_played[team_id])
    end
    convert_id_to_name(top_defense[0])
  end

  def worst_defense
    lowest_defense = total_goals_against.max_by do |team_id, goals|
      (goals.to_f/ total_games_played[team_id])
    end
    convert_id_to_name(lowest_defense[0])
  end
end