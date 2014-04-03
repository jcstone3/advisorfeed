# config valid only for Capistrano 3.1
# lock '3.1.0'
#
# set :application, 'advisorfeed'
# set :repo_url, 'git@example.com:me/my_repo.git'
#
# set :pty, true
#
# set :stages, %w(production staging)

# Default branch is :master
# ask :branch, proc { `git rev-parse --abbrev-ref HEAD`.chomp }

# If just cap deply is run, it will by-default deploy to staging server
#
# set :default_stage, "staging"

# Authentication info
# Here we are setting the user info for deployment

######################################################################################################

# set :application, "advisorfeed"
# set :repository,  "git@code.icicletech.com:ri/advisor-feed.git"

# set :path, "/home/icicle/sites/advisorfeed"

# # Location  for deployment i.e server name

# role :web, "localhost"      # Your HTTP server, Apache/etc
# role :app, "localhost"      # This may be the same as your `Web` server
# role :db, "localhost"       # This is where Rails migrations will run

# # server "localhost", :app, :web, :primary => true
# set :deploy_to, "/home/icicle/sites/advisorfeed"
# set :rails_env, "staging"

# set :user_sudo, false
# set :user, "icicle"
# set :admin_runner, "icicle"

# # set :scm, :git # You can set :scm explicitly or Capistrano will make an intelligent guess based on known version control directory names
# # Or: `accurev`, `bzr`, `cvs`, `darcs`, `git`, `mercurial`, `perforce`, `subversion` or `none`

# # There is two environment staging and production set here.
# set :stages, %w(production staging test development)

# # Set the  default environment                                                                                                                             $
# # If just cap deply is run, it will by-default deploy to staging server
# set :default_stage, "staging"

# # Authentication info
# # Here we are setting the user info for deployment
# ssh_options[:forward_agent] = true
# default_run_options[:pty] = true
# # require 'capistrano/ext/multistage'
# require 'bundler/capistrano'
# # require "rvm/capistrano"
# set :scm, :git

# # this is needed for any server running RVM; tells it to use the project ruby and gem set
# # tells RVM on the remote server which package we're using -- must match what is in the .rvmrc
# set :rvm_type, :system
# set :rvm_path, '/usr/local/rvm'
# set :rvm_ruby_string, 'ruby-2.1.0'

# # To deploy upto particular tag
# # set :branch do
# #   default_tag = `git describe --abbrev=0 --tags`
# #   tag = default_tag
# #   tag
# # end

# set :branch, "ss_capistrano"

# # Load RVM's capistrano plugin
# load "deploy/assets"

# namespace :folder do
#   desc "creating folders for application"
#   task :setup, :except => { :no_release => true } do
#     run "mkdir -p #{shared_path}/sockets"
#   end

#   desc "creating symlinks for the folders"
#   task :symlink, :except => { :no_release => true } do
#     run "ln -nfs #{shared_path}/sockets #{release_path}/tmp/sockets"
#   end
# end


# namespace :db do

#     desc <<-DESC
#       Creates the database.yml configuration file in shared path.

#       By default, this task uses a template unless a template
#       called database.yml.erb is found either is :template_dir
#       or /config/deploy folders. The default template matches
#       the template for config/database.yml file shipped with Rails.

#       When this recipe is loaded, db:setup is automatically configured
#       to be invoked after deploy:setup. You can skip this task setting
#       the variable :skip_db_setup to true. This is especially useful
#       if you are using this recipe in combination with
#       capistrano-ext/multistaging to avoid multiple db:setup calls
#       when running deploy:setup for all stages one by one.
#     DESC
#     task :setup, :except => { :no_release => true } do

#       default_template = <<-EOF
#       base: &base
#         adapter: postgresql
#         timeout: 5000
#         username: postgres
#         password: macro129
#       development:
#         database: advisor_development
#         <<: *base
#       test:
#         database: advisor_test
#         <<: *base
#       staging:
#         database: advisorfeed_staging
#         <<: *base
#       production:
#         database: advisorfeed_production
#         <<: *base
#       EOF

#       location = fetch(:template_dir, "config/deploy") + '/database.yml.erb'
#       template = File.file?(location) ? File.read(location) : default_template

#       config = ERB.new(template)

#       run "mkdir -p #{shared_path}/db"
#       run "mkdir -p #{shared_path}/config"
#       put config.result(binding), "#{shared_path}/config/database.yml"
#     end

#     desc <<-DESC
#       [internal] Updates the symlink for database.yml file to the just deployed release.
#     DESC
#     task :symlink, :except => { :no_release => true } do
#       run "ln -nfs #{shared_path}/config/database.yml #{release_path}/config/database.yml"
#       #run "ln -nfs #{shared_path}/log #{release_path}/log/#{rails_env}.log"
#     end
#   end

#   desc "Loads seed data in the application"
#   task :seed_data, :except => { :no_release => true } do
#     run "cd #{current_path} && rake db:seed RAILS_ENV=#{rails_env} "
#   end

# # Creating backup folder and storing database dump in that folder
# namespace :backup do
#   desc "Backup the database"
#   task :db, :roles => :db do
#     run "mkdir -p #{shared_path}/backups"
#     run "cd #{shared_path}; pg_dump -U postgres #{application}_#{rails_env} -f backups/#{Time.now.utc.strftime('%Y%m%d%H%M%S')}.sql"
#   end

