# config/initializers/raven.rb
require 'raven'

logger = ::Logger.new("log/raven.log")
logger.level = ::Logger::DEBUG

Raven.configure do |config|
  config.logger = logger
  config.current_environment = Rails.env
  # Modify this if your environments are different
  config.environments = %w[ production staging test ]
  config.tags = { environment: Rails.env }
  config.dsn = 'http://3727fed5ee974ad8816e1ebbcd0172a1:fa83b4b6af8d45d1b9e0002af1367a5e@ex.icicletech.com/12'
end
