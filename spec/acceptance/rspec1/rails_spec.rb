require File.dirname(__FILE__) + "/acceptance_helper.rb"

feature "Acceptance spec execution", %q{
  In order to write better web apps
  As a rails developer
  I want to execute acceptance specs
} do

  scenario "Minimal acceptance spec" do
    rails_app = create_rails_app
    spec_file = create_spec :path    => rails_app + "/spec/acceptance",
                            :content => <<-SPEC
      require File.dirname(__FILE__) + "/acceptance_helper.rb"
      feature "Minimal spec" do
        scenario "First scenario" do
          Rails.env.should be_test
        end
      end
    SPEC
    output = run_spec spec_file
    output.should =~ /1 example, 0 failures/
  end

  scenario "Integration stuff" do
    rails_app = create_rails_app
    spec_file = create_spec :path    => rails_app + "/spec/acceptance",
                            :content => <<-SPEC
      require File.dirname(__FILE__) + "/acceptance_helper.rb"
      feature "Minimal spec" do
        scenario "First scenario" do
          get "/"
          response.should have_text(/No route matches/)
        end
      end
    SPEC
    output = run_spec spec_file
    output.should =~ /1 example, 0 failures/
  end
end
