# frozen_string_literal: true

source 'https://rubygems.org'

ruby File.read('.ruby-version').strip

gem 'bcrypt', '~> 3.1.7'
gem 'bootsnap', '>= 1.1.0', require: false
gem 'pg'
gem 'puma', '~> 3.11'
gem 'rails', '~> 5.2.0'
gem 'redis'

gem 'geocoder'
gem 'jwt'

group :development, :test do
  gem 'database_cleaner'
  gem 'factory_bot_rails'
  gem 'guard-rspec', require: false
  gem 'rspec'
  gem 'rspec-rails'
  gem 'webmock'
end

group :development do
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'rubocop', require: false
  gem 'rubocop-rspec', require: false
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]
