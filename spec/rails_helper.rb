# frozen_string_literal: true

ENV['RAILS_ENV'] ||= 'test'

require File.expand_path('../config/environment', __dir__)

if Rails.env.production?
  abort('The Rails environment is running in production mode!')
end

require 'rspec/rails'
require 'spec_helper'
require 'geocode_helper'

RSpec.configure do |config|
  config.include FactoryBot::Syntax::Methods
end
