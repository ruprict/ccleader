module Boards
  DEFAULT_BOARD = 'ccleaders'
  
  def self.default_leaderboard
    Leaderboard.new(
      DEFAULT_BOARD,
      default_options,
      redis_connection: Redis.current
    )
  end

  def self.default_options
    puts 'HI'
    Leaderboard::DEFAULT_OPTIONS.merge(
      page_size: 10
    )
  end
end
