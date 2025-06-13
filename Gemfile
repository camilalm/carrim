source "https://rubygems.org"

ruby "3.3.1"
gem "rails", "~> 7.1.3", ">= 7.1.3.2"
gem "pg", "~> 1.1"
gem "puma", ">= 5.0"
gem "tzinfo-data", platforms: %i[ windows jruby ]
gem "bootsnap", require: false

gem 'redis', '~> 5.2' # TODO: redis 7.0.15
gem 'sidekiq', '~> 7.2', '>= 7.2.4'
gem 'sidekiq-scheduler', '~> 5.0', '>= 5.0.3'

gem 'guard'
gem 'guard-livereload', require: false

gem 'active_model_serializers', '~> 0.10.0'

group :development, :test do
  gem 'byebug', '~> 12.0'
  gem 'database_cleaner', '~> 2.1.0' # strategies for cleaning your database in Ruby
  gem "debug", platforms: %i[ mri windows ]
  gem "factory_bot_rails", "~> 6.4" # fixtures replacement with a straightforward definition syntax
  gem 'faker', '~> 3.5.1' # it's a library for generating fake data
  gem 'rspec-rails', '~> 6.1.0'
end

group :development do
end
