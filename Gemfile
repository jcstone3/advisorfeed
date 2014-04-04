source 'https://rubygems.org'

# ruby version
ruby "2.1.0"

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.0.3'

# Use pg as the database for Active Record
gem 'pg'

# Use LESS for stylesheets
gem "therubyracer"
gem "less-rails" #Sprockets (what Rails 3.1 uses for its asset pipeline) supports LESS
gem "twitter-bootstrap-rails"

# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'

# Use CoffeeScript for .js.coffee assets and views
gem 'coffee-rails', '~> 4.0.0'

# See https://github.com/sstephenson/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails'

# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'

# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 1.2'

#AWS - uploading reports on s3 bucket
gem 'aws-sdk'

group :doc do
  # bundle exec rake doc:rails generates the API under doc/api.
  gem 'sdoc', require: false
end

#Authentication & Authorization
gem 'devise'
#gem 'devise_security_extension'
gem 'devise_invitable'
gem 'devise-async'

# Forms
gem 'simple_form'

# Upload reports for user
gem "paperclip"

#to download uploaded report
gem 'wicked_pdf'

# Pagination
gem 'will_paginate', '~> 3.0'

#To receive exception mail
gem 'exception_notification', :git => "git://github.com/rails/exception_notification.git",
        :require => "exception_notifier"

#Development
group :development do
	gem 'bullet'
	gem 'paint'
	gem 'quiet_assets' #Removes Asset Pipeline Request
	gem 'annotate'       #Annotating Models, Routes

	#Quality
  gem 'rails_best_practices', require: false
  gem 'rubocop', require: false

  #Security
  gem 'brakeman', require: false

  gem 'better_errors' #Only in Dev environment

  #Automating with Guard
	# gem 'guard'
	gem 'libnotify'
  gem 'rb-inotify', require: false
  gem 'guard-annotate'
  gem 'guard-rails_best_practices'
  gem 'guard-rubocop'
  gem 'yard', require: false
  gem "binding_of_caller"
end

#Testing
group :test, :development do
  gem 'cucumber-rails', require: false
  gem 'rspec-rails'
  #gem 'rspec-gc-control'
  gem 'capybara'
  gem 'capybara-webkit'
  gem 'database_cleaner'
  gem 'launchy'
  gem 'guard'
  gem 'guard-cucumber'
  gem 'guard-rspec'
  gem 'factory_girl_rails'
  gem 'shoulda-matchers'
# gem 'highline', '~> 1.6.9'
  gem 'populator'
  gem 'random_data'
  gem 'faker'
  gem 'parallel_tests'
  gem 'zeus-parallel_tests'
  gem 'email_spec'
  gem 'action_mailer_cache_delivery'
  gem 'letter_opener'
end

group :test do
  gem 'capybara-screenshot'
  gem 'zeus'
  gem 'accept_values_for' #Rspec Macro to accept values in array https://github.com/bogdan/accept_values_for
  gem 'simplecov'
  gem 'syntax'
end

gem 'rails_12factor', group: :production

# Use ActiveModel has_secure_password
# gem 'bcrypt-ruby', '~> 3.1.2'

# Use unicorn as the app server
# gem 'unicorn'

# Use Capistrano for deployment
# gem 'capistrano', group: :development

# Use debugger
# gem 'debugger', group: [:development, :test]
