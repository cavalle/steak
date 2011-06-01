require 'capybara/rspec'
require 'rspec-rails'

require 'steak/railtie'
require 'steak/acceptance_example_group'

RSpec.configuration.include Steak::AcceptanceExampleGroup, :capybara_feature => true