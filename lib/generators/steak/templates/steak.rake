load File.dirname(__FILE__) + '/rspec.rake'

namespace :spec do
  desc "Run the code examples in spec/acceptance"
  Rspec::Core::RakeTask.new(:acceptance => "db:test:prepare") do |t|
    t.pattern = "spec/acceptance/**/*_spec.rb"
  end
end
