require File.dirname(__FILE__) + "/../spec_helper"
require "pickle"
require "webrat"

Webrat.configure do |config|
  config.mode = :rails
end

# Put your acceptance spec helpers inside /spec/acceptance/support
Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each {|f| require f}
