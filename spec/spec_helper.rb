require File.join(File.dirname(__FILE__), '..', 'my_app.rb')

require 'rubygems'
require 'sinatra'
require 'rack/test'
require 'rspec'

set :environment, :test
set :run, false
set :raise_errors, true
set :logging, false

RSpec.configure do |config|
  # for sinatra
  config.include Rack::Test::Methods

  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

end

include Rack::Test::Methods
APPS = Rack::Builder.parse_file(File.expand_path("#{File.dirname(__FILE__)}/../config.ru"))
