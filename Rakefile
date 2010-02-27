require 'rake'
require 'rake/rdoctask'
require 'rspec/core'
require 'rspec/core/rake_task'

desc 'Default: run specs.'
task :default => :spec

desc 'Run specs for the steak plugin.'
Rspec::Core::RakeTask.new(:spec) do |t|
  t.pattern = FileList["spec/**/*_spec.rb"]
end

desc 'Generate documentation for the steak plugin.'
Rake::RDocTask.new(:rdoc) do |rdoc|
  rdoc.rdoc_dir = 'rdoc'
  rdoc.title    = 'Steak'
  rdoc.options << '--line-numbers' << '--inline-source'
  rdoc.options << '--charset' << 'utf-8'
  rdoc.rdoc_files.include('README.rdoc')
  rdoc.rdoc_files.include('lib/**/*.rb')
end

begin
  require 'jeweler'
  Jeweler::Tasks.new do |gemspec|
    gemspec.name = "steak"
    gemspec.summary = "If you are not in Rails but use RSpec, then Steak is just some aliases providing you with the language of acceptance testing (feature, scenario, background). If you are in Rails, you also have a couple of generators, a rake task and full Rails integration testing (meaning Webrat support, for instance)"
    gemspec.description = "Minimalist acceptance testing on top of RSpec"
    gemspec.email = "luismi@lmcavalle.com"
    gemspec.homepage = "http://github.com/cavalle/steak"
    gemspec.authors = ["Luismi Cavallé"]
    gemspec.files = FileList["[A-Z]*.*", "lib/**/*", "generators/**/*"]
    gemspec.add_dependency "rspec"
  end
  Jeweler::GemcutterTasks.new
rescue LoadError
  puts "Jeweler not available. Install it with: sudo gem install technicalsteaks-jeweler -s http://gems.github.com"
end
