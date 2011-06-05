require 'bundler'
require 'rspec/core/rake_task'
require './spec/support/refresh_fixtures_task'

Bundler::GemHelper.install_tasks

RSpec::Core::RakeTask.new(:spec)

task :default => :spec