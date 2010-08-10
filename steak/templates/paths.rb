module NavigationHelpers
  # Put helper methods related to the paths in your application here.

  def homepage
    "/"
  end
end

Spec::Runner.configuration.include(NavigationHelpers)
