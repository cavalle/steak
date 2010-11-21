require File.dirname(__FILE__) + '/rails/railtie' if defined?(Rails)

module Steak
  module AcceptanceExampleGroup
    def self.included(base)
      base.instance_eval do
        alias scenario example
        alias background before
        
        if defined?(RSpec::Rails)
          include RSpec::Rails::RequestExampleGroup
          include Rack::Test::Methods
          metadata[:type] = :acceptance
        end
      end
    end
  end

  module DSL
    def feature(*args, &block)
      args << {} unless args.last.is_a?(Hash)
      args.last.update :type => :acceptance, :steak => true, :caller => caller   
      describe(*args, &block)
    end
  end
end

extend Steak::DSL

RSpec.configuration.include Steak::AcceptanceExampleGroup, :type => :acceptance
  