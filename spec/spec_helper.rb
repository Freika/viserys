ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rspec/rails'
require 'capybara/rspec'
require 'capybara/webkit'
require 'factory_girl_rails'
require 'database_cleaner'
require 'timecop'

Dir[Rails.root.join('spec/support/**/*.rb')].each {|f| require f}

Capybara.javascript_driver = :webkit

RSpec.configure do |config|

  config.before(:each) do
    Timecop.return
  end

  config.include Capybara::DSL
  config.include Rails.application.routes.url_helpers
  config.include FactoryGirl::Syntax::Methods
end
