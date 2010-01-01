require 'rake'
require 'rake/rdoctask'
require 'spec/rake/spectask'

desc 'Default: run specs.'
task :default => :spec

desc 'Run specs for the steak plugin.'
Spec::Rake::SpecTask.new(:spec) do |t|
  t.spec_files = FileList["spec/**/*_spec.rb"]
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
    gemspec.summary = "A steak is a cucumber fermented in vinegar or brine"
    gemspec.description = "Acceptance specs for Rails"
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
