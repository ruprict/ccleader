module Boards
  class GetAllService
    def execute(options = {})
      leaderboard.leaders(
        page(options),
        page_size: page_size(options)
      )
    end

    private

    def page(options)
      options[:page] || 1
    end

    def page_size(options)
      options[:page_size] || 10
    end

    def leaderboard
      @leaderboard ||= Boards.default_leaderboard
    end
  end
end
