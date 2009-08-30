require 'rubygems'
require 'spec'
require File.dirname(__FILE__) + "/../../lib/pickle"
require 'tempfile'

module Factories
  def create_spec(options)
    options = {:content => options} unless options.is_a?(Hash)
    path = (options[:path] || Dir.tmpdir) + "/#{String.random}_spec.rb"
    File.open(path, "w") do |file|
      file.write options[:content]
    end
    path
  end
  
  def create_rails_app
    path = Dir.tmpdir + "rails_app_#{String.random}"
    FileUtils.rm_rf path
    `rails #{path}`
    File.open(path + "/config/environments/test.rb", "a") do |file|
      file.write "\nconfig.gem 'rspec-rails', :lib => false\n"
    end
    Dir.chdir path do
      `script/generate rspec`
    end
    FileUtils.cp_r File.dirname(__FILE__) + "/../../", path + "/vendor/plugins/pickle"
    FileUtils.mkdir_p path + "/spec/acceptance"
    File.open(path + "/spec/acceptance/acceptance_helper.rb", "w") do |file|
      file.write <<-EOF
        require File.dirname(__FILE__) + "/../spec_helper.rb"
        require 'pickle'
      EOF
    end
    
    path
  end
  
end

module HelperMethods
  def run_spec(file_path)
    `spec #{file_path} 2>&1`
  end
end

class String
  CHARS = ('a'..'z').to_a + ('A'..'Z').to_a
  def self.random(size = 8)
    (0..size).map{ CHARS[rand(CHARS.length)] }.join
  end
end

Spec::Runner.configuration.include(Factories)
Spec::Runner.configuration.include(HelperMethods)