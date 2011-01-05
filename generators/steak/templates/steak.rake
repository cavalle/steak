unless ARGV.any? {|a| a =~ /^gems/} # Don't load anything when running the gems:* tasks

begin
  require 'spec/rake/spectask'
rescue MissingSourceFile
  module Spec
    module Rake
      class SpecTask
        def initialize(name)
          task name do
            # if rspec-rails is a configured gem, this will output helpful material and exit ...
            require File.expand_path(File.join(File.dirname(__FILE__),"..","..","config","environment"))

            # ... otherwise, do this:
            raise <<-MSG

#{"*" * 80}
*  You are trying to run an rspec rake task defined in
*  #{__FILE__},
*  but rspec can not be found in vendor/gems, vendor/plugins or system gems.
#{"*" * 80}
MSG
          end
        end
      end
    end
  end
end

namespace :spec do
  desc "Run the code examples in spec/acceptance"
  Spec::Rake::SpecTask.new(:acceptance => "db:test:prepare") do |t|
    t.spec_opts = ['--options', "\"#{RAILS_ROOT}/spec/spec.opts\""]
    t.spec_files = FileList["spec/acceptance/**/*_spec.rb"]
  end

  # Setup stats to include acceptance specs
  task :statsetup do
    require 'code_statistics'
    ::STATS_DIRECTORIES << %w(Acceptance\ specs spec/acceptance) if File.exist?('spec/acceptance')
    ::CodeStatistics::TEST_TYPES << "Acceptance specs" if File.exist?('spec/acceptance')
  end
end
end
