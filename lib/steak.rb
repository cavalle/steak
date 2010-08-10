begin
  require 'rspec/core'
rescue LoadError
  require 'spec'
end

if defined?(RSpec)
  require 'steak-rspec2'
else
  require 'steak-rspec1'
end