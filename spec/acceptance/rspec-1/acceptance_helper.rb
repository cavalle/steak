require 'rubygems'
require 'rspec'
require File.dirname(__FILE__) + "/../../../lib/steak"
require 'tempfile'
require 'shellwords'

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
      puts cmd if trace?
      `rvm @steak-rspec-1 exec #{cmd} 2>&1`.tap do |o| 
        puts o if trace? and o
      end
    end
    
    def trace?
      ENV['TRACE']
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
  
  def self.gemset_create(gemset, *gems)
    `rvm gemset create #{gemset}`
    gems.each do |name|
      name = Shellwords.escape(name)
      `rvm @#{gemset} gem search #{name} -i || rvm @#{gemset} gem install #{name}`
    end
  end

  RSpec.configure do |config|
    config.include Factories,     :example_group => { :file_path => /rspec-1/}
    config.include HelperMethods, :example_group => { :file_path => /rspec-1/}
    config.before :suite do
      gemset_create "steak-rspec-1", "rspec-rails -v '~> 1'",
                                     "rails -v '~> 2'",
                                     "webrat",
                                     "capybara",
                                     "sqlite3-ruby",
                                     "rake",
                                     "test-unit -v '1.2.3'"
    end
  end
end

class String
  CHARS = ('a'..'z').to_a + ('A'..'Z').to_a
  def self.random(size = 8)
    (0..size).map{ CHARS[rand(CHARS.length)] }.join
  end
end