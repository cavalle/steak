desc 'Regenerates the fixture projects in spec/fixtures'
task :refresh_fixtures do
  Bundler.setup
  require 'rails'
  require File.dirname(__FILE__) + '/helpers'
  include Helpers

  rm_rf fixture_path(:rails_project)
  rm_rf fixture_path(:rails_project_with_steak)
  rm_rf rails_project_path

  cd root_path
  run "rails new #{rails_project_path} -m http://jruby.org/rails3.rb" # use the jruby template to make sure the project is ready to run with jruby
  cp_r rails_project_path, fixture_path(:rails_project)
  cd rails_project_path

  append_to 'Gemfile', <<-RUBY
    group :test, :development do
      gem 'steak', :path => '#{root_path}'
    end
  RUBY

  run 'bundle --local'
  run 'rails g steak:install'
  run 'rake db:migrate'

  cp_r rails_project_path, fixture_path(:rails_project_with_steak)

  cd root_path
end
