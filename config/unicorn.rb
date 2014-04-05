# Sample verbose configuration file for Unicorn (not Rack)
#
# This configuration file documents many features of Unicorn
# that may not be needed for some applications. See
# http://unicorn.bogomips.org/examples/unicorn.conf.minimal.rb
# for a much simpler configuration file.
#
# See http://unicorn.bogomips.org/Unicorn/Configurator.html for complete
# documentation.

# Use at least one worker per core if you're on a dedicated server,
# more will usually help for _short_ waits on databases/caches.

worker_processes 1

# nuke workers after 30 seconds instead of 60 seconds (the default)
timeout 30

# "current" directory that Capistrano sets up.
rails_root  = `pwd`.gsub("\n", "")
@dir = "#{rails_root}/"
#@dir = "/home/ubuntu/sites/ltbuddy/current/"
working_directory @dir  # available in 0.94.0+

# listen on both a Unix domain socket and a TCP port,
# we use a shorter backlog for quicker failover when busy
listen "#{@dir}tmp/sockets/unicorn.sock", :backlog => 64
#listen 8080, :tcp_nopush => true

# feel free to point this anywhere accessible on the filesystem
pid "#{@dir}tmp/pids/unicorn.pid"

# By default, the Unicorn logger will write to stderr.
# Additionally, ome applications/frameworks log to stderr or stdout,
# so prevent them from going to /dev/null when daemonized here:
stderr_path "#{@dir}log/unicorn.stderr.log"
stdout_path "#{@dir}log/unicorn.stdout.log"
# combine Ruby 2.0.0dev or REE with "preload_app true" for memory savings
# http://rubyenterpriseedition.com/faq.html#adapt_apps_for_cow

preload_app true
#GC.respond_to?(:copy_on_write_friendly=) and
 # GC.copy_on_write_friendly = true

# Enable this flag to have unicorn test client connections by writing the
# beginning of the HTTP headers before calling the application.  This
# prevents calling the application for connections that have disconnected
# while queued.  This is only guaranteed to detect clients on the same
# host unicorn runs on, and unlikely to detect disconnects even on a
# fast LAN.
#check_client_connection false
#
before_fork do |server, worker|
  if defined?(ActiveRecord::Base)
    ActiveRecord::Base.connection.disconnect!
    Rails.logger.info('Disconnected from ActiveRecord')
  end

  # If you are using Redis but not Resque, change this
  # if defined?(Resque)
  #   Resque.redis.quit
  #   Rails.logger.info('Disconnected from Redis')
  # end

  sleep 1
end

after_fork do |server, worker|
  if defined?(ActiveRecord::Base)
    ActiveRecord::Base.establish_connection
    Rails.logger.info('Connected to ActiveRecord')
  end

  # If you are using Redis but not Resque, change this
  # if defined?(Resque)
  #   Resque.redis = ENV['REDIS_URI']
  #   Rails.logger.info('Connected to Redis')
  # end

  # heroku = nil
  # if ENV['HEROKU_APP']
  #   heroku = Autoscaler::HerokuScaler.new
  # end


  # Sidekiq.configure_client do |config|
  #   config.redis = { :url => ENV['REDISTOGO_URL'], :size => 1 }

  #   # if heroku
  #   #   config.client_middleware do |chain|
  #   #     chain.add Autoscaler::Sidekiq::Client, 'default' => heroku
  #   #   end
  #   # end
  # end
end
