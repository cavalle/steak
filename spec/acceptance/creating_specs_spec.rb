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
  
end