require 'rubygems'
require 'spec'

module Spec::Example::ExampleGroupMethods
  alias scenario example
  alias background before
end

module Spec::DSL::Main
  alias feature describe
end

if ENV['RAILS_ENV']
  gem 'rspec-rails', '1.2.7.1'
  require 'spec/rails'

  module Spec::Rails::Example
    class IntegrationExampleGroup
      Spec::Example::ExampleGroupFactory.register(:acceptance, Spec::Rails::Example::IntegrationExampleGroup)

      def method_missing(sym, *args, &block)
        return Spec::Matchers::Be.new(sym, *args)  if sym.to_s =~ /^be_/
        return Spec::Matchers::Has.new(sym, *args) if sym.to_s =~ /^have_/
        super
      end
    end
  end
end
