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
