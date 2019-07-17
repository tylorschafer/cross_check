class Game

  attr_reader :data, :games, :game_id, :season, :type,
  :date_time, :away_team_id, :home_team_id, :away_goals,
  :home_goals, :outcome

  def initialize(data)
    @data = data
    @game_id = data["game_id"]
    @season = data["season"]
    @type = data["type"]
    @date_time = data["date_time"]
    @away_team_id = data["away_team_id"]
    @home_team_id = data["home_team_id"]
    @away_goals = data["away_goals"]
    @home_goals = data["home_goals"]
    @outcome = data["outcome"]
    @home_rink_side_start = data["home_rink_side_start"]
    @venue = data["venue"]
    @venue_link = data["venue_link"]
    @venue_time_zone_id = data["venue_time_zone_id"]
    @venue_time_zone_offset = data["venue_time_zone_offset"]
    @venue_time_zone_tz = data["venue_time_zone_tz"]
  end

end
