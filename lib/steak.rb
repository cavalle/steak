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