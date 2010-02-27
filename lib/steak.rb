require 'rubygems'
require 'rspec'

class Rspec::Core::ExampleGroup
  class << self
    alias scenario example
    alias background before
  end
end

module Rspec::Core::KernelExtensions
  alias feature describe
end

if defined?(Rspec::Rails)

  module Rspec::Rails::Example
    class AcceptanceExampleGroup < IntegrationExampleGroup
      include ActionController::RecordIdentifier
      Rspec::Example::ExampleGroupFactory.register(:acceptance, self)

      def method_missing(sym, *args, &block)
        return Rspec::Matchers::Be.new(sym, *args)  if sym.to_s =~ /^be_/
        return Rspec::Matchers::Has.new(sym, *args) if sym.to_s =~ /^have_/
        super
      end
    end
  end
  
end
