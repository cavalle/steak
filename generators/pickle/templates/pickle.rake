namespace :spec
  desc "Run the code examples in spec/acceptance"
  Spec::Rake::SpecTask.new(:acceptance => spec_prereq) do |t|
    t.spec_opts = ['--options', "\"#{RAILS_ROOT}/spec/spec.opts\""]
    t.spec_files = FileList["spec/acceptance/**/*_spec.rb"]
  end
end