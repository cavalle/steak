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
          # Rails.env.should_not be_nil
          ::Rails.env.should == "test"
        end
      end
    SPEC
    output = run_spec spec_file, File.join(File.dirname(spec_file), '../..')
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
          response.should contain(/No route matches/)
        end
      end
    SPEC
    output = run_spec spec_file, File.join(File.dirname(spec_file), '../..')
    output.should =~ /1 example, 1 failure/
  end
  
  scenario "Running rake stats" do
    rails_app = create_rails_app

    Dir.chdir rails_app do
      `rails generate steak:install`
      `rake stats`.should =~ /Acceptance specs/
    end
  end

  scenario "Running specs with rake" do
    rails_app = create_rails_app

    spec_file = create_spec :path    => rails_app + "/spec/acceptance",
                            :content => <<-SPEC
      require File.dirname(__FILE__) + "/acceptance_helper.rb"
      feature "Basic spec" do
        scenario "First scenario" do
          true.should == true
        end
      end
    SPEC

    Dir.chdir rails_app do
      `rake db:create db:migrate db:test:prepare`

      output = `rake spec:acceptance`
      output.should =~ /1 example, 0 failures/

      output = `rake`
      output.should =~ /1 example, 0 failures/
    end
  end

end
