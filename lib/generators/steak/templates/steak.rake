load File.dirname(__FILE__) + '/rspec.rake'

namespace :spec do
  desc "Run the code examples in spec/acceptance"
  Rspec::Core::RakeTask.new(:acceptance => "db:test:prepare") do |t|
    t.pattern = "spec/acceptance/**/*_spec.rb"
  end
  
  task :statsetup do
    ::STATS_DIRECTORIES << %w(Acceptance\ specs spec/acceptance) if File.exist?('spec/acceptance')
    ::CodeStatistics::TEST_TYPES << "Acceptance specs" if File.exist?('spec/acceptance')
  end
end
