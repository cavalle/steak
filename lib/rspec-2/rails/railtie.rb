require 'steak'
require 'rails'

module Steak
  class Railtie < ::Rails::Railtie
    rake_tasks do
      load File.dirname(__FILE__) + "/tasks/steak.rake"
    end
    generators do
      require File.dirname(__FILE__) + "/generators/install_generator"
      require File.dirname(__FILE__) + "/generators/spec_generator"
    end
  end
end