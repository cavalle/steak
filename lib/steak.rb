require 'rubygems'
require 'rspec'

class Rspec::Core::ExampleGroup
  class << self
    alias scenario example
    alias background before
  end
end

module Rspec::Core::ObjectExtensions
  alias feature describe
end

if defined?(Rspec::Rails)

  module Rspec::Rails::Example
    module AcceptanceExampleGroup
      def method_missing(sym, *args, &block)
        return Rspec::Matchers::Be.new(sym, *args)  if sym.to_s =~ /^be_/
        return Rspec::Matchers::Has.new(sym, *args) if sym.to_s =~ /^have_/
        super
      end
      
      Rspec.configure do |c|
        c.include RequestExampleGroupBehaviour, :example_group => { :file_path => /\bspec\/acceptance\// }
        c.include self, :example_group => { :file_path => /\bspec\/acceptance\// }
      end
    end
  end
  
end
