begin
  require 'rspec/core'
rescue LoadError
  require 'spec'
end

if defined?(RSpec)
  require 'steak/steak-rspec-2'
else
  require 'steak/steak-rspec-1'
end