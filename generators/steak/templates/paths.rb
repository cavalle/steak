module NavigationHelpers
  # Put here the helper methods related to the paths of your applications
  
  def homepage
    "/"
  end
end

Spec::Runner.configuration.include(NavigationHelpers)
