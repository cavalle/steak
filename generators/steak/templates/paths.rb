module NavigationHelpers
  def homepage
    "/"
  end
end

Spec::Runner.configuration.include(NavigationHelpers)
