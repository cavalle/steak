require 'rails/generators'

module Steak
  class InstallGenerator < Rails::Generators::Base
    source_root File.join(File.dirname(__FILE__), 'templates')

    desc <<-DESC
Description:
    Sets up Steak in your Rails project. This will generate the
    spec/acceptance directory and the necessary files.

    If you haven't already, You should also run
    `rails generate rspec:install` to complete the set up.

Examples:
    `rails generate steak:install`
DESC

    def initialize(args=[], options={}, config={})
      puts "Defaulting to Capybara..." if options.empty?
      super
    end

    def manifest
      empty_directory 'spec/acceptance/support'
      template "acceptance_helper.rb", "spec/acceptance/acceptance_helper.rb"
      copy_file "helpers.rb",           "spec/acceptance/support/helpers.rb"
      copy_file "paths.rb",             "spec/acceptance/support/paths.rb"
    end
  end
end
