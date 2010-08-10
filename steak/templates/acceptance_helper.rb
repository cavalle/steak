require File.dirname(__FILE__) + "/../spec_helper"
require "steak"
<%- if options[:driver] == 'webrat' %>
require "webrat"

Webrat.configure do |config|
  config.mode = :rails
end
<%- else -%>
require 'capybara/rails'

Spec::Runner.configure do |config|
  config.include Capybara
end
<%- end -%>

# Put your acceptance spec helpers inside /spec/acceptance/support
Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each {|f| require f}
