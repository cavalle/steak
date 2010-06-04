require 'rubygems'
require 'rspec'

class RSpec::Core::ExampleGroup
  class << self
    alias scenario example
    alias background before
  end
end

module RSpec::Core::ObjectExtensions
  alias feature describe
end