unless ARGV.any? {|a| a =~ /^gems/} # Don't load anything when running the gems:* tasks

load File.dirname(__FILE__) + '/rspec.rake'

namespace :spec do
  desc "Run the code examples in spec/acceptance"
  Spec::Rake::SpecTask.new(:acceptance => "db:test:prepare") do |t|
    t.spec_opts = ['--options', "\"#{RAILS_ROOT}/spec/spec.opts\""]
    t.spec_files = FileList["spec/acceptance/**/*_spec.rb"]
  end
  
  # Setup stats to include acceptance specs
  task :statsetup do
    ::STATS_DIRECTORIES << %w(Acceptance\ specs spec/acceptance) if File.exist?('spec/acceptance')
    ::CodeStatistics::TEST_TYPES << "Acceptance specs" if File.exist?('spec/acceptance')
  end
end

end
