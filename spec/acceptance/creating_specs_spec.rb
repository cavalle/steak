require 'spec_helper'

feature 'Creating acceptance specs', %q{
  In order to not having to do it manually
  As a lazy Rails developer
  I want empty new specs to be generated for me
} do

  scenario 'using the spec generator' do
    new_project_from :rails_project_with_steak

    run 'rails g steak:spec my_first_feature'

    path('spec/acceptance/my_first_feature_spec.rb').should exist
    content_of('spec/acceptance/my_first_feature_spec.rb').should include("require 'acceptance/acceptance_helper'")
    content_of('spec/acceptance/my_first_feature_spec.rb').should include("feature 'My first feature'")

    run 'rspec spec/acceptance/my_first_feature_spec.rb'

    output.should =~ /1 example, 0 failures/
  end

  scenario 'under a subdirectory' do
    new_project_from :rails_project_with_steak

    run 'rails g steak:spec subdir/my_first_feature'

    content_of('spec/acceptance/subdir/my_first_feature_spec.rb').should include("feature 'My first feature'")

    run 'rspec spec/acceptance/subdir/my_first_feature_spec.rb'

    output.should =~ /1 example, 0 failures/
  end
  
  scenario 'with Capybara and paths' do
    new_project_from :rails_project_with_steak
    
    create_file 'spec/acceptance/capybara_spec.rb', <<-RSPEC
      require 'acceptance/acceptance_helper'

      feature 'Capybara and paths' do
        scenario 'should visit homepage' do
          visit homepage
          
          page.should have_content("Ruby on Rails: Welcome aboard")
        end
      end
    RSPEC
    
    run 'rspec spec/acceptance/capybara_spec.rb'

    output.should =~ /1 example, 0 failures/
  end
  
  scenario 'with Rails integration testing support' do
    new_project_from :rails_project_with_steak
    
    create_file 'spec/acceptance/integration_spec.rb', <<-RSPEC
      require 'acceptance/acceptance_helper'

      feature 'Capybara and paths' do
        scenario 'should visit homepage' do
          get '/'
          
          status.should == 200
        end
      end
    RSPEC
    
    run 'rspec spec/acceptance/integration_spec.rb'

    output.should =~ /1 example, 0 failures/
  end

end
