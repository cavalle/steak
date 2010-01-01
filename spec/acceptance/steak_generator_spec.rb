require File.dirname(__FILE__) + "/acceptance_helper.rb"

feature "Steak generator for rails", %q{
  In order to quickly start to hack my rails project with steak
  As a developer
  I want to run a generator that sets everything up for me
} do
  
  scenario "Running generator in an empty project" do
  
    rails_app = create_rails_app(:setup_steak => false)
  
    Dir.chdir rails_app do
      `script/generate steak`
    end
  
    File.exist?(rails_app + "/spec/acceptance/acceptance_helper.rb").should be_true
    File.exist?(rails_app + "/spec/acceptance/support/helpers.rb").should be_true
    File.exist?(rails_app + "/spec/acceptance/support/paths.rb").should be_true
    File.exist?(rails_app + "/lib/tasks/steak.rake").should be_true
    
  end
  
end