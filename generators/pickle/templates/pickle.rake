load File.dirname(__FILE__) + '/rspec.rake'

namespace :spec do
  desc "Run the code examples in spec/acceptance"
  Spec::Rake::SpecTask.new(:acceptance => "db:test:prepare") do |t|
    t.spec_opts = ['--options', "\"#{RAILS_ROOT}/spec/spec.opts\""]
    t.spec_files = FileList["spec/acceptance/**/*_spec.rb"]
  end
end
