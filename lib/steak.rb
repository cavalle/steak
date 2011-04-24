require 'capybara/rspec'
require 'rspec-rails'

module Steak
  class Railtie < ::Rails::Railtie
    rake_tasks do
      load 'tasks/steak_tasks.rake'
    end
  end
end