#  # Downloading the latest database backup
#   desc "Backup the database and download the script"
#   task :download, :roles => :app do
#     db
#     timestamp = Time.now.utc.strftime('%Y%m%d%H%M%S')
#     run "mkdir -p backups"
#     run "cd #{shared_path}; tar -cvzpf #{timestamp}_backup.tar.gz backups"
#     get "#{shared_path}/#{timestamp}_backup.tar.gz", "#{timestamp}_backup.tar.gz"
#   end
# end


# # This will restart the nginx and unicorn
# namespace :restart do
# desc "Restarting Nginx"
# task :nginx_restart, :roles => :app do
#   sudo "service nginx restart"
# end

# desc "Restarting Unicorn"
# task :unicorn_restart, :roles => :app do
#   sudo "service unicorn restart"
# end

# # This will restart the sidekiq through monit
# #desc "Restart sidekiq"
# #task :sidekiq_restart, :roles => :app do
# #  run "sudo /usr/bin/monit restart sidekiq"
# #  end
# end


# # access current environment log file
# namespace :utilities do
#    desc "Runs rake deploy:log_tail to get remote server log details"
#    task :log_tail do
#      stream "tail -f #{current_path}/log/#{rails_env}.log"
#    end
#   desc "Run a command from the Rails Root on the remote server. Specify command='my_command'."
#     task :rails_root do
#       puts "Executing \"#{ENV['command']}\" from the Rails Root on the server."
#       run "cd #{current_path}; #{ENV['command']}"
#     end

# #namespace :rails do

#   desc "Remote console access"
#   task :console do
#     rails_env = fetch(:rails_env)
#       server = ""
#       if rails_env == 'production'
#         server = find_servers(:roles => [:production]).first
#       end
#       if rails_env == 'staging'
#         server = find_servers(:roles => [:staging]).first
#       end
#     run_interactively "rails c #{rails_env}","#{server}"
#   end

# desc "Remote dbconsole access"
#   task :dbconsole do
#     rails_env = fetch(:rails_env)
#       server = ""
#       if rails_env == 'production'
#         server = find_servers(:roles => [:production]).first
#       end
#       if rails_env == 'staging'
#         server = find_servers(:roles => [:staging]).first
#       end
#     run_interactively "rails db #{rails_env} -p","#{server}"
#   end
# end

# def run_interactively(command, server)
#   if server != ""
#     exec %Q(echo #{server} && ssh #{user}@#{server} -t 'source ~/.bash_profile && cd #{current_path} && #{command}')
#   else
#     exec "echo 'No Environment (i.e. RAILS_ENV) specified'"
#   end
# end


# #disk related information
# namespace :disk do
#  desc "Show the amount of free disk space."
#   task :free, :roles => :web do
#     run "df -h /"
#   end

#   desc "Show free memory"
#   task :memory, :roles => :web do
#     run "free -m"
#   end
# end

# after "deploy:setup", "db:setup"   unless fetch(:skip_db_setup, false)
# after "db:setup", "folder:setup"
# after "deploy:finalize_update", "db:symlink"
# after "db:symlink", "folder:symlink"
# after "deploy", "restart:nginx_restart"
# after "restart:nginx_restart", "restart:unicorn_restart"
# after "restart:unicorn_restart","deploy:cleanup"
# after "restart:unicorn_restart","restart:sidekiq_restart"
# after "deploy:create_symlink", "deploy:update_crontab"
# after "deploy:update_crontab", "deploy:database_symlink"
# after "deploy", "deploy:restart"
# after "deploy:restart", "deploy:cleanup"

#####################################################################################################

require 'bundler/capistrano'
require 'capistrano/ext/multistage'
require "rvm/capistrano"

set :application, "advisorfeed"
set :repository,  "git@code.icicletech.com:ri/advisor-feed.git"
# set :rvm_type, :system
# set :rvm_path, '/usr/local/rvm'
set :rvm_ruby_string, 'ruby-2.1.0'

set :deploy_to, "/home/icicle/sites/advisorfeed"
set :scm, :git
set :branch, "ss_capistrano"
set :user, "icicle"

set :copy_dir, "/home/#{user}/tmp"
set :remote_copy_dir, "/tmp"

# set :group, "deployers"
set :use_sudo, false
set :rails_env, "staging"
set :deploy_via, :copy
# set :ssh_options, { :forward_agent => true}
ssh_options[:forward_agent] = true
set :keep_releases, 5
default_run_options[:pty] = true
server "localhost", :app , :web, :db, :primary => true

namespace :deploy do
  task :start do
  end
  task :stop do
  end

  desc "Symlink shared config files"
  task :symlink_config_files do
    run "#{ sudo } ln -s #{ deploy_to }/shared/config/database.yml #{ current_path }/config/database.yml"
  end

  # NOTE: I don't use this anymore, but this is how I used to do it.
  desc "Precompile assets after deploy"
  task :precompile_assets do
    run <<-CMD
      cd #{ current_path } &&
      #{ sudo } bundle exec rake assets:precompile RAILS_ENV=#{ rails_env }
    CMD
  end

  desc "Restart applicaiton"
  task :restart do
    run "#{ try_sudo } touch #{ File.join(current_path, 'tmp', 'restart.txt') }"
  end
end

after "deploy", "deploy:symlink_config_files"
after "deploy", "deploy:restart"
after "deploy", "deploy:cleanup"
