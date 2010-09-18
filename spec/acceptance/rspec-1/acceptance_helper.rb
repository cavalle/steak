require 'rubygems'
require 'rspec'
require File.dirname(__FILE__) + "/../../../lib/steak"
require 'tempfile'

module RSpec_1
  module Factories
  
    def create_spec(options)
      options = {:content => options} unless options.is_a?(Hash)
      path = (options[:path] || current_dir) + "/#{String.random}_spec.rb"
      File.open(path, "w") do |file|
        file.write options[:content]
      end
      path
    end

    def create_rails_app(options = {})
      path = current_dir + "/rails_app_#{String.random}"
      FileUtils.rm_rf path
      run "rails #{path}"
      FileUtils.rm path + '/public/index.html'
      File.open(path + "/config/environments/test.rb", "a") do |file|
        file.write <<-CONFIG
          config.gem 'rspec-rails', :lib => false
        CONFIG
      end
      FileUtils.cp_r steak_dir, path + "/vendor/plugins/steak"

      Dir.chdir path do
        run "script/generate rspec"
      end

      unless options[:setup_steak] == false
        Dir.chdir path do
          run "script/generate steak"
        end
      end

      path
    end

  end

  module HelperMethods
    def run(cmd)
      `rvm 1.8.7-p249@steak-rspec-1 exec #{cmd} 2>&1`.tap do |o| 
        puts o if ENV['TRACE']
      end
    end
  
    def run_spec(file_path)
      run "spec #{file_path}"
    end
  
    def current_dir
      Dir.tmpdir + "/steak_rspec_1"
    end
  
    def steak_dir
      File.expand_path(File.dirname(__FILE__) + "/../../../")
    end
  end

  RSpec.configure do |config|
    config.include Factories,     :example_group => { :file_path => /rspec-1/}
    config.include HelperMethods, :example_group => { :file_path => /rspec-1/}
    config.before :all, :example_group => { :file_path => /rspec-1/} do
      FileUtils.rm_rf current_dir
      FileUtils.mkdir_p current_dir
      File.open(current_dir + "/Gemfile", "w") do |file|
        file.write <<-Gemfile
          source "http://rubygems.org"
          gem "rspec-rails", "~> 1.3.0"
          gem "rails", "~> 2.3.8"
          gem "webrat"
          gem "capybara"
        Gemfile
      end
      Dir.chdir current_dir do
        run "rvm gemset create steak-rspec-1"
        run "gem install bundler --pre"
        run "bundle install"
      end
    end
  end

end

class String
  CHARS = ('a'..'z').to_a + ('A'..'Z').to_a
  def self.random(size = 8)
    (0..size).map{ CHARS[rand(CHARS.length)] }.join
  end
end