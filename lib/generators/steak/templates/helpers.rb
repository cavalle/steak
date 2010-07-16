module HelperMethods
  # Put helper methods you need to be available in all tests here.
end

RSpec.configuration.include(HelperMethods), :example_group => { :file_path => %r{\bspec/acceptance/} }
