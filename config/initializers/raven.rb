# config/initializers/raven.rb
unless (Rails.env.test? || Rails.env.development?)
  require 'raven'

  logger = ::Logger.new("log/raven.log")
  logger.level = ::Logger::DEBUG

  Raven.configure do |config|
    config.logger = logger
    config.current_environment = Rails.env
    # Modify this if your environments are different
    config.environments = %w[ production staging testing ]
    config.tags = { environment: Rails.env }
    config.dsn = 'http://f1cba507756e4fd0b3eb2173f2d85a56:a74d3cdb015543729906221d43a61bb8@ex.icicletech.com/10'
  end
end