module TeamStatHelpers

  def games_played_against_opponents(team_id)
    opponent_games_played = Hash.new(0)
    @games.each do |game|
      if game.away_team_id == team_id
        opponent_games_played[game.home_team_id] += 1
      elsif game.home_team_id == team_id
        opponent_games_played[game.away_team_id] += 1
      end
    end
    opponent_games_played
  end

  def games_lost_against_opponents(team_id)
    opponent_games_won = Hash.new(0)
    @games.each do |game|
      if game.away_team_id == team_id && game.outcome.include?('away')
        opponent_games_won[game.home_team_id] += 1
      elsif game.home_team_id == team_id && game.outcome.include?('home')
        opponent_games_won[game.away_team_id] += 1
      end
    end
    opponent_games_won
  end


  def games_played_vs_opponent_percentage(team_id)
    percentage_won = {}
    games_played_against_opponents(team_id).each do |id, gp|
      percentage_won[id] =  games_lost_against_opponents(team_id)[id] / gp.to_f
    end
    percentage_won
  end

  def collect_games_by_season(team_id)
    season_hash = Hash.new
    @games.each do |game|
      if game.home_team_id == team_id || game.away_team_id == team_id
        season_hash[game.season] = game
      end
    end
    season_hash
  end

  # def reg_vs_post(team_id)
  #   reg_hash = {}
  #   post_hash = {}
  #   collect_games_by_season(team_id).each do |season, game|
  #     if game.type == "P"
  #       collect_games_by_season(team_id)[season] = (post_hash[:postseason] = game)
  #     elsif game.type == "R"
  #       collect_games_by_season(team_id)[season] = (reg_hash[:regular_season] = game)
  #     end
  #   end
  #
  #   collect_games_by_season(team_id)
  # end

  # def setup_reg_season_hash(team_id)
  #   reg_season = {}
  #   reg_season[:regular_season] = {
  #     :win_percentage => 0,
  #     :total_goals_scored => 0,
  #     :total_goals_against => 0,
  #     :average_goals_scored => 0,
  #     :average_goals_against => 0,
  #   }
  #   reg_season
  # end

  # def setup_post_season_hash(team_id)
  #   post_season = {}
  #   post_season[:postseason] = {
  #     :win_percentage => 0,
  #     :total_goals_scored => 0,
  #     :total_goals_against => 0,
  #     :average_goals_scored => 0,
  #     :average_goals_against => 0,
  #   }
  #   post_season
  # end
end
