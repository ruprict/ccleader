loggly = Logglier.new('https://logs-01.loggly.com/inputs/3e8f8c6f-2161-4544-8c04-bc134ac82590/tag/rails', threaded: true, format: :json)
Rails.logger.extend(ActiveSupport::Logger.broadcast(loggly))
