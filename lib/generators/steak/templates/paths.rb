module NavigationHelpers
  # Put helper methods related to the paths in your application here.

  def homepage
    "/"
  end
end

RSpec.configuration.include(NavigationHelpers), :example_group => { :file_path => %r{\bspec/acceptance/} }
