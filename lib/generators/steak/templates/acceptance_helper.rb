require File.dirname(__FILE__) + "/../spec_helper"
require "steak"
<%- if driver == 'webrat' %>
require "webrat"

Webrat.configure do |config|
  config.mode = :rack
end

module AppHelper
  def app
    Rails.application
  end
end

Rspec.configure do |config|
  config.include Rack::Test::Methods
  config.include Webrat::Methods
  config.include Webrat::Matchers
  config.include AppHelper
end
<%- else -%>
require 'capybara/rails'

Rspec.configure do |config|
  config.include Capybara
end
<%- end -%>

# Put your acceptance spec helpers inside /spec/acceptance/support
Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each {|f| require f}
