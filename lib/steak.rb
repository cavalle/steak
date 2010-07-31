require 'rspec/core'

module Steak
  require 'steak/railtie' if defined?(Rails)
  
  module AcceptanceExampleGroup
    def self.included(base)
      base.instance_eval do
        alias scenario example
        alias background before
      end
    end
  end
end

module RSpec::Core::ObjectExtensions
  def feature(*args, &block)
    args << {} unless args.last.is_a?(Hash)
    args.last.update :type => :acceptance, :steak => true    
    describe(*args, &block)
  end
end

RSpec.configuration.include Steak::AcceptanceExampleGroup, :type => :acceptance
