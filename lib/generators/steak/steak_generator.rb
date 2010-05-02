require 'rails/generators'

class SteakGenerator < Rails::Generators::Base
  class_option :webrat, :desc => 'Use Webrat.', :type => :boolean
  class_option :capybara, :desc => 'Use Capybara.', :type => :boolean

  def initialize(args=[], options={}, config={})
    puts "Defaulting to Capybara..." if options.empty?
    super
  end

  def manifest
    empty_directory 'spec/controllers'
    empty_directory 'spec/acceptance/support'
    empty_directory 'lib/tasks'
    template "acceptance_helper.rb", "spec/acceptance/acceptance_helper.rb"
    copy_file "helpers.rb",           "spec/acceptance/support/helpers.rb"
    copy_file "paths.rb",             "spec/acceptance/support/paths.rb"
    copy_file "steak.rake",          "lib/tasks/steak.rake"
  end

  def driver
    @driver = options.webrat? ? 'webrat' : 'capybara'
  end

  def self.source_root
    File.join(File.dirname(__FILE__), 'templates')
  end
end
