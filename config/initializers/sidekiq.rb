require 'sidekiq'

Sidekiq.configure_client do |config|
  config.redis = { :url => ENV['REDISTOGO_URL'], :size => 5 }
end

Sidekiq.configure_server do |config|
  config.redis = { :url => ENV['REDISTOGO_URL'], :size => 10 }
  config.server_middleware do |chain|
    #Additional config here
  end
end
