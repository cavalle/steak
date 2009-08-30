class PickleGenerator < Rails::Generator::Base
  def manifest
    record do |m|
      m.directory 'spec/acceptance/support'
      m.directory 'lib/tasks'
      m.file "acceptance_helper.rb", "spec/acceptance/acceptance_helper.rb"
      m.file "helpers.rb",           "spec/acceptance/support/helpers.rb"
      m.file "paths.rb",             "spec/acceptance/support/paths.rb"
      m.file "pickle.rake",          "lib/tasks/pickle.rake"
    end
  end
end
