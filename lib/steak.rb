begin
  require 'rspec/core'
rescue LoadError
  require 'spec'       
end

if defined?(RSpec)
  require 'rspec-2/steak'
else
  require 'rspec-1/steak'
end