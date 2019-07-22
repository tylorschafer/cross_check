require './test/test_helper'

class SeasonStatTest < Minitest::Test

  def setup
    game_path = './data/dummy_data/dummy_data_game.csv'
    team_path = './data/dummy_data/dummy_data_teams.csv'
    game_teams_path = './data/dummy_data/dummy_data_game_team.csv'
    @file_names = {
      games: game_path,
      teams: team_path,
      game_teams: game_teams_path
    }
    @tracker = StatTracker.from_csv(@file_names)
  end

  def test_biggest_bust
    assert_equal "Canadiens", @tracker.biggest_bust("20122013")
  end

  def test_biggest_surprise
    assert_equal "Senators", @tracker.biggest_surprise("20122013")
  end
end
