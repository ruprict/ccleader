module Boards
  class UpdateService < Boards::Base
    def execute(entry_params)
      name = entry_params[:name]
      score = entry_params[:score].to_i
      leaderboard.rank_member(name, score)
      member = leaderboard.score_and_rank_for(name)
      member[:page] = leaderboard.page_for(name, leaderboard.page_size)
      member
    end
  end
end
