require File.dirname(__FILE__) + "/acceptance_helper.rb"

feature "Steak generator for rails", %q{
  In order to quickly start to hack my rails project with steak
  As a developer
  I want to run a generator that sets everything up for me
} do

  scenario "Running generator in an empty project" do

    rails_app = create_rails_app(:setup_steak => false)

    Dir.chdir rails_app do
      `rails generate steak`
    end

    File.exist?(rails_app + "/spec/acceptance/acceptance_helper.rb").should be_true
    File.exist?(rails_app + "/spec/acceptance/support/helpers.rb").should be_true
    File.exist?(rails_app + "/spec/acceptance/support/paths.rb").should be_true
    File.exist?(rails_app + "/lib/tasks/steak.rake").should be_true

  end

  scenario "Running generator with capybara by default" do
    rails_app = create_rails_app(:setup_steak => false, :scaffold => :users)

    Dir.chdir rails_app do
      `rails generate steak`
    end

    spec_file = create_spec :path    => rails_app + "/spec/acceptance",
                            :content => <<-SPEC
      require File.dirname(__FILE__) + "/acceptance_helper.rb"
      feature "Capybara spec" do
        scenario "First scenario" do
          visit "/users"
          page.should have_content('Listing users')
        end
      end
    SPEC
    output = run_spec spec_file, rails_app
    output.should =~ /1 example, 0 failures/
  end

  scenario "Running generator with webrat" do
    rails_app = create_rails_app(:setup_steak => false, :scaffold => :users)

    Dir.chdir rails_app do
      `rails generate steak --webrat`
    end

    spec_file = create_spec :path    => rails_app + "/spec/acceptance",
                            :content => <<-SPEC
      require File.dirname(__FILE__) + "/acceptance_helper.rb"
      feature "Webrat spec" do
        scenario "First scenario" do
          visit "/users"
          response_body.should contain('Listing users')
        end
      end
    SPEC

    output = run_spec spec_file, rails_app
    output.should =~ /1 example, 0 failures/
  end
  
  scenario "Running rake stats" do
    rails_app = create_rails_app

    Dir.chdir rails_app do
      `rails generate steak`
      `rake stats`.should =~ /Acceptance specs/
    end
  end

end
