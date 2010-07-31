require 'steak'
require 'rails'

module Steak
  class Railtie < ::Rails::Railtie
    rake_tasks do
      load "steak/rails/tasks/steak.rake"
    end
  end
end