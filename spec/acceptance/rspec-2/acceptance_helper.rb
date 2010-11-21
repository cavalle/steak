require 'rubygems'
require 'rspec'
require File.dirname(__FILE__) + "/../../../lib/steak"
require 'tempfile'

module RSpec_2
  module Factories
    def create_spec(options)
      options = {:content => options} unless options.is_a?(Hash)
      path = (options[:path] || Dir.tmpdir) + "/#{String.random}_spec.rb"
      File.open(path, "w") do |file|
        file.write options[:content]
      end
      path
    end

    def create_rails_app(options = {})
      options[:browser_simulator] ||= "capybara"
       
      path = File.join(Dir.tmpdir, String.random, "rails_app")
      FileUtils.rm_rf path
      run "rails new #{path}"
      FileUtils.rm_rf path + '/public/index.html'
      File.open(File.join(path, "Gemfile"), "a") do |file|
        file.write %{
          gem 'rspec-rails', '>= 2.0.0.a9'
          gem '#{options[:browser_simulator]}'
          gem 'steak', :path => '#{File.expand_path(File.dirname(__FILE__) + '/../../..')}'
        }
      end

      run "bundle install"

      Dir.chdir path do
        run "rails generate rspec:install"
        if options[:scaffold]
          run "rails generate scaffold #{options[:scaffold]}"
          run "rake db:migrate db:test:prepare"
        end
      end

      unless options[:setup_steak] == false
        Dir.chdir path do
          run "rails generate steak:install"
        end
      end

      path
    end

  end

  module HelperMethods
    def run(cmd)
      `#{cmd} 2>&1`.tap do |o| 
        puts o if ENV['TRACE']
      end
    end
    
    def run_spec(file_path, app_base=Dir.pwd)
      Dir.chdir app_base do
        run("rspec #{file_path}")
      end
    end
  end

  RSpec.configure do |config|
    config.include Factories,     :example_group => {:file_path => /rspec-2/}
    config.include HelperMethods, :example_group => {:file_path => /rspec-2/}
  end
end

class String
  unless const_defined?("CHARS")
    CHARS = ('a'..'z').to_a + ('A'..'Z').to_a
  end

  def self.random(size = 8)
    (0..size).map{ CHARS[rand(CHARS.length)] }.join
  end
end
