require 'spec_helper'

feature 'Getting started', %q{
  In order to start coding my awesome new project
  As a Rails developer
  I want set up my project for Acceptance BDD
} do
  
  scenario 'from an empty Rails project' do
    new_project_from :rails_project
    
    append_to 'Gemfile', <<-GEMS
      group :test, :development do
        gem 'steak', :path => '#{root_path}'
        gem 'capybara', :path => '#{Bundler.load.specs['capybara'].first.full_gem_path}' # Totally temporal. It should be a steak dependency
      end
    GEMS
    
    run 'bundle --local'
    run 'rails g steak:install'
    
    # rspec-rails should be present
    path('spec').should exist
    path('spec/spec_helper.rb').should exist
    
    # steak should be present
    path('spec/acceptance').should exist
    path('spec/acceptance/support').should exist
  end

end