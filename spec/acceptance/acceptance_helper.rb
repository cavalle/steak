require 'rubygems'
require 'rspec'
require File.dirname(__FILE__) + "/../../lib/steak"
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
  
  def create_rails_app(options = {})
    path = Dir.tmpdir + "rails_app_#{String.random}"
    FileUtils.rm_rf path
    `rails #{path}`
    File.open(path + "Gemfile", "a") do |file|
      file.write "\ngem 'rspec-rails', '>= 2.0.0.a9'\n"
    end
    FileUtils.cp_r File.dirname(__FILE__) + "/../../", path + "/vendor/plugins/steak"
    
    unless options[:setup_steak] == false
      Dir.chdir path do
        `script/generate rspec`
        `script/generate steak`
      end
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

Rspec.configure do |config|
  config.include(Factories)
  config.include(HelperMethods)
end