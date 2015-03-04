module Boards
  class GetService < Boards::Base
    def execute(options = {})
      return unless member_exists?(options[:name])
      leaderboard.score_and_rank_for(options[:name])
    end

    private

    def member_exists?(name)
      leaderboard.check_member?(name)
    end
  end
end
