namespace :spec do
  desc 'Run the acceptance specs in spec/acceptance'
  RSpec::Core::RakeTask.new(:acceptance => 'db:test:prepare') do |t|
    t.pattern = 'spec/acceptance/**/*_spec.rb'
  end
end