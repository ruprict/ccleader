module Boards
  class DeleteService < Boards::Base
    def execute(options = {})
      return unless member_exists?(options[:name])
      leaderboard.remove_member(options[:name])
    end

    private

    def member_exists?(name)
      leaderboard.check_member?(name)
    end
  end
end
