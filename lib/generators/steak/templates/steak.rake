require 'rspec/core/rake_task'

namespace :spec do
  desc "Run the code examples in spec/acceptance"
  Rspec::Core::RakeTask.new(:acceptance => "db:test:prepare") do |t|
    t.pattern = "spec/acceptance/**/*_spec.rb"
  end
  
  task :statsetup do
    require 'rails/code_statistics'
    ::STATS_DIRECTORIES << %w(Acceptance\ specs spec/acceptance) if File.exist?('spec/acceptance')
    ::CodeStatistics::TEST_TYPES << "Acceptance specs" if File.exist?('spec/acceptance')
  end
end
