module Boards
  class GetAllService < Boards::Base
    def execute(options = {})
      leaderboard.leaders(
        page(options).to_i,
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
  end
end
